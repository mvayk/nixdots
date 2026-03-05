{
  config,
  pkgs,
  lib,
  ...
}:

let
  gdmTheme = pkgs.writeTextFile {
    name = "gdm-glass-theme";
    destination = "/share/gnome-shell/theme/gdm3.css";
    text = ''
        -gtk-icon-style: symbolic;
      #lockDialogGroup {
        background: radial-gradient(ellipse at 30% 40%,
                      rgba(180, 200, 230, 0.18) 0%,
                      rgba(10,  12,  20,  0.82) 70%),
                    radial-gradient(ellipse at 80% 80%,
                      rgba(120, 160, 220, 0.12) 0%,
                      transparent 60%);
        background-color: #0d0f18;
      }

      .login-dialog {
        background:       rgba(255, 255, 255, 0.06);
        border:           1px solid rgba(255, 255, 255, 0.14);
        border-radius:    24px;
        box-shadow:       0 8px 48px rgba(0, 0, 0, 0.55),
                          inset 0 1px 0 rgba(255, 255, 255, 0.12);
        padding:          48px 40px;
        /* Mutter/Shell must have blur-behind enabled for backdrop-filter */
        color:            rgba(240, 244, 255, 0.92);
      }

      .login-dialog-user-list {
        spacing: 12px;
      }

      .login-dialog-user-list-item {
        border-radius:    16px;
        padding:          10px 14px;
        transition:       background 200ms ease;
      }

      .login-dialog-user-list-item:hover,
      .login-dialog-user-list-item:focus {
        background: rgba(255, 255, 255, 0.09);
        border:     1px solid rgba(255, 255, 255, 0.18);
      }

      .login-dialog-user-list-item:selected {
        background: rgba(160, 195, 255, 0.15);
        border:     1px solid rgba(160, 195, 255, 0.30);
      }

      .login-dialog-username-label {
        color:       rgba(230, 238, 255, 0.95);
        font-size:   15px;
        font-weight: 500;
      }

      .login-dialog-prompt-label {
        color:       rgba(180, 200, 240, 0.75);
        font-size:   12px;
        font-weight: 400;
        letter-spacing: 1.5px;
        text-transform: uppercase;
      }

      .login-dialog-prompt-entry {
        background:    rgba(255, 255, 255, 0.07);
        border:        1px solid rgba(255, 255, 255, 0.16);
        border-radius: 12px;
        color:         rgba(230, 238, 255, 0.95);
        font-size:     14px;
        padding:       12px 16px;
        caret-color:   rgba(160, 195, 255, 0.9);
        transition:    border 150ms ease, background 150ms ease;
      }

      .login-dialog-prompt-entry:focus {
        background: rgba(255, 255, 255, 0.11);
        border:     1px solid rgba(160, 195, 255, 0.45);
        box-shadow: 0 0 0 3px rgba(120, 170, 255, 0.12);
      }

      .login-dialog-button {
        background:    rgba(160, 195, 255, 0.15);
        border:        1px solid rgba(160, 195, 255, 0.28);
        border-radius: 12px;
        color:         rgba(220, 235, 255, 0.95);
        font-size:     13px;
        font-weight:   500;
        padding:       10px 24px;
        transition:    background 150ms ease, box-shadow 150ms ease;
      }

      .login-dialog-button:hover {
        background: rgba(160, 195, 255, 0.25);
        box-shadow: 0 4px 20px rgba(100, 160, 255, 0.20);
      }

      .login-dialog-button:active {
        background: rgba(160, 195, 255, 0.35);
      }

      .user-icon {
        border:        2px solid rgba(255, 255, 255, 0.18);
        border-radius: 50%;
        box-shadow:    0 4px 24px rgba(0, 0, 0, 0.40),
                       0 0 0 4px rgba(255, 255, 255, 0.05);
      }

      .login-dialog-message-label {
        color:       rgba(255, 160, 140, 0.90);
        font-size:   12px;
        font-weight: 400;
      }

      .clock {
        color:         rgba(220, 232, 255, 0.88);
        font-size:     64px;
        font-weight:   200;
        text-shadow:   0 2px 24px rgba(0, 0, 0, 0.50);
      }

      .clock-label {
        color:         rgba(180, 200, 240, 0.65);
        font-size:     16px;
        font-weight:   300;
        letter-spacing: 3px;
        text-transform: uppercase;
      }

      .login-dialog-sessionlist-button,
      .login-dialog-notlistlisted-button {
        background:    rgba(255, 255, 255, 0.05);
        border:        1px solid rgba(255, 255, 255, 0.10);
        border-radius: 10px;
        color:         rgba(200, 216, 255, 0.75);
        padding:       8px 14px;
        transition:    background 150ms ease;
      }

      .login-dialog-sessionlist-button:hover,
      .login-dialog-notlistlisted-button:hover {
        background: rgba(255, 255, 255, 0.10);
        color:      rgba(220, 235, 255, 0.95);
      }
    '';
  };
in
{
  services.xserver.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
    settings = {
      greeter = {
        IncludeAll = true;
      };
    };
  };

  environment.etc = {
    "gdm/gdm3.css".source = "${gdmTheme}/share/gnome-shell/theme/gdm3.css";
  };

  environment.systemPackages = with pkgs; [
    gnome-shell
    adwaita-icon-theme
  ];
}
