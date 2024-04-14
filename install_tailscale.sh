#!/bin/sh

# Set script variables
TAILSCALE_DOWNLOAD_BASE_URL="https://pkgs.tailscale.com/stable/tailscale_"
TAILSCALE_CONFIG_PATH="/opt/etc/init.d/S06tailscaled"

# Install required packages
opkg update
opkg install ca-bundle

# Prompt the user to select a version
echo "Enter the version you want to install (e.g., 1.64.0):"
read -r VERSION

# Prompt the user to select an architecture
echo "Select the architecture (e.g., arm, arm64):"
echo "1. arm"
echo "2. arm64"
read -r ARCH_OPTION
case "$ARCH_OPTION" in
    1)
        ARCH_SUFFIX="arm"
        ;;
    2)
        ARCH_SUFFIX="arm64"
        ;;
    *)
        echo "Invalid option. Please select 1 or 2."
        exit 1
        ;;
esac

# Prompt the user to specify the USB name or full path
echo "Specify the name of USB (storage name):"
read -r USB_PATH

# Determine the Entware path based on the user's input
ENTWARE_PATH="/tmp/mnt/$USB_PATH"

# Construct the download link based on the selected version and architecture
TAILSCALE_DOWNLOAD_URL="${TAILSCALE_DOWNLOAD_BASE_URL}${VERSION}_${ARCH_SUFFIX}.tgz"

# Download and extract Tailscale binaries
echo "Downloading and installing Tailscale version $VERSION for $ARCH_SUFFIX..."
mkdir -p "/tmp/mnt/$USB_PATH"
curl -sL "$TAILSCALE_DOWNLOAD_URL" | tar -xzf - -C "/tmp/mnt/$USB_PATH"

# Extract the downloaded archive and move necessary files
mv "/tmp/mnt/$USB_PATH/tailscale_${VERSION}_${ARCH_SUFFIX}/tailscale" "/tmp/mnt/$USB_PATH/entware/bin/"
mv "/tmp/mnt/$USB_PATH/tailscale_${VERSION}_${ARCH_SUFFIX}/tailscaled" "/tmp/mnt/$USB_PATH/entware/bin/"
rm -rf "/tmp/mnt/$USB_PATH/entware/bin/tailscale_${VERSION}_${ARCH_SUFFIX}"

# Update the Tailscale configuration
echo "Updating Tailscale configuration..."
sed -i "s|ARGS=.*|ARGS=\"-tun=userspace-networking -statedir /opt/var/tailscale/\"|" "$TAILSCALE_CONFIG_PATH"


# Check for the latest version and validate the architecture
echo "Checking for the latest Tailscale version and validating the architecture..."
tailscale update

# Authenticate Tailscale
echo "Authenticating Tailscale..."
tailscale up

# Prompt the user to add their routes
echo "Enter your routes (e.g., 192.168.0.0/24,192.168.1.0/24):"
read -r ROUTES
tailscale up --accept-routes --advertise-routes="$ROUTES"

echo "Tailscale installation and configuration completed successfully!"
