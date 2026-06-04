{ pkgs, lib, ... }:
{
  services.wayle = {
    enable = true;

    # tip: you can automatically translate your TOML config to Nix by running
    # nix-instantiate --eval --expr 'builtins.fromTOML (builtins.readFile ./config.toml)' | nixfmt
    #cd ~/.config/wayle
    #nix-instantiate --eval --expr '(builtins.fromTOML (builtins.readFile ./config.toml)) // (builtins.fromTOML (builtins.readFile ./runtime.toml))' | nixfmt

    settings = {
      bar = {
        background-opacity = 0;
        layout = [
          {
            center = [
              "media"
              "clock"
            ];
            left = [
              "niri-workspaces"
              "hyprland-workspaces"
            ];
            monitor = "*";
            right = [
              "battery"
              "bluetooth"
              "network"
              "microphone"
              "volume"
              "dashboard"
            ];
            show = true;
          }
        ];
        rounding = "sm";
        scale = 0.9;
      };

      general = {
        font-mono = "JetBrainsMono Nerd Font Mono";
        font-sans = "JetBrainsMono Nerd Font";
      };

      modules = {
        clock = {
          dropdown-show-seconds = false;
          format = "%H:%M:%S";
        };
      };

      styling = {
        matugen-scheme = "rainbow";
        palette = {
          bg = "#1e2030";
          blue = "#86e1fc";
          elevated = "#2f334d";
          fg = "#c8d3f5";
          fg-muted = "#828bb8";
          green = "#c3e88d";
          primary = "#82aaff";
          red = "#ff757f";
          surface = "#222436";
          yellow = "#ffc777";
        };
      };

      wallpaper = {
        cycling-same-image = true;
      };
    };
  };
  home.packages = with pkgs; [
    awww
  ];
}
