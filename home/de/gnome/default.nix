{ pkgs, lib, ... }:

# ─────────────────────────────────────────────────────────────────────────────
# GNOME macOS Tahoe — Home Manager module
# https://github.com/kayozxo/GNOME-macOS-Tahoe
#
# All dconf values verified against a live dconf dump — no guessing.
#
# ⚠ BEFORE FIRST BUILD: replace both lib.fakeSha256 values.
#   For tahoeRepo:
#     nix-prefetch-url --unpack \
#       https://github.com/kayozxo/GNOME-macOS-Tahoe/archive/refs/tags/v0.6.2.tar.gz
#   For openBarSrc:
#     nix-prefetch-url --unpack \
#       https://github.com/neuromorph/openbar/archive/refs/heads/main.tar.gz
#   On a failed build Nix will also print "got: sha256-..." — paste that in.
# ─────────────────────────────────────────────────────────────────────────────

let
  tahoeRepo = pkgs.fetchFromGitHub {
    owner = "kayozxo";
    repo = "GNOME-macOS-Tahoe";
    rev = "v0.6.2";
    sha256 = "1sp0qnx8fp2f3gpww7lsjpb6spi5zd89cd2n32xcbzgjan71x7aa";
  };

  tahoeTheme = pkgs.runCommandNoCC "tahoe-gtk-theme-0.6.2" { } ''
    mkdir -p $out/share/themes
    cp -r ${tahoeRepo}/gtk/Tahoe-Dark  $out/share/themes/Tahoe-Dark
    cp -r ${tahoeRepo}/gtk/Tahoe-Light $out/share/themes/Tahoe-Light
  '';

  openBarSrc = pkgs.fetchFromGitHub {
    owner = "neuromorph";
    repo = "openbar";
    rev = "main";
    sha256 = "Vz8ofgOAybZ0tcEAnC83Ta9qeLwIqookf9a470WWQx8=";
  };

  # Space Bar workspace label CSS — the full pill styling from the live dump.
  # Declared as a Nix string so it's easy to read and modify.
  spaceBarCSS = ''
    .space-bar {
      -natural-hpadding: 4px;
    }

    .space-bar-workspace-label.active {
      margin: 0 4px;
      background-color: rgba(255,255,255,0.15);
      color: rgba(255,255,255,1);
      border-color: rgba(0,0,0,0);
      font-weight: 700;
      border-radius: 4px;
      border-width: 0px;
      padding: 3px 8px;
    }

    .space-bar-workspace-label.inactive {
      margin: 0 4px;
      background-color: rgba(255,255,255,0.0);
      color: rgba(255,255,255,1);
      border-color: rgba(0,0,0,0);
      font-weight: 700;
      border-radius: 4px;
      border-width: 0px;
      padding: 3px 8px;
    }

    .space-bar-workspace-label.inactive.empty {
      margin: 0 4px;
      background-color: rgba(0,0,0,0);
      color: rgba(255,255,255,0.5);
      border-color: rgba(0,0,0,0);
      font-weight: 700;
      border-radius: 4px;
      border-width: 0px;
      padding: 3px 8px;
    }
  '';

  # TilingShell layout JSON — the 4-layout set from the live dump.
  tilingLayouts = builtins.toJSON [
    {
      id = "Layout 1";
      tiles = [
        {
          x = 0;
          y = 0;
          width = 0.22;
          height = 0.5;
          groups = [
            1
            2
          ];
        }
        {
          x = 0;
          y = 0.5;
          width = 0.22;
          height = 0.5;
          groups = [
            1
            2
          ];
        }
        {
          x = 0.22;
          y = 0;
          width = 0.56;
          height = 1;
          groups = [
            2
            3
          ];
        }
        {
          x = 0.78;
          y = 0;
          width = 0.22;
          height = 0.5;
          groups = [
            3
            4
          ];
        }
        {
          x = 0.78;
          y = 0.5;
          width = 0.22;
          height = 0.5;
          groups = [
            3
            4
          ];
        }
      ];
    }
    {
      id = "Layout 2";
      tiles = [
        {
          x = 0;
          y = 0;
          width = 0.22;
          height = 1;
          groups = [ 1 ];
        }
        {
          x = 0.22;
          y = 0;
          width = 0.56;
          height = 1;
          groups = [
            1
            2
          ];
        }
        {
          x = 0.78;
          y = 0;
          width = 0.22;
          height = 1;
          groups = [ 2 ];
        }
      ];
    }
    {
      id = "Layout 3";
      tiles = [
        {
          x = 0;
          y = 0;
          width = 0.33;
          height = 1;
          groups = [ 1 ];
        }
        {
          x = 0.33;
          y = 0;
          width = 0.67;
          height = 1;
          groups = [ 1 ];
        }
      ];
    }
    {
      id = "Layout 4";
      tiles = [
        {
          x = 0;
          y = 0;
          width = 0.67;
          height = 1;
          groups = [ 1 ];
        }
        {
          x = 0.67;
          y = 0;
          width = 0.33;
          height = 1;
          groups = [ 1 ];
        }
      ];
    }
  ];

in
{
  imports = [
    ../../features/ghostty.nix
    ../../features/fastfetch.nix
  ];

  programs.zsh.initContent = ''
    eval "$(starship init zsh)"
    export NIXOS_DE="gnome"
  '';

  # ── GTK theming ──────────────────────────────────────────────────────────
  gtk = {
    enable = true;
    theme = {
      name = "Tahoe-Dark";
      package = tahoeTheme;
    };
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = "1";
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Class";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # ── Libadwaita / GTK4 override ───────────────────────────────────────────
  xdg.configFile = {
    "gtk-4.0/gtk.css".source = "${tahoeTheme}/share/themes/Tahoe-Dark/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${tahoeTheme}/share/themes/Tahoe-Dark/gtk-4.0/gtk-dark.css";
    "gtk-4.0/assets" = {
      source = "${tahoeTheme}/share/themes/Tahoe-Dark/gtk-4.0/assets";
      recursive = true;
    };
  };

  xdg.dataFile."themes/Tahoe-Dark".source = "${tahoeTheme}/share/themes/Tahoe-Dark";

  # ── Packages ─────────────────────────────────────────────────────────────
  home.packages = with pkgs; [
    gnome-tweaks
    ulauncher
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.gnome-40-ui-improvements
    gnomeExtensions.space-bar
    gnomeExtensions.tiling-shell
    gnomeExtensions.user-themes
    gnomeExtensions.vitals
    # Open Bar installed via activation (see below)
  ];

  # ── Open Bar — writable install ──────────────────────────────────────────
  # Open Bar writes generated CSS to its own directory at runtime.
  # The Nix store is read-only, so we copy it to ~/.local/share instead.
  # home.activation runs after every `nixos-rebuild switch`.
  # The `if [ ! -d ]` guard skips re-copying if already installed;
  # remove the guard and re-switch to force an update.

  home.activation.installOpenBar = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    DEST="$HOME/.local/share/gnome-shell/extensions/openbar@neuromorph"
    if [ ! -d "$DEST" ]; then
      $DRY_RUN_CMD mkdir -p "$(dirname "$DEST")"
      $DRY_RUN_CMD cp -r ${openBarSrc}/openbar@neuromorph "$DEST"
      $DRY_RUN_CMD chmod -R u+w "$DEST"
    fi
  '';

  # ── dconf ─────────────────────────────────────────────────────────────────
  # Every value below is taken verbatim from `dconf dump` on a configured
  # live system. Float precision matches what dconf actually stores.
  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Tahoe-Dark";
      icon-theme = "WhiteSur-dark";
      cursor-theme = "Bibata-Modern-Classic";
      cursor-size = 24;
      font-name = "JetBrainsMono Nerd Font 11";
      document-font-name = "JetBrainsMono Nerd Font 11";
      monospace-font-name = "JetBrainsMono Nerd Font Mono 10";
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      enable-animations = true;
      text-scaling-factor = 1.0;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tahoe-Dark";
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:";
      num-workspaces = 4;
      focus-mode = "sloppy";
      auto-raise = false;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
      edge-tiling = false;
    };

    # ── Shell ───────────────────────────────────────────────────────────────
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        dash-to-dock.extensionUuid
        gnome-40-ui-improvements.extensionUuid
        space-bar.extensionUuid
        tiling-shell.extensionUuid
        user-themes.extensionUuid
        vitals.extensionUuid
        "openbar@neuromorph"
      ];
      favorite-apps = [
        "chromium-browser.desktop"
        "com.mitchellh.ghostty.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };

    # ── Blur My Shell ───────────────────────────────────────────────────────
    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      brightness = 0.6;
      override-background = true;
      pipeline = "pipeline_default";
      sigma = 30;
      static-blur = true;
      style-panel = 0;
    };
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      override-background = false;
      pipeline = "pipeline_default_rounded";
      sigma = 20;
      static-blur = true;
      style-dash-to-dock = 0;
    };
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur = true;
      brightness = 0.6;
      pipeline = "pipeline_default";
      sigma = 30;
      style-components = 3;
    };
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      blur = true;
      brightness = 0.6;
      sigma = 20;
    };
    "org/gnome/shell/extensions/blur-my-shell/menus" = {
      blur = true;
      brightness = 0.6;
      override-background = true;
      sigma = 30;
      static-blur = true;
    };

    # ── Dash to Dock ────────────────────────────────────────────────────────
    "org/gnome/shell/extensions/dash-to-dock" = {
      autohide = true;
      background-color = "rgba(30,30,30,0.45)";
      background-opacity = 0.45;
      custom-background-color = true;
      custom-theme-shrink = true;
      dash-max-icon-size = 48;
      disable-overview-on-startup = true;
      dock-fixed = false;
      dock-position = "BOTTOM";
      extend-height = false;
      height-fraction = 0.9;
      icon-size-fixed = false;
      intellihide = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      preferred-monitor = -2;
      running-indicator-style = "DOTS";
      show-mounts = false;
      show-trash = false;
      transparency-mode = "FIXED";
    };

    # ── Space Bar ───────────────────────────────────────────────────────────
    "org/gnome/shell/extensions/space-bar/behavior" = {
      position = "left";
      show-empty-workspaces = false;
      smart-workspace-names = true;
    };
    "org/gnome/shell/extensions/space-bar/appearance" = {
      active-workspace-background-color = "rgba(255,255,255,0.15)";
      inactive-workspace-background-color = "rgba(255,255,255,0.0)";
      workspace-margin = 4;
      workspaces-bar-padding = 4;
      # The full CSS that produces the pill-shaped workspace labels
      application-styles = spaceBarCSS;
    };

    # ── GNOME 4x UI Improvements ────────────────────────────────────────────
    "org/gnome/shell/extensions/gnome-ui-tune" = {
      hide-search = false;
      increase-thumbnails-size = "200%";
      restore-thumbnails-background = true;
    };

    # ── Tiling Shell ────────────────────────────────────────────────────────
    "org/gnome/shell/extensions/tilingshell" = {
      enable-move-keybindings = true;
      enable-smart-insertion = true;
      top-edge-maximize = true;
      window-use-custom-border-color = false;
      layouts-json = tilingLayouts;
      # Stores the keybinding overrides tilingshell manages itself
      overridden-settings = builtins.toJSON {
        "org.gnome.mutter.keybindings" = {
          toggle-tiled-right = "['<Super>Right']";
          toggle-tiled-left = "['<Super>Left']";
        };
        "org.gnome.desktop.wm.keybindings" = {
          maximize = "['<Super>Up']";
          unmaximize = "['<Super>Down', '<Alt>F5']";
        };
        "org.gnome.mutter" = {
          edge-tiling = "false";
        };
      };
      selected-layouts = [
        [
          "Layout 1"
          "Layout 1"
          "Layout 1"
        ]
        [
          "Layout 1"
          "Layout 1"
          "Layout 1"
        ]
        [
          "Layout 1"
          "Layout 1"
          "Layout 1"
        ]
        [
          "Layout 1"
          "Layout 1"
          "Layout 1"
        ]
      ];
    };

    # ── Vitals ──────────────────────────────────────────────────────────────
    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [
        "_processor_usage_"
        "_memory_usage_"
        "__network-rx_max__"
      ];
      position-in-panel = 0;
      show-battery = false;
      show-fan = false;
      show-memory = true;
      show-network = true;
      show-processor = true;
      show-storage = false;
      show-temperature = true;
      show-voltage = false;
    };

    # ── Open Bar ────────────────────────────────────────────────────────────
    # Exact values from `dconf dump /org/gnome/shell/extensions/openbar/`
    "org/gnome/shell/extensions/openbar" = {
      autofg-bar = true;
      autofg-menu = true;
      bar-type = "Trilands";
      height = 34;
      margin-top = 6;
      panel-bg-alpha = 0.0;
      panel-border = false;
      panel-shadow = true;
      panel-shadow-alpha = 0.3;
      radius-tri = 20;
      tri-bg-alpha = 0.15;
    };

    # ── Background ──────────────────────────────────────────────────────────
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/mvayk/.local/share/backgrounds/2026-02-23-00-44-44-a-macos-catalina-mountains-island-night-cold-stock-5k-6016x6016-4022.jpg";
      picture-uri-dark = "file:///home/mvayk/.local/share/backgrounds/2026-02-23-00-44-44-a-macos-catalina-mountains-island-night-cold-stock-5k-6016x6016-4022.jpg";
      secondary-color = "#000000000000";
    };

  };

  home.sessionVariables = {
    GTK_THEME = "Tahoe-Dark";
  };
}
