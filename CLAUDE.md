# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

A personal Nix flake managing system (NixOS) and user (Home Manager) configuration across several hosts and platforms — NixOS x86_64 desktops/laptops, an aarch64 NixOS VM, macOS (aarch64-darwin), and Pop!_OS as a Home-Manager-only target. There is no application code here; every change is configuration that gets evaluated by Nix and activated on a host.

## Apply / rebuild commands

The repo lives at `~/dev/nix-config`. The `nh` helper is installed via Home Manager (see `home-manager/common.nix`) and is the preferred entrypoint:

```sh
# NixOS system rebuild — uses current hostname to pick the flake output
nh os switch --ask                          # confirm before activating
nh os switch --ask ~/dev/nix-config/.#mir-nixos-thinkpad   # explicit flake ref

# Home Manager
nh home switch --ask
nh home switch -c mir@mir-m4pro-mbp ~/dev/nix-config

# Update inputs (run from repo root)
nix flake update

# Garbage collection
nh clean all     # both system and home profiles
nh clean user
```

When `nh` is unavailable (fresh install, before first switch), fall back to:

```sh
sudo nixos-rebuild switch --flake ~/dev/nix-config/.#mir-nixos-pc
home-manager switch --flake ~/dev/nix-config/.#mir@mir-nixos-pc
```

To inspect what a rebuild *would* change without activating:

```sh
sudo nixos-rebuild build --flake ~/dev/nix-config/.#mir-nixos-thinkpad
nvd diff /run/current-system/ ./result/
```

## Formatting / linting

`nixfmt` and `nixpkgs-fmt` are installed via `home-manager/common.nix`. There is no project-wide formatter config or pre-commit hook — formatting is manual.

## Architecture

### Flake outputs (`flake.nix`)

Two output sets, keyed by host:

- `nixosConfigurations.<host>` — full NixOS systems. Modules: `./nixos/hosts/<host>/configuration-<host>.nix`.
- `homeConfigurations."mir@<host>"` — standalone Home Manager (used on macOS and Pop!_OS, and also on NixOS hosts since Home Manager is *not* imported as a NixOS module here). Modules: `./home-manager/hosts/home-<host>.nix`.

Both pass `inputs` via `specialArgs` / `extraSpecialArgs` so modules can reference flake inputs.

When adding a new host, both an entry in `flake.nix` *and* the corresponding host file under `nixos/hosts/` or `home-manager/hosts/` are required.

### NixOS layout (`nixos/`)

- `nixos/default.nix` — shared system config imported by every host (boot, networking, audio, users, nix settings, desktop env). This is the "common module" for NixOS.
- `nixos/hosts/<host>/configuration-<host>.nix` — host entrypoint. Imports `hardware-configuration.nix`, `../../default.nix`, and any per-host services from `nixos/services/`.
- `nixos/hosts/<host>/hardware-configuration.nix` — generated per machine, **symlinked from `/etc/nixos/hardware-configuration.nix`** via `bin/rename-and-link.sh`. Don't hand-edit; regenerate on the target machine.
- `nixos/services/*.nix` — opt-in service modules (sunshine, gdm, etc.) imported selectively by hosts.

### Home Manager layout (`home-manager/`)

Layered imports — each host file picks its layers:

- `common.nix` — packages, shell (zsh), git, starship, direnv, fonts. Shared by *every* home config.
- `common-linux.nix` — Linux-only additions (nvd, nixd, alacritty, vscode). Imported by Linux home files only.
- `services.nix` — dconf / user services. Linux-only.
- `hosts/home-<host>.nix` — sets `home.username`, `home.homeDirectory`, `home.stateVersion`, picks which layers to import, adds host-specific packages and program configs (e.g. `home-nixos.nix` configures kitty; `home-mac.nix` only imports `common.nix`).

When adding a new program: prefer `home-manager/common.nix` if it should run everywhere, `common-linux.nix` if it's Linux-specific, or the host file if it's truly per-machine. macOS-specific bits go in `home-manager/hosts/home-mac.nix`.

### Helper scripts (`bin/`)

- `rename-and-link.sh <source> <target>` — backs up `source` to `source.orig` and replaces it with a symlink pointing at `target`. Used to bring system-generated files (e.g. `/etc/nixos/hardware-configuration.nix`, `~/.config/home-manager/home.nix`) under repo control. See README for the exact incantations used during initial setup.
- `nvidia-offload`, `sway-launcher-desktop` — referenced from NixOS configs.

## Conventions worth knowing

- Hostnames in `flake.nix` (e.g. `mir-nixos-pc`, `mir-m4pro-mbp`) must match the machine's `networking.hostName` (NixOS) or be passed explicitly to `nh`/`home-manager`.
- `home.stateVersion` and `system.stateVersion` are pinned to `"23.05"` — do not bump them casually; they encode migration state, not "current version."
- `nixpkgs.config.allowUnfree` is set both system-wide (NixOS `default.nix`) and per-user (`home-manager/common.nix`) — unfree packages work in either context.
- Commented-out blocks are common throughout (alternative DEs, disabled services, fish config preserved alongside zsh). Treat them as the user's "off switches" — don't delete them when making unrelated edits.
