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

    services.openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
      };
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
      atuin
      pay-respects
      ripgrep
      fd
      fzf
      jq
      zoxide
      btop
      fastfetch
      tldr
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
      openssh
    ];
  };
}
