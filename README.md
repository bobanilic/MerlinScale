# MerlinScale

This is a script for installing Tailscale on Asus Merlin Routers.

## Prerequisites

- An Asus Merlin Router
- Entware installed (from AMTM)

## Usage

1. Download the `install_tailscale.sh` script from this repository.
2. Make the script executable by running `chmod +x install_tailscale.sh`.
3. Run the script using `./install_tailscale.sh`.
4. Follow the prompts to select the Tailscale version and architecture, and specify the USB storage name.
5. The script will download and install the specified Tailscale version, update the Tailscale configuration, and authenticate Tailscale.
6. When prompted, enter your routes (e.g., 192.168.0.0/24,192.168.1.0/24).

## What the Script Does

The script performs the following steps:

1. Updates the package list and installs the `ca-bundle` package.
2. Prompts you to enter the Tailscale version and architecture, and the USB storage name.
3. Downloads and extracts the specified Tailscale version.
4. Moves the necessary files to the appropriate directories.
5. Updates the Tailscale configuration in `/opt/etc/init.d/S06tailscaled`.
6. Checks for the latest Tailscale version and validates the architecture.
7. Authenticates Tailscale.
8. Prompts you to enter your routes and updates Tailscale with these routes.

After running the script, Tailscale should be installed and configured on your Asus Merlin Router.

## Installation (Manual)

1. Install Entware (from AMTM) and other necessary packages:
    ```
    opkg install ca-bundle
    opkg install tailscale #(tailscale_nohf - use this if you can't install main)
    ```

2. Go to the Tailscale website and download the correct architecture (e.g., ARM, ARM64, x86_64).

3. Extract it and copy the content to update manually:
    ```
    cp /tmp/mnt/USB/FOLDER/tailscale_1.64.0_arm/tailscale /opt/bin/
    cp /tmp/mnt/USB/FOLDER/tailscale_1.64.0_arm/tailscaled /opt/bin/
    ```

4. Edit `/opt/etc/init.d/S06tailscaled` and update your ARGS:
    ```
    ARGS="-tun=userspace-networking -statedir /opt/var/tailscale/"
    ```

## Usage

1. You can run `tailscale update` to check for the latest version and also to make sure that you downloaded the correct architecture (if the architecture was wrong you will get an error).

2. If everything is OK, execute the command `tailscale up` which will generate a link:
    ```
    To authenticate, visit: https://login.tailscale.com/a/XXXXX
    ```
    Visit this link in your browser in order to authenticate and you're done. Alternatively, you can use `tailscale up --auth-key=<your-auth-key>`.

3. Use this command to add your routes:
    ```
    tailscale up --accept-routes --advertise-routes=192.168.0.0/24,192.168.1.0/24 #(make sure to use your subnet)
    ```
    You need to approve them in the Tailscale dashboard.

4. For default commands just type `tailscale` to list, or execute (example): `tailscale start`.

5. In order to use `tailscaled` start/stop/check use this command: `/opt/etc/init.d/S06tailscaled check`.
