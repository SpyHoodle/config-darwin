{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programmingLanguages.rust;
in
{
  options.programmingLanguages.rust = {
    enable = lib.mkEnableOption "Rust toolchain management with rustup";

    cargoHome = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.cargo";
      description = "Directory used by Cargo";
    };

    rustupHome = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.rustup";
      description = "Directory used by rustup";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.rustup ];

    home.sessionPath = [ "${cfg.cargoHome}/bin" ];

    home.sessionVariables = {
      CARGO_HOME = cfg.cargoHome;
      RUSTUP_HOME = cfg.rustupHome;
    };
  };
}
