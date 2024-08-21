# help
default:
  @nix run nixpkgs#just -- --list

# make install-iso
build:
  nix build .#nixosConfigurations.installer.config.formats.install-iso
  # nix build .#iso

# build `kexec` executable
kexecbuild:
  nix build .#nixosConfigurations.installer.config.formats.kexec-bundle
