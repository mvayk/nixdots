{
  config,
  lib,
  pkgs,
  ...
}: {
  options.profiles.dev = lib.mkEnableOption "dev packages";

  config = lib.mkIf config.profiles.dev {
    environment.sessionVariables = {
      CPATH = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}:${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}/x86_64-unknown-linux-gnu:${pkgs.glibc.dev}/include";
      CPLUS_INCLUDE_PATH = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}:${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}/x86_64-unknown-linux-gnu:${pkgs.glibc.dev}/include";
      LIBRARY_PATH = "${pkgs.gcc.cc.lib}/lib:${pkgs.glibc}/lib";
      LD_LIBRARY_PATH = "${pkgs.gcc.cc.lib}/lib:${pkgs.glibc}/lib";
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };

    documentation = {
      enable = true;
      man.man-db.enable = true;
      man.mandoc.enable = false;
      dev.enable = true;
    };

    services = {
      ollama.enable = true;

      emacs = {
        enable = true;
        package = pkgs.emacs;
      };
    };

    programs = {
      #ccache.enable = true;
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
      clippy
      rust-analyzer
      rustc
      cargo
      pkg-config
      openssl
      go
      nil
      nixfmt
      alejandra
      flex
      bison
      ollama
      koboldcpp
      lua-language-server
      stylua
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
      jetbrains.idea
      recaf-launcher
      jasmin
      tree-sitter
      aichat
      opencode
      opencode-desktop
    ];
  };
}
