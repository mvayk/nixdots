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
        libX11
        libXrandr
        libXi
        libXcursor
        libXinerama
        libXrender
        libXtst
        freetype
        freetype.dev
        fontconfig
        yad
        libXxf86vm
        gnumake
        pkg-config
        flex
        bison
        freetype
        freetype.dev
        fontconfig
        libXext
        libXrandr
        libXinerama
        libXcomposite
        libXcursor
        libxkbcommon
        libGL
        libGLU
        libxkbcommon
        libxcb
        libX11
        libXrandr
        libXinerama
        libXcursor
        libXxf86vm
        SDL2
        vulkan-loader
        gnutls
        libpulseaudio
        alsa-lib
        wayland
      ];
    };
  };
}
