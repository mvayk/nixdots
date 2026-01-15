{ config, pkgs, noctalia, quickshell, matugen, ... }:
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
    ];
    home.file = {
        ".config" = {
            source = ./mvayk/.config;
            recursive = true;
        };
    };

    home.pointerCursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
        x11 = {
            enable = true;
        };
    };

    programs.noctalia-shell = {
      enable = true;
      settings = {
        settingsVersion = 0;
        bar = {
          position = "top";
          monitors = [ ];
          density = "default";
          showOutline = false;
          showCapsule = false;
          capsuleOpacity = 1;
          # backgroundOpacity = 0.93;
          backgroundOpacity = 1;
          useSeparateOpacity = false;
          # floating = true;
          floating = false;
          marginVertical = 0.25;
          marginHorizontal = 1.00;
          outerCorners = false;
          exclusive = true;
                widgets = {
                    left = [
                    {
                        id = "ControlCenter";
                        useDistroLogo = true;
                        enableColorization = true;
                        colorizeSystemIcon = "Primary";
                    }
                    {
                        id = "Spacer";
                    }
                    {
                        id = "SystemMonitor";
                    }
                    {
                        id = "Spacer";
                    }
                    {
                        id = "MediaMini";
                    }
                    {
                        id = "AudioVisualizer";
                    }
                    {
                        id = "Spacer";
                    }
                    {
                        id = "Taskbar";
                    }
                    ];
                    center = [
                    {
                        id = "Workspace";

                    }
                    ];
                    right = [
                    {
                        id = "Tray";
                    }
                    {
                        id = "Spacer";
                    }
                    {
                        id = "KeyboardLayout";
                    }
                    {
                        id = "Microphone";
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
                        id = "DarkMode";
                    }
                    {
                        id = "WallpaperSelector";
                    }
                    {
                        id = "Spacer";
                    }
                    {
                        id = "Clock";
                    }
                    ];
                };
            };
        general = {
          avatarImage = "";
          dimmerOpacity = 0.2;
          showScreenCorners = false;
          forceBlackScreenCorners = false;
          scaleRatio = 1;
          radiusRatio = 0;
          # radiusRatio = 0.25;
          iRadiusRatio = 0;
          boxRadiusRatio = 0;
          # boxRadiusRatio = 1;
          screenRadiusRatio = 1;
          animationSpeed = 1;
          animationDisabled = true;
          compactLockScreen = false;
          lockOnSuspend = true;
          showSessionButtonsOnLockScreen = true;
          showHibernateOnLockScreen = false;
          enableShadows = true;
          shadowDirection = "bottom_right";
          shadowOffsetX = 2;
          shadowOffsetY = 3;
          language = "";
          allowPanelsOnScreenWithoutBar = true;
          showChangelogOnStartup = true;
        };
        ui = {
          fontDefault = "JetBrainsMono Nerd Font";
          fontFixed = "JetBrainsMono Nerd Font Mono";
          fontDefaultScale = 1;
          fontFixedScale = 1;
          tooltipsEnabled = true;
          # panelBackgroundOpacity = 0.93;
          panelBackgroundOpacity = 1;
          panelsAttachedToBar = false;
          settingsPanelMode = "detached";
          wifiDetailsViewMode = "grid";
          bluetoothDetailsViewMode = "grid";
          networkPanelView = "wifi";
          bluetoothHideUnnamedDevices = false;
          boxBorderEnabled = false;
        };
        location = {
          name = "Sydney";
          weatherEnabled = true;
          weatherShowEffects = true;
          useFahrenheit = false;
          use12hourFormat = false;
          showWeekNumberInCalendar = false;
          showCalendarEvents = true;
          showCalendarWeather = true;
          analogClockInCalendar = false;
          firstDayOfWeek = -1;
          hideWeatherTimezone = false;
          hideWeatherCityName = false;
        };
        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "timer-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };
        screenRecorder = {
          directory = "";
          frameRate = 60;
          audioCodec = "opus";
          videoCodec = "h264";
          quality = "very_high";
          colorRange = "limited";
          showCursor = true;
          copyToClipboard = false;
          audioSource = "default_output";
          videoSource = "portal";
        };
        wallpaper = {
          enabled = true;
          overviewEnabled = true;
          directory = "/home/mvayk/Pictures/wallpapers/";
          monitorDirectories = [ ];
          defaultWallpaper = "/home/mvayk/Pictures/wallpapers/bay.jpg";
          enableMultiMonitorDirectories = false;
          recursiveSearch = true;
          setWallpaperOnAllMonitors = true;
          fillMode = "crop";
          fillColor = "#000000";
          useSolidColor = false;
          solidColor = "#1a1a2e";
          randomEnabled = false;
          wallpaperChangeMode = "random";
          randomIntervalSec = 300;
          transitionDuration = 1500;
          transitionType = "random";
          transitionEdgeSmoothness = 0.05;
          panelPosition = "follow_bar";
          hideWallpaperFilenames = false;
          useWallhaven = false;
          wallhavenQuery = "";
          wallhavenSorting = "relevance";
          wallhavenOrder = "desc";
          wallhavenCategories = "111";
          wallhavenPurity = "100";
          wallhavenRatios = "";
          wallhavenApiKey = "";
          wallhavenResolutionMode = "atleast";
          wallhavenResolutionWidth = "";
          wallhavenResolutionHeight = "";
        };
        appLauncher = {
          enableClipboardHistory = false;
          autoPasteClipboard = false;
          enableClipPreview = true;
          position = "center";
          pinnedExecs = [ ];
          useApp2Unit = false;
          sortByMostUsed = true;
          terminalCommand = "xterm -e";
          customLaunchPrefixEnabled = false;
          customLaunchPrefix = "";
          viewMode = "list";
          showCategories = true;
          iconMode = "tabler";
          showIconBackground = true;
          ignoreMouseInput = false;
          screenshotAnnotationTool = "";
        };
        controlCenter = {
          position = "close_to_bar_button";
          diskPath = "/";
          shortcuts = {
            left = [
              {
                id = "Network";
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
              enabled = false;
              id = "brightness-card";
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
        systemMonitor = {
          cpuWarningThreshold = 80;
          cpuCriticalThreshold = 90;
          tempWarningThreshold = 80;
          tempCriticalThreshold = 90;
          gpuWarningThreshold = 80;
          gpuCriticalThreshold = 90;
          memWarningThreshold = 80;
          memCriticalThreshold = 90;
          diskWarningThreshold = 80;
          diskCriticalThreshold = 90;
          cpuPollingInterval = 3000;
          tempPollingInterval = 3000;
          gpuPollingInterval = 3000;
          enableDgpuMonitoring = false;
          memPollingInterval = 3000;
          diskPollingInterval = 3000;
          networkPollingInterval = 3000;
          loadAvgPollingInterval = 3000;
          useCustomColors = false;
          warningColor = "";
          criticalColor = "";
          externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
        };
        dock = {
          enabled = false;
          displayMode = "auto_hide";
          backgroundOpacity = 1;
          floatingRatio = 1;
          size = 1;
          onlySameOutput = true;
          monitors = [ ];
          pinnedApps = [ ];
          colorizeIcons = false;
          pinnedStatic = false;
          inactiveIndicators = false;
          deadOpacity = 0.6;
          animationSpeed = 1;
        };
        network = {
          wifiEnabled = true;
          bluetoothRssiPollingEnabled = false;
          bluetoothRssiPollIntervalMs = 10000;
          wifiDetailsViewMode = "grid";
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
        };
        sessionMenu = {
          enableCountdown = true;
          countdownDuration = 10000;
          position = "center";
          showHeader = true;
          largeButtonsStyle = false;
          largeButtonsLayout = "grid";
          showNumberLabels = true;
          powerOptions = [
            {
              action = "lock";
              enabled = true;
            }
            {
              action = "suspend";
              enabled = true;
            }
            {
              action = "hibernate";
              enabled = true;
            }
            {
              action = "reboot";
              enabled = true;
            }
            {
              action = "logout";
              enabled = true;
            }
            {
              action = "shutdown";
              enabled = true;
            }
          ];
        };
        notifications = {
          enabled = true;
          monitors = [ ];
          location = "top_right";
          overlayLayer = true;
          backgroundOpacity = 1;
          respectExpireTimeout = false;
          lowUrgencyDuration = 3;
          normalUrgencyDuration = 8;
          criticalUrgencyDuration = 15;
          enableKeyboardLayoutToast = true;
          saveToHistory = {
            low = true;
            normal = true;
            critical = true;
          };
          sounds = {
            enabled = true;
            volume = 0.5;
            separateSounds = false;
            criticalSoundFile = "";
            normalSoundFile = "";
            lowSoundFile = "";
            excludedApps = "spotify";
          };
        };
        osd = {
          enabled = true;
          location = "right";
          autoHideMs = 2000;
          overlayLayer = true;
          backgroundOpacity = 0.93;
          enabledTypes = [
            0
            1
            2
            4
          ];
          monitors = [ ];
        };
        audio = {
          volumeStep = 5;
          volumeOverdrive = true;
          cavaFrameRate = 30;
          visualizerType = "linear";
          mprisBlacklist = [ ];
          preferredPlayer = "";
          externalMixer = "pwvucontrol || pavucontrol";
        };
        brightness = {
          brightnessStep = 10;
          enforceMinimum = true;
          enableDdcSupport = false;
        };
        colorSchemes = {
          useWallpaperColors = false;
          # useWallpaperColors = true;
          predefinedScheme = "Kanagawa";
          darkMode = true;
          schedulingMode = "off";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          matugenSchemeType = "scheme-content";
        };
        templates = {
          gtk = true;
          qt = true;
          kcolorscheme = true;
          alacritty = false;
          kitty = true;
          ghostty = false;
          foot = false;
          wezterm = false;
          fuzzel = false;
          discord = true;
          pywalfox = false;
          vicinae = false;
          walker = false;
          code = false;
          spicetify = true;
          telegram = false;
          cava = false;
          yazi = false;
          emacs = true;
          niri = false;
          hyprland = true;
          mango = false;
          zed = false;
          helix = false;
          zenBrowser = false;
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
          screenLock = "";
          screenUnlock = "";
          performanceModeEnabled = "";
          performanceModeDisabled = "";
        };
        desktopWidgets = {
          enabled = true;
          gridSnap = false;
          monitorWidgets = [ ];
        };
      };
    };

    home.sessionVariables = {
        XCURSOR_THEME = "Bibata-Modern-Ice";
        XCURSOR_SIZE = "24";
        #QT_QUICK_BACKEND = "software";
    };

    programs.starship = {
        enable = false;
    };

    programs.zsh = {
        oh-my-zsh = {
            theme = "mh";
        };
    };

    gtk = {
        enable = true;
        iconTheme = {
            name = "WhiteSur-dark";
            package = pkgs.whitesur-icon-theme;
        };
        # theme = {
        #     name = "Breeze-Dark";  # or "Breeze" for light
        #     package = pkgs.kdePackages.breeze-gtk;
        # };
    };

    qt = {
        enable = true;
    };

    home.packages = with pkgs; [
        qt6Packages.qt6ct
        libsForQt5.qt5ct
        whitesur-icon-theme
        lxappearance
        kdePackages.qtstyleplugin-kvantum
        kdePackages.breeze-gtk
        catppuccin-qt5ct
        bibata-cursors
        hyprland
        grim
        slurp
        qt6Packages.qtimageformats
        qt6Packages.qtsvg
        matugen.packages.${pkgs.system}.default

        libsForQt5.qtimageformats
        libsForQt5.qtsvg
        libwebp
        libjpeg
        libpng
        librsvg
        wl-clipboard
        hypridle
        kdePackages.breeze
        nwg-look
        quickshell.packages.${pkgs.system}.default
        noctalia.packages.${pkgs.system}.default
    ];
}
