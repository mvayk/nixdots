{ config, pkgs, ... }:

let
  nixDir = ./home/nix;
  
  getNixFiles = dir:
    if builtins.pathExists dir then
      let
        files = builtins.attrNames (builtins.readDir dir);
        isNixFile = name: builtins.match ".*\.nix$" name != null;
        nixFiles = builtins.filter isNixFile files;
      in
      map (name: "${dir}/${name}") nixFiles
    else [];
in
{
  imports = getNixFiles nixDir;

  home.username = "mvayk";
  home.homeDirectory = "/home/mvayk";
  home.stateVersion = "25.05";

  home.file = {
      "mvayk" = {
          source = ./home/mvayk;
          recursive = true;
      };
  };

  programs.git.enable = true;

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    x11 = {
      enable = true;
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  home.packages = with pkgs; [
    tokyo-night-gtk
    qt6ct
    libsForQt5.qt5ct
    lxappearance
    bibata-cursors
    papirus-icon-theme
    zsh
    oh-my-zsh
    eza
    fastfetch
    neovim
    emacs
    tmux
    flameshot
    tor
    tor-browser
    vesktop
    kdePackages.dolphin
    nnn
    i3-gaps
    i3lock
    i3status
    zathura
    feh
    dmenu
    cargo
    xorg.xinput
    acpi
    sysstat
    lm_sensors
    brightnessctl
    pamixer
    iw
    coreutils
    i3blocks
    pavucontrol
    kitty
  ];
}
