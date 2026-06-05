{
  pkgs,
  mshell,
  ...
}:
{
  home.packages = [
    mshell.packages.${pkgs.system}.default
  ];
}
