# Tailscale on Entware

Updated Tailscale Packages for Entware

## Installation

1. Download and install `tailscale*.ipk`. (opkg install tailscale*.ipk)



2. Install the package. After installing, you need to start the `tailscaled` service:

    ```bash
    /opt/etc/init.d/S06tailscaled start
    ```

3. Run `tailscale up` and click on the link to authorize. Alternatively, you can use an auth key:

    ```bash
    tailscale up --auth-key=<your-auth-key>
    ```

    You need to approve them in the Tailscale dashboard.

## Usage

For default commands, just type `tailscale` to list, or execute (for example):


    tailscale version


In order to use `tailscaled` to start, stop, or check, use this command:


    /opt/etc/init.d/S06tailscaled check


## Configuration

To add your routes, use the following command (make sure to use your subnet):


    tailscale up --accept-routes --advertise-routes=192.168.0.0/24,192.168.1.0/24

## DNS

In case u want to run AdguardHome/PiHole alongside tailscale:


    tailscale up --accept-dns=false

