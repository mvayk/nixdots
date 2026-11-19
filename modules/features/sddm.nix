{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = false;
    wayland.enable = true;
    # wayland.compositor = "weston";
    # theme = "sddm-astronaut-theme";
    #extraPackages = [pkgs.kdePackages.qtmultimedia];
  };

  # services.xserver.displayManager.setupCommands = ''
  #   ${pkgs.xorg.xrandr}/bin/xrandr --output DP-4 --mode 2560x1440 --rate 240 || true
  # '';
  #
  # services.libinput.mouse = {
  #   accelProfile = "flat";
  #   accelSpeed = "0";
  # };

  # environment.systemPackages = [
  #   (pkgs.sddm-astronaut.override {embeddedTheme = "pixel_sakura";})
  # ];
}
