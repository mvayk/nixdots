{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    xwayland-satellite

    qt6Packages.qt6ct
    qt6Packages.qtimageformats
    qt6Packages.qtsvg
    libsForQt5.qt5ct
    libsForQt5.qtimageformats
    libsForQt5.qtsvg

    kdePackages.kirigami
    #kdePackages.breeze-gtk
    #kdePackages.breeze
    adw-gtk3
    nwg-look
    lxappearance
    darkly

    libwebp
    libjpeg
    libpng
    librsvg
  ];
}
