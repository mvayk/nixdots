{
  pkgs,
  noctalia,
  ...
}: {
  home.packages = with pkgs; [
    noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    mpvpaper
  ];
}
