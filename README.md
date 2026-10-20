# Nix Darwin config

My minimal nix-darwin configuration for my Apple Silicon Macs `mars`, `pluto`,
and `venus`.

It enables my reusable shell environment through its
nix-darwin and Home Manager modules, and enables other nix-darwin features.

## Programming languages

Rust support is enabled through the `programmingLanguages.rust` Home Manager
module. It installs `rustup` and places `~/.cargo/bin` on `PATH`; rustup
then manages Rust toolchains and Cargo.

Install the stable toolchain after the first activation:

```console
rustup default stable
```

## Installation

Bootstrap the first activation with the pinned nix-darwin version:

```console
sudo nix run .#darwin-rebuild -- switch --flake .
```

Afterwards, `darwin-rebuild` is available normally:

```console
sudo darwin-rebuild switch --flake .
```
