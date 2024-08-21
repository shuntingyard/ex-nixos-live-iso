# help
default:
  @nix run nixpkgs#just -- --list
build:
  nix build .#iso
