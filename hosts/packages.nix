{
  pkgs,
  pkgs-stable,
  zen-browser,
  spicetify-nix,
  helium,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
    neovim-unwrapped
    neovide
    file
    tree
    sops

    ghostty
    zsh
    oh-my-zsh
    tmux

    bat
    eza
    ripgrep
    fd
    fzf
    jq
    zoxide
    zed-editor
    btop
    htop
    fastfetch
    tldr

    mpv
    ffmpeg
    yt-dlp
    # imagemagick < memory leak noctalia?
    cheese
    kdePackages.kdenlive

    libreoffice-qt-fresh
    zathura
    foliate
    texlive.combined.scheme-medium

    zen-browser.packages.${pkgs.system}.beta
    helium.packages.${system}.default
    chromium
    qutebrowser

    vesktop

    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-extras
    nautilus
    gparted
    kdePackages.ark
    unar
    unzip
    p7zip
    rar
    jq
    poppler-utils
    ffmpegthumbnailer

    keepassxc
    trilium-desktop
    rnote

    krita
    audacity
    #gimp2-with-plugins

    osu-lazer-bin
    prismlauncher
    /*
      (
        heroic.override
        {
          extraPkgs =
            ps:
            with ps; [
              gamescope
              gamemode
            ];
        }
      )
    */
    (pkgs-stable.lutris.override {
      extraPkgs = pkgs: [
        gamemode
      ];
    })
    xdotool
    xwininfo
    mangohud
    protonup-rs
    protonup-qt
    protontricks

    aider-chat
    ollama
    koboldcpp
    #mistral-vibe

    networkmanagerapplet
    inetutils
    dnsmasq
    tor
    tor-browser
    qbittorrent
    catgirl
    linux-wallpaperengine

    qmk
    via

    ghidra
    radare2
    binaryninja-free
    #cutter
    rizin
    gdb
    gef
    strace
    ltrace
    binwalk
    imhex
    scanmem
    pince
    volatility3
    gnupg
    age
    frida-tools

    /*
      > ***
      > Unfortunately, we cannot download file ida-free-pc_92_x64linux.run automatically.
      > Please go to https://my.hex-rays.com/dashboard/download-center/installers/release/9.2/ida-free to download it yourself, and add it to the Nix store
      > using either
      >   nix-store --add-fixed sha256 ida-free-pc_92_x64linux.run
      > or
      >   nix-prefetch-url --type sha256 file:///path/to/ida-free-pc_92_x64linux.run
      >
      > ***
    */
    #ida-free

    qemu
    pkgs-stable.wineWowPackages.stable
    winetricks
    steamtinkerlaunch
    vinegar

    bottom
    dust
    procs

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
    flex

    libfaketime

    lua-language-server
    python3Packages.python-lsp-server

    python3
    python3Packages.pynvim
    nodejs
    /*
      nodePackages.npm
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
    */
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
    wayland
    wayland-protocols
    libxkbcommon
    glibc
    glib

    usbutils
    acpi
    inxi
    sysstat
    lm_sensors
    brightnessctl
    pamixer
    iw
    pulseaudio
    pavucontrol
    wl-clipboard
    xclip
    xinput
    libnotify
    libsecret
    pinentry-gnome3
    mission-center
    openrgb-with-all-plugins
    alarm-clock-applet
    termdown
    ani-cli
    scrcpy
    android-tools
    gparted

    kdePackages.kmines
    kdePackages.kolourpaint
    kdePackages.kpat
    kdePackages.kleopatra
    kdePackages.kdenetwork-filesharing
    kdePackages.discover
    #ace-of-penguins

    gnome-calendar
    gnome-weather
    epiphany
    gnome-keyring
    seahorse

    nmap
    hollywood

    (sddm-astronaut.override {
      embeddedTheme = "hyprland_kath";
    })

    man-pages
    man-pages-posix
    mousepad
    vscodium
    emacs
    cmus
    more
    most
    yad
    zenity
    qalculate-qt
    nnn
    feh
    dmenu
    samba
    cifs-utils
    lazygit
    starship
    ispell

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

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.victor-mono
    nerd-fonts.space-mono
    nerd-fonts.symbols-only
    noto-fonts-cjk-sans
    nerd-fonts._3270
    nerd-fonts.terminess-ttf
    nerd-fonts.bigblue-terminal
  ];
}
