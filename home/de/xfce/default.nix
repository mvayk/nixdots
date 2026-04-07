{ pkgs, ... }:
{
  imports = [
    ../../features/fastfetch.nix
  ];

  programs.zsh.initContent = ''
    eval "$(starship init zsh)"
    export NIXOS_DE="xfce"
  '';

  home.packages = with pkgs; [
    xfce4-pulseaudio-plugin
    xfce4-whiskermenu-plugin
    xfce.xfce4-docklike-plugin
    xclip
    lxappearance
    redshift
    geoclue2
    libxrandr
  ];
}
