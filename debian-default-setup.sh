#!/bin/bash

set -e

# Ensure script is run as a user with sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo!"
  exit 1
fi

# Update and install essential packages
apt update
apt install -y fish command-not-found tldr wget curl

# Ensure tldr directory exists to avoid errors
sudo -u "$CURRENT_USER" mkdir -p /home/"$CURRENT_USER"/.local/share/tldr

# Update tldr cache
echo "Updating tldr cache..."
sudo -u "$(logname)" tldr --update

# Download and install latest Fastfetch .deb
FF_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest \
  | grep "browser_download_url.*amd64.deb" \
  | cut -d '"' -f 4)

echo "Downloading Fastfetch from: $FF_URL"
wget -q "$FF_URL" -O /tmp/fastfetch.deb
apt install -y /tmp/fastfetch.deb
rm /tmp/fastfetch.deb


# Set fish as default shell for the current user
CURRENT_USER=$(logname)
chsh -s /usr/bin/fish "$CURRENT_USER"

# Ensure fish config directory exists
sudo -u "$CURRENT_USER" mkdir -p /home/"$CURRENT_USER"/.config/fish

# Add alias and fastfetch to fish config
CONFIG_PATH="/home/$CURRENT_USER/.config/fish/config.fish"
{
  echo "alias ll='ls -lah'"
  echo "fastfetch"
  echo "set -g fish_greeting 'The time is (set_color yellow)(date +%T)(set_color normal) and this machine is called $hostname'"
} >> "$CONFIG_PATH"

cat << 'EOF' >> "$CONFIG_PATH"

function fish_greeting
    echo Hello friend!
    echo The time is (set_color yellow)(date +%T)(set_color normal) and this machine is called $hostname
end
EOF


chown "$CURRENT_USER":"$CURRENT_USER" "$CONFIG_PATH"

echo "Setup complete. Please log out and back in to use fish as your default shell."

# Optional: Install Oh My Fish for enhanced fish shell experience
# If the user selected the menu option, install OMF
if [ "$1" == "--install-omf" ]; then
  sudo -u "$CURRENT_USER" curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
  echo "Oh My Fish installed successfully."
fi