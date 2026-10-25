{
  pkgs,
  lib,
  config,
  inputs,
  gslapper,
  ...
}: {
  home.packages = with pkgs; [
    gslapper.packages.${pkgs.stdenv.hostPlatform.system}.gslapper
  ];
}
