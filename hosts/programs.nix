{
  pkgs,
  pkgs-stable,
  zen-browser,
  spicetify-nix,
  ...
}:
{
  programs = {
    seahorse.enable = true;

    ssh.askPassword = pkgs.lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

    ccache.enable = true;

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-qt;
    };

    zsh.enable = true;
    neovim.defaultEditor = true;
    dconf.enable = true;
    firefox.enable = true;
    nix-ld.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    virt-manager.enable = true;

    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    gamescope.enable = true;
    gamemode.enable = true;

    obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override {
        cudaSupport = false;
      };
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    };

    spicetify =
      let
        spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
          shuffle
        ];
        enabledCustomApps = with spicePkgs.apps; [
          newReleases
          ncsVisualizer
        ];
        enabledSnippets = with spicePkgs.snippets; [
          rotatingCoverart
          pointer
        ];
      };

    nix-ld.libraries = with pkgs; [
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
}
