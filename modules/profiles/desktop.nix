{
  pkgs,
  pkgs-stable,
  lib,
  config,
  zen-browser,
  helium,
  spicetify-nix,
  ...
}: {
  options.profiles.desktop = lib.mkEnableOption "desktop packages";

  config = lib.mkIf config.profiles.desktop {
    programs = {
      seahorse.enable = true;
      ssh.askPassword = pkgs.lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
      zsh.enable = true;
      dconf.enable = true;
      firefox.enable = true;
      virt-manager.enable = true;
      neovim.defaultEditor = true;

      gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-qt;
      };

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
      spicetify = let
        spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in {
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
    };

    environment.systemPackages = with pkgs; [
      ghostty
      zen-browser.packages.${pkgs.system}.beta
      helium.packages.${pkgs.system}.default
      chromium
      qutebrowser
      vesktop
      kdePackages.dolphin
      kdePackages.kio
      kdePackages.kio-extras
      kdePackages.ark
      kdePackages.kolourpaint
      kdePackages.kdenetwork-filesharing
      kdePackages.discover
      gnome-keyring
      seahorse
      qalculate-qt
      obsidian
      #alarm-clock-applet
      qbittorrent
      mission-center
      tor
      tor-browser
      keepassxc
      kdePackages.kleopatra
      gparted
      pkgs-stable.wineWowPackages.stable
    ];
  };
}
