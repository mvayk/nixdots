{ pkgs, quickshell, ... }:
{
  home.packages = [
    quickshell.packages.${pkgs.system}.default
  ];
}
