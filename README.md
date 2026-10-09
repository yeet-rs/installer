# The Yeet Installer

A fast, friendly, and reliable tool to help you use yeet.

The installer is intended to be used as a stick installer. It can also be booted in a virtual machine.

To flash it to a stick, download the .raw file from the releases page.

## Usage

Think of the installer file a normal ISO with some perks. If you ever used Ventoy it will feel similar.
Once you have flashed the Installer onto an USB stick you can mount it and edit the configuration.

In this mounted folder you will find multiple files:

```
modules/ # -> This is the place to define the bootstraping system for your installation
disko/ # -> Place different disk layouts in this directory e.g. One with luks, one for your VMs and one for your RAID server
installer.toml # -> This is the main configuration file of the installer
```

### Presets

In the `installer.toml` you can define different "presets". They define a recipe to build a NixOS system.
Example:

```toml
[[presets]]
modules = ["modules/common.nix", "modules/yeet.nix", "modules/disko.nix", "disko/btrfs-subvolumes.nix"]
description = "Simple btrfs disk setup without luks"
default = true
```

> If you set `default = true` the installer won't prompt you which preset to choose. It will automatically select the first default preset it finds.

The modules defined in the Preset are built and then installed as your NixOS system. If you want to test the installed system in a VM before actually installing it you can do so by running:

```shell
just os modules/common.nix modules/yeet.nix modules/disko.nix disko/btrfs-subvolumes.nix
```

## Updating the installer

After a lot of time has passed it may become inconvenient to install a system that is many generations older than the system you intend to install aftwards. Because of this the installer ships its own npins with the presets. This does not however modify the installer binary itself. Only the version of the Bootstrap system. If you want to install a new version of the installer there is currently no other way than to flash the stick new.

Because the nixpkgs overlayfs is persistent it would be theoritcally possible to create an auto-updating installer in the future.

## Development

Test the installer by running it in a vm:

```shell
just vm
```

If you want to build the installer from source instead of downloading the prepuilt `.raw` you can build it using:

```shell
just build
```
