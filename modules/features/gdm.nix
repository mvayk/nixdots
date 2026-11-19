{...}: {
  services.displayManager.gdm = {
    enable = true;
  };
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${./gdm/flandre-monitors.xml}"
  ];
  programs.dconf.profiles.gdm.databases = [
    {
      settings = {
        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
          speed = 0.0;
        };
        "org/gnome/desktop/peripherals/touchpad".accel-profile = "flat";
      };
    }
  ];

  nixpkgs.overlays = [
    (final: prev: {
      gnome-shell = prev.gnome-shell.overrideAttrs (old: {
        postPatch =
          (old.postPatch or "")
          + ''
            substituteInPlace data/theme/gnome-shell-sass/widgets/_login-lock.scss \
              --replace-fail '#lockDialogGroup {' \
              '#lockDialogGroup { background: url(file://${../styling/wallpaper.png}); background-size: cover; background-repeat: no-repeat;'
          '';
      });
    })
  ];
}
