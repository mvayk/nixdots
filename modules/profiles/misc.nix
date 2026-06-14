{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.profiles.misc = lib.mkEnableOption "misc packages";

  config = lib.mkIf config.profiles.misc {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

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
