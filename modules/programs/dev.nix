{ pkgs, ... }:
{
  programs = {
    ccache.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-qt;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
        openssl
        go
        gcc
        clang
        clang-tools
        glibc
        glibc.dev
        libgcc
        libgit2
        pkg-config
        curl
        raylib
        rustfmt
        rustc
        cargo
        libGL
        libGLU
        mesa
        wayland
        wayland-protocols
        libxkbcommon
        libxcb
        libX11
        libXrandr
        libXi
        libXcursor
        libXinerama
        libXrender
        libXtst
        libXext
        libXcomposite
        libXxf86vm
        freetype
        freetype.dev
        fontconfig
        yad
        gnumake
        flex
        bison
        SDL2
        vulkan-loader
        gnutls
        libpulseaudio
        alsa-lib
        brotli
        unixodbc
        qt6.qtbase
        qt6.qtdeclarative
        qt6.qttools
        kdePackages.qtdeclarative
      ];
    };
  };
}
