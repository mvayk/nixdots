{ config, pkgs, noctalia, quickshell, ... }:
let
    nixDir = ./nix;
    getNixFiles = dir:
    if builtins.pathExists dir then
    let
        files = builtins.attrNames (builtins.readDir dir);
        isNixFile = name: builtins.match ".*\.nix$" name != null;
        nixFiles = builtins.filter isNixFile files;
    in
        map (name: "${dir}/${name}") nixFiles
    else [];
in
{
    imports = getNixFiles nixDir ++ [
        noctalia.homeModules.default
        ../../common/zshrc.nix
    ];

    home.username = "mvayk";
    home.homeDirectory = "/home/mvayk";
    home.stateVersion = "25.05";
    home.file = {
        ".config" = {
            source = ./mvayk/.config;
            recursive = true;
        };
        ".tmux.conf".source = ./mvayk/.tmux.conf;
    };
    programs.git = {
        enable = true;
        userName = "mvayk";
        userEmail = "mvayk@mvayk.mvayk";
    };
    home.pointerCursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
        x11 = {
            enable = true;
        };
    };
    home.sessionVariables = {
        XCURSOR_THEME = "Bibata-Modern-Ice";
        XCURSOR_SIZE = "24";
    };

    gtk = {
        enable = true;
        iconTheme = {
            name = "WhiteSur-dark";
            package = pkgs.whitesur-icon-theme;
        };
        theme = {
            name = "WhiteSur-Dark";
            package = pkgs.whitesur-gtk-theme;
        };
    };

    qt = {
        enable = true;
        platformTheme.name = "gtk3";  # Use GTK theme for Qt apps
        style.name = "adwaita-dark";
    };

    programs.noctalia-shell = {
      enable = true;
      settings = {
        settingsVersion = 16;
        setupCompleted = false;
        bar = {
          position = "top";
          backgroundOpacity = 1;
          monitors = [ ];
          density = "comfortable";
          showCapsule = true;
          floating = false;
          marginVertical = 0.25;
          marginHorizontal = 0.25;
          widgets = {
            left = [
              {
                id = "SystemMonitor";
              }
              {
                id = "ActiveWindow";
              }
              {
                id = "MediaMini";
              }
            ];
            center = [
              {
                id = "Workspace";
                characterCount = 2;
              }
            ];
            right = [
              {
                id = "Tray";
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "Battery";
              }
              {
                id = "Volume";
              }
              {
                id = "Brightness";
              }
              {
                id = "Clock";
              }
              {
                id = "ControlCenter";
              }
            ];
          };
        };
        general = {
          avatarImage = "";
          dimDesktop = true;
          showScreenCorners = false;
          forceBlackScreenCorners = false;
          scaleRatio = 1;
          radiusRatio = 1;
          screenRadiusRatio = 1;
          animationSpeed = 1;
          animationDisabled = true;
          compactLockScreen = false;
          lockOnSuspend = true;
          language = "";
        };
        location = {
          name = "Sydney";
          weatherEnabled = true;
          useFahrenheit = false;
          use12hourFormat = false;
          showWeekNumberInCalendar = false;
          showCalendarEvents = true;
        };
        screenRecorder = {
          directory = "";
          frameRate = 60;
          audioCodec = "opus";
          videoCodec = "h264";
          quality = "very_high";
          colorRange = "limited";
          showCursor = true;
          audioSource = "default_output";
          videoSource = "portal";
        };
        wallpaper = {
          enabled = true;
          directory = "";
          enableMultiMonitorDirectories = false;
          setWallpaperOnAllMonitors = true;
          defaultWallpaper = "~/wallpapers/rosepine.jpg";
          fillMode = "crop";
          fillColor = "#000000";
          randomEnabled = false;
          randomIntervalSec = 300;
          transitionDuration = 1500;
          transitionType = "random";
          transitionEdgeSmoothness = 0.05;
          monitors = [ ];
        };
        appLauncher = {
          enableClipboardHistory = false;
          position = "center";
          backgroundOpacity = 1;
          pinnedExecs = [ ];
          useApp2Unit = false;
          sortByMostUsed = true;
          terminalCommand = "xterm -e";
        };
        controlCenter = {
          position = "close_to_bar_button";
          shortcuts = {
            left = [
              {
                id = "WiFi";
              }
              {
                id = "Bluetooth";
              }
              {
                id = "ScreenRecorder";
              }
              {
                id = "WallpaperSelector";
              }
            ];
            right = [
              {
                id = "Notifications";
              }
              {
                id = "PowerProfile";
              }
              {
                id = "KeepAwake";
              }
              {
                id = "NightLight";
              }
            ];
          };
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = true;
              id = "shortcuts-card";
            }
            {
              enabled = true;
              id = "audio-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];
        };
        dock = {
          displayMode = "always_visible";
          backgroundOpacity = 1;
          floatingRatio = 1;
          onlySameOutput = true;
          monitors = [ ];
          pinnedApps = [ ];
          colorizeIcons = false;
          size = 1;
        };
        network = {
          wifiEnabled = true;
        };
        notifications = {
          doNotDisturb = false;
          monitors = [ ];
          location = "top_right";
          overlayLayer = true;
          respectExpireTimeout = false;
          lowUrgencyDuration = 3;
          normalUrgencyDuration = 8;
          criticalUrgencyDuration = 15;
        };
        osd = {
          enabled = true;
          location = "top_right";
          monitors = [ ];
          autoHideMs = 2000;
          overlayLayer = true;
        };
        audio = {
          volumeStep = 5;
          volumeOverdrive = false;
          cavaFrameRate = 60;
          visualizerType = "linear";
          mprisBlacklist = [ ];
          preferredPlayer = "";
        };
        ui = {
          fontDefault = "JetBrainsMono Nerd Font";
          fontFixed = "JetBrainsMono Nerd Font Mono";
          fontDefaultScale = 1;
          fontFixedScale = 1;
          tooltipsEnabled = true;
          panelsOverlayLayer = true;
        };
        brightness = {
          brightnessStep = 5;
        };
        colorSchemes = {
          useWallpaperColors = false;
          predefinedScheme = "Rosepine";
          darkMode = true;
          matugenSchemeType = "scheme-fruit-salad";
          generateTemplatesForPredefined = true;
        };
        templates = {
          gtk = true;
          qt = true;
          kcolorscheme = true;
          kitty = true;
          ghostty = false;
          foot = false;
          fuzzel = false;
          discord = false;
          discord_vesktop = false;
          discord_webcord = false;
          discord_armcord = false;
          discord_equibop = false;
          discord_lightcord = false;
          discord_dorion = false;
          pywalfox = false;
          enableUserTemplates = false;
        };
        nightLight = {
          enabled = false;
          forced = false;
          autoSchedule = true;
          nightTemp = "4000";
          dayTemp = "6500";
          manualSunrise = "06:30";
          manualSunset = "18:30";
        };
        hooks = {
          enabled = false;
          wallpaperChange = "";
          darkModeChange = "";
        };
        battery = {
          chargingMode = 0;
        };
      };
    };

    home.packages = with pkgs; [
        qt6ct
        libsForQt5.qt5ct
        whitesur-icon-theme
        whitesur-gtk-theme
        lxappearance
        bibata-cursors
        hyprland
        grim
        slurp
        wl-clipboard
        hyprlock
        hypridle
        quickshell
        nwg-look
        noctalia.packages.${system}.default  # Add this line
    ];
}
