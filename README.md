# MerlinScale
Script for installing Tailscale on Asus Merlin Routers

## Installation

1. Install Entware (from AMTM) and other necessary packages:
    ```
    opkg install ca-bundle
    opkg install tailscale #(tailscale_nohf - use this if you can't install main)
    ```

2. Go to the Tailscale website and download the correct architecture (e.g., ARM, ARM64, x86_64). https://pkgs.tailscale.com/stable/#static​

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
