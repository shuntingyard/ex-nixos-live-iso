{pkgs, ...}: {
  imports = [
  ];

  # Enables copy / paste when running in a KVM with spice.
  services.spice-vdagentd.enable = true;

  users.users.nixos.shell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    mkpasswd
    nixpkgs-fmt
    ripgrep
    tree
    xclip # for clipboard support in neovim
  ];

  home-manager.users.nixos = {
    home.stateVersion = "21.11";

    programs = {
      alacritty.enable = true;
      fzf.enable = true; # enables zsh integration by default
      starship.enable = true;

      zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
      };

      neovim = {
        enable = true;
        extraConfig = builtins.readFile ./nvim/init.vim;
      };
    };
  };
}
