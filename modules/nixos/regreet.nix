# WHY CLAUDE
{ pkgs, config, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.regreet}/bin/regreet";
        user = "greeter";
      };
    };
  };

  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = "/etc/nixos/modules/nixos/regreet/fav.jpg";
        fit = "Cover";
      };
      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "Bibata-Original-Classic";
        cursor_theme_size = 24;
        font_name = "JetBrainsMono Nerd Font 13";
        icon_theme_name = "Kora";
      };
    };
    theme.css = ''
      * {
        color: #cdd6f4;
        font-family: "JetBrainsMono Nerd Font", monospace;
      }

      window {
        background-color: #1e1e2e;
      }

      box#main-box {
        background-color: #181825;
        border: 1px solid #313244;
        border-radius: 12px;
        padding: 40px;
        min-width: 380px;
      }

      label#clock {
        color: #cdd6f4;
        font-size: 48px;
        font-weight: bold;
        margin-bottom: 8px;
      }

      label#date {
        color: #a6adc8;
        font-size: 14px;
        margin-bottom: 32px;
      }

      entry {
        background-color: #313244;
        border: 1px solid #45475a;
        border-radius: 8px;
        color: #cdd6f4;
        padding: 10px 14px;
        margin-bottom: 12px;
      }

      entry:focus {
        border-color: #cba6f7;
        box-shadow: none;
      }

      button {
        background-color: #cba6f7;
        color: #1e1e2e;
        border: none;
        border-radius: 8px;
        padding: 10px 20px;
        font-weight: bold;
        margin-top: 8px;
      }

      button:hover {
        background-color: #b4befe;
      }

      button:active {
        background-color: #89b4fa;
      }

      combobox button {
        background-color: #313244;
        color: #cdd6f4;
        border: 1px solid #45475a;
        border-radius: 8px;
      }

      combobox button:hover {
        background-color: #45475a;
      }

      label {
        color: #a6adc8;
        margin-bottom: 4px;
      }
    '';
  };

  environment.pathsToLink = [
    "/share/wayland-sessions"
    "/share/xsessions"
  ];

  environment.systemPackages = with pkgs; [
    cage
    bibata-cursors
    kora-icon-theme
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
