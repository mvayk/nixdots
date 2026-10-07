{
  config,
  pkgs,
  lib,
  machine,
  de,
  theme,
  inputs,
  ...
}: {
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      cursor.size = 24;
      keyboard.layout = "us";
      appearance = {
        scheme = "Synced";
        password_style = "default";
      };
      cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
      };

      outputs =
        if machine == "flandre"
        then {
          "DP-1" = {
            mode = {
              width = 2560;
              height = 1440;
              refresh = 240.001;
            };
            position = {
              x = 0;
              y = 0;
            };
          };
          "DP-2" = {
            mode = {
              width = 2560;
              height = 1440;
              refresh = 240.001;
            };
            position = {
              x = -2560;
              y = 0;
            };
          };
          "DP-3" = {
            mode = {
              width = 2560;
              height = 1440;
              refresh = 240.001;
            };
            position = {
              x = 2560;
              y = -720;
            };
            transform = {
              rotation = 270;
            };
          };
        }
        else {
          "eDP-1" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 144.001;
            };
            position = {
              x = 0;
              y = 0;
            };
          };
        };
    };
  };
}
