{pkgs, ...}: {
  imports = [
  ];

  # enables copy / paste when running in a kvm with spice.
  services.spice-vdagentd.enable = true;

  # comfort
  programs.zsh.enable = true;

  users = {
    users.nixos = {
      shell = pkgs.zsh;
    };

    # TODO  does this list get inherited by installations?
    #       and should we add trusted users for the same reason?
    users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzxB9hDTQD+OeaN72LAT9LYIGYAGtwf+NCSBHVAgn8M" # tobias@guam-2016-12-17
    ];
  };

  # TODO do we need this, or are client-side caps enough?
  services.openssh.enable = true;

  # the only keyboards I have
  #
  # TODO  not all keys work:
  #       why not?
  #       can we live with it?
  console.keyMap = "sg";

  environment.systemPackages = with pkgs; [
    mkpasswd
    nixpkgs-fmt
    ripgrep
    tree
    xclip # TODO should we make this `lemonade` or `doitclient` (both for ssh)?
    bat
  ];

  home-manager.users.nixos = {
    home.stateVersion = "21.11";

    programs = {
      fzf.enable = true; # enables zsh integration by default

      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
      };

      neovim = {
        enable = true;
        extraConfig = builtins.readFile ./nvim/init.vim;
      };
    };

    # templates for partitioning
    home.file.templates = {
      source = ./disko;
      recursive = true;
    };
  };
}
