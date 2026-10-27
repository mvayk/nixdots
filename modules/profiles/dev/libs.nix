{
  pkgs,
  lib,
  config,
  mkSub,
  ...
}: let
  cfg = config.my.dev;
  sw = "/run/current-system/sw";

  coreLibs = with pkgs; [
    openssl
    zlib
    curl
    glib
    libgit2
    gnutls
    brotli
    unixodbc
    freetype
    fontconfig
  ];

  graphicsLibs = with pkgs; [
    libGL
    libGLU
    mesa
    vulkan-loader
    SDL2
    raylib
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
    libpulseaudio
    alsa-lib
  ];
in {
  options.my.dev = {
    libs.core.enable = mkSub cfg.enable "headers/libs in the system profile: openssl, zlib, curl, ...";
    libs.graphics.enable = mkSub (cfg.enable && config.my.desktop.enable) "headers/libs in the system profile: GL, X11, Wayland, SDL2, ...";
    nixld.enable = mkSub cfg.enable "nix-ld (run prebuilt binaries)";
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.libs.core.enable || cfg.libs.graphics.enable) {
      environment = {
        pathsToLink = ["/include" "/lib" "/lib/pkgconfig" "/share/pkgconfig"];
        extraOutputsToInstall = ["dev"];
        sessionVariables = {
          CPATH = ["${sw}/include"];
          LIBRARY_PATH = ["${sw}/lib"];
          PKG_CONFIG_PATH = ["${sw}/lib/pkgconfig" "${sw}/share/pkgconfig"];
        };
      };
    })

    (lib.mkIf cfg.libs.core.enable {environment.systemPackages = coreLibs;})
    (lib.mkIf cfg.libs.graphics.enable {environment.systemPackages = graphicsLibs;})

    (lib.mkIf cfg.nixld.enable {
      programs.nix-ld = {
        enable = true;
        libraries =
          [pkgs.stdenv.cc.cc.lib]
          ++ coreLibs
          ++ lib.optionals config.my.desktop.enable graphicsLibs;
      };
    })
  ];
}
