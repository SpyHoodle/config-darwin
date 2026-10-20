{
  description = "SpyHoodle's macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    shell.url = "github:SpyHoodle/shell";
    shell.inputs.nixpkgs.follows = "nixpkgs";
    shell.inputs.darwin.follows = "darwin";
    shell.inputs.home-manager.follows = "home-manager";
  };

  outputs =
    {
      darwin,
      home-manager,
      shell,
      ...
    }:
    let
      system = "aarch64-darwin";

      mkMacOS =
        username:
        darwin.lib.darwinSystem {
          inherit system;

          modules = [
            shell.darwinModules.default
            home-manager.darwinModules.home-manager
            {
              nix.enable = false;
              nixpkgs.config.allowUnfree = true;

              system = {
                primaryUser = username;
                stateVersion = 5;
              };

              security.pam.services.sudo_local.touchIdAuth = true;

              users.users.${username}.home = "/Users/${username}";

              shellEnvironment.enable = true;

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = {
                  imports = [
                    shell.homeManagerModules.default
                    ./modules/programming-languages.nix
                  ];

                  shellEnvironment = {
                    enable = true;
                    secretive.enable = true;
                  };

                  programmingLanguages.rust.enable = true;

                  home = {
                    inherit username;
                    homeDirectory = "/Users/${username}";
                    stateVersion = "24.11";
                  };
                };
              };
            }
          ];
        };
    in
    {
      apps.${system}.darwin-rebuild = {
        type = "app";
        program = "${darwin.packages.${system}.darwin-rebuild}/bin/darwin-rebuild";
      };

      darwinConfigurations = {
        mars = mkMacOS "maddie";
        pluto = mkMacOS "evelyne";
        venus = mkMacOS "maddie";
      };
    };
}
