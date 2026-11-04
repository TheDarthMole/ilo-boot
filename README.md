# ilo-boot

This app for hosting files so that the HP ILO can use the files as boot drives.

The following guide explains better: https://utsavmurarka.wordpress.com/2017/06/12/booting-from-iso-file-on-remote-computer-via-ilo-console-on-hp-proliant-servers/

I didn't want to mess around with IIS manager, so I made this small app instead.

## Installation

Place your .img and .iso files inside a `public` folder

```bash
mkdir public # Place your .iso and .img files in this folder
wget https://raw.githubusercontent.com/TheDarthMole/ilo-boot/refs/heads/main/compose.yaml
docker compose up -d
```

This will spin up a server on port `8000`.

Simply login to HP ILO, go to "Virtual Media" -> "Virtual Media" and then
paste `http://<server ip>:8080/<filename>` into either the virtual floppy or the CD/DVD-ROM "Scripted Media URL" section

The `<server ip>` is the IP address of the server running ilo-boot

The `<filename>` is the filename of the virtual media.

e.g. `http://192.168.1.133:8000/TrueNAS-SCALE-25.10.7.iso`
