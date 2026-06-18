{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.profiles.dev = lib.mkEnableOption "dev packages";

  config = lib.mkIf config.profiles.dev {
    services = {
      ollama.enable = true;

      emacs = {
        enable = true;
        package = pkgs.emacs;
      };
    };
    programs = {
      ccache.enable = true;
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
          glib
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

    environment.systemPackages = with pkgs; [
      neovim-unwrapped
      neovide
      zed-editor
      vscodium
      emacs
      mousepad
      openjdk21
      openjdk17
      cmake
      gnumake
      gcc
      nasm
      clang
      clang-tools
      rustfmt
      rustc
      cargo
      pkg-config
      openssl
      go
      nil
      nixfmt
      flex
      bison
      aider-chat
      ollama
      koboldcpp
      lua-language-server
      python3Packages.python-lsp-server
      python3
      python3Packages.pynvim
      nodejs
      lua
      luajit
      luarocks
      raylib
      libGL
      libGLU
      mesa
      libX11
      libXrandr
      libXi
      libXcursor
      libXinerama
      libXrender
      libXtst
      libXxf86vm
      libXext
      libXcomposite
      libxcb
      wayland
      wayland-protocols
      libxkbcommon
      glibc
      glib
      libfaketime
      ispell
      freetype
      freetype.dev
      fontconfig
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
}
