{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.profiles.dev = lib.mkEnableOption "misc packages";

  config = lib.mkIf config.profiles.misc {
    environment.systemPackages = with pkgs; [
      qmk
      via
      networkmanagerapplet
      inetutils
      dnsmasq
      qbittorrent
      catgirl
      scrcpy
      android-tools
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
      libsecret
      pinentry-gnome3
      samba
      cifs-utils
      jq
    ];
  };
}
