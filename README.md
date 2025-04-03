# debian-startup

A simple startup script to configure a clean Debian 12 system with a personalized, modern terminal experience.

## Features

This script installs and configures the following:

- `fish` – A user-friendly shell with autosuggestions and syntax highlighting.
- `fastfetch` – A clean and fast system info display (downloaded from GitHub releases).
- `command-not-found` – Helpful suggestions when mistyping commands.
- `tldr` – Simplified man pages for quick command reference (with automatic cache update).
- A default alias: `ll → ls -lah`
- Auto-runs `fastfetch` at shell start.
- Sets `fish` as the default shell for the current user.
- Optionally installs [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish) for themes and plugin support.

---

## Usage

To run the script on a fresh Debian 12 install, use one of the following commands:

### Using `curl`:

`sudo bash <(curl -sSL https://raw.githubusercontent.com/kyleisdork/debian-startup/main/debian-default-setup.sh)`

### Using `wget`:

`sudo bash <(wget -qO- https://raw.githubusercontent.com/kyleisdork/debian-startup/main/debian-default-setup.sh)`

To enhance your fish shell experience with themes and plugins, you can install [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish) by passing the `--install-omf` flag:

`sudo bash <(curl -sSL https://raw.githubusercontent.com/kyleisdork/debian-startup/main/debian-default-setup.sh) --install-omf`

## Notes

- After running the script, **log out and log back in** to start using fish as your default shell. If this isn't working, you may need to reboot.
- `fastfetch` is installed from the [official GitHub releases](https://github.com/fastfetch-cli/fastfetch/releases) to ensure compatibility with Debian 12. On Debian 13, this is an official package.
- The script appends to `~/.config/fish/config.fish`, so it won't overwrite any existing configuration.
