# Tailscale Screen Share

Tiny macOS app: pick a Mac on your tailnet, it opens Screen Sharing to its
Tailscale IP. No more typing `vnc://100.x.y.z` into Finder's Connect to Server.

Reads `tailscale status` live on every launch, so new Macs appear
automatically and your own machine is filtered out.

## Install (on any of your Macs)

```sh
curl -L -o /tmp/tss.zip https://github.com/Kolomaster68/tailscale-screenshare/releases/latest/download/TailscaleScreenShare.app.zip
ditto -x -k /tmp/tss.zip /Applications
xattr -dr com.apple.quarantine "/Applications/Tailscale Screen Share.app"
```

The `xattr` line clears Gatekeeper quarantine (the app is unsigned).

## Requirements

- Tailscale.app installed and connected
- Screen Sharing enabled on the target Mac (System Settings → General → Sharing)

## Build from source

```sh
osacompile -o "/Applications/Tailscale Screen Share.app" screenshare.applescript
swift make_icon.swift icon_1024.png   # then sips/iconutil to make applet.icns
```
