{ pkgs, ... }:
{
  imports = [
    ../../features/ghostty.nix
    ../../features/fastfetch.nix
  ];

  programs.zsh.initContent = ''
    eval "$(starship init zsh)"
    export NIXOS_DE="gnome"
  '';

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      font-name    = "JetBrainsMono Nerd Font 10";
      monospace-font-name = "JetBrainsMono Nerd Font Mono 10";
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
  };

  home.packages = with pkgs; [
    gnome-tweaks
    gnome-extensions-app
    gnome-calendar
    gnome-weather
  ];
}
