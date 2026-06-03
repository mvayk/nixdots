{
  pkgs,
  lib,
  ...
}:
let
  mySDDMTheme = pkgs.sddm-astronaut.override {
    embeddedTheme = "jake_the_dog";
  };
in
{
  services.displayManager = {
    sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [
        mySDDMTheme
        kdePackages.qtmultimedia
        kdePackages.qtsvg
        kdePackages.qtvirtualkeyboard
        kdePackages.kwin
        kdePackages.layer-shell-qt
      ];
      settings = {
        Theme = {
          CursorTheme = "Bibata-Original-Classic";
          CursorSize = 24;
        };
        General = {
          GreeterEnvironment = lib.concatStringsSep "," [
            "QT_WAYLAND_SHELL_INTEGRATION=layer-shell"
            "XCURSOR_THEME=Bibata-Original-Classic"
            "XCURSOR_SIZE=24"
            "XCURSOR_PATH=/run/current-system/sw/share/icons"
          ];
        };
        Wayland = {
          # Removed --drm; let KWin auto-detect the backend for hybrid setups
          CompositorCommand = "kwin_wayland --no-lockscreen --no-global-shortcuts --locale1";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    mySDDMTheme
    bibata-cursors
    wlr-randr
  ];

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "0";
    };
  };

  environment.variables = {
    XCURSOR_THEME = "Bibata-Original-Classic";
    XCURSOR_SIZE = "24";
  };
}
