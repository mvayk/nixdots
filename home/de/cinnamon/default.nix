{
  pkgs,
  theme,
  ...
}: {
  imports = [
    ./theme/${theme}/default.nix
  ];

  home.packages = with pkgs; [
    xclip
    lxappearance
    redshift
    geoclue2
    libxrandr
  ];
}
