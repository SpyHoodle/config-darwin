# macOS config

My minimal nix-darwin configuration for the Apple Silicon Macs `mars`, `pluto`,
and `venus`.

It enables the reusable sibling [`shell`](../shell) environment through its
nix-darwin and Home Manager modules, enables Touch ID for `sudo`, permits unfree
nixpkgs packages, and leaves management of the installed Nix daemon to the Nix
installer.

Bootstrap the first activation with the pinned nix-darwin version:

```console
sudo nix run .#darwin-rebuild -- switch --flake .#mars
```

Afterwards, `darwin-rebuild` is available normally:

```console
sudo darwin-rebuild switch --flake .#mars
```

Replace `mars` with `pluto` or `venus` as needed.
