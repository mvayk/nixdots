{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.my.cli;
in {
  options.my.cli.enable = lib.mkEnableOption "cli tools";

  config = lib.mkIf cfg.enable {
    programs = {
      zsh.enable = true;
      git.enable = true;
    };

    environment.systemPackages = with pkgs; [
      curl
      wget
      vim
      file
      tree
      sops
      age
      zsh
      oh-my-zsh
      tmux
      bat
      eza
      ripgrep
      fd
      fzf
      jq
      zoxide
      btop
      htop
      fastfetch
      tldr
      bottom
      dust
      procs
      nnn
      lazygit
      starship
      more
      most
      man-pages
      man-pages-posix
      termdown
      zip
      unzip
      unar
      p7zip
      rar
      gnupg
      socat
    ];
  };
}
