{
  config,
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
        enable = false;
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
        /*
          General = {
            GreeterEnvironment = lib.concatStringsSep "," [
              "QT_WAYLAND_SHELL_INTEGRATION=layer-shell"
              "QT_SCREEN_SCALE_FACTORS=1;1"
              "QT_FONT_DPI=96"
              "XCURSOR_THEME=Bibata-Original-Classic"
              "XCURSOR_SIZE=24"
              "XCURSOR_PATH=/run/current-system/sw/share/icons"
            ];
          };
        */
        Wayland = {
          CompositorCommand = "kwin_wayland --drm --no-lockscreen --no-global-shortcuts --locale1";
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
