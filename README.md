# ex-nixos-live-iso (forked)

An example of how to build a customized NixOS installer that can run on
any machine with root access thanks to the power of *ssh* and *kexec*.

Build ... with:

```sh
$ nix run nixpkgs#just

```

to see what can be built. But have a look inside the flake too.

All formats built will be in `./result/`

## Goals of this Fork

[x] Reduce output size (trading Calamares' comfort for size)
[x] Build installer in a variety of formats.
[x] Build `kexec-bundle` in order to apply a customized installer **anywhere**.

## From the Original Repo

An example of how to create a custom NixOS live CD/ISO with nix
[flakes](https://nixos.wiki/wiki/Flakes).

If you don't have Nix installed, I recommend using the Determinate Systems Nix
installer (reasons given on the website):

https://zero-to-nix.com/concepts/nix-installer

Build the ISO with:

```sh
$ nix build .#iso
```

The resulting ISO will be in `./result/iso/`
