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
      file
      tree
      sops
      age
      tmux
      bat
      lsd
      ripgrep
      fd
      fzf
      jq
      zoxide
      btop
      fastfetch
      tldr
      bottom
      procs
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
