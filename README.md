# Nix Darwin config

My minimal nix-darwin configuration for my Apple Silicon Macs `mars`, `pluto`,
and `venus`.

It enables my reusable shell environment through its
nix-darwin and Home Manager modules, and enables other nix-darwin features

## Installation

Bootstrap the first activation with the pinned nix-darwin version:

```console
sudo nix run .#darwin-rebuild -- switch --flake .
```

Afterwards, `darwin-rebuild` is available normally:

```console
sudo darwin-rebuild switch --flake .
```
