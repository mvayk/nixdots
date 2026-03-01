{
  config,
  pkgs,
  noctalia,
  quickshell,
  future-hyprcursor,
  lib,
  machine,
  de,
  ...
}:
{
  imports = [
    ../../features/ghostty.nix
    ../../features/fastfetch.nix
    noctalia.homeModules.default
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  programs.noctalia-shell = {
    enable = true;
    settings = {
      settingsVersion = 53;

      bar = {
        barType = "simple";
        position = "top";
        monitors = [ ];
        density = "default";
        showOutline = false;
        showCapsule = false;
        capsuleOpacity = 1;
        capsuleColorKey = "none";
        backgroundOpacity = 0.7;
        useSeparateOpacity = true;
        floating = false;
        marginVertical = 5;
        marginHorizontal = 18;
        frameThickness = 8;
        frameRadius = 12;
        outerCorners = false;
        hideOnOverview = false;
        displayMode = "always_visible";
        autoHideDelay = 500;
        autoShowDelay = 150;

        widgets = {
          left = [
            {
              colorizeDistroLogo = false;
              colorizeSystemIcon = "Primary";
              customIconPath = "";
              enableColorization = true;
              icon = "noctalia";
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              characterCount = 7;
              colorizeIcons = false;
              emptyColor = "secondary";
              enableScrollWheel = true;
              focusedColor = "primary";
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = false;
              iconScale = 0.7;
              id = "Workspace";
              labelMode = "index";
              occupiedColor = "secondary";
              pillSize = 0.6;
              showApplications = true;
              showBadge = true;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 1;
            }
            {
              compactMode = true;
              diskPath = "/";
              iconColor = "none";
              id = "SystemMonitor";
              showCpuFreq = false;
              showCpuTemp = true;
              showCpuUsage = true;
              showDiskAvailable = false;
              showDiskUsage = false;
              showDiskUsageAsPercent = false;
              showGpuTemp = false;
              showLoadAverage = true;
              showMemoryAsPercent = false;
              showMemoryUsage = true;
              showNetworkStats = false;
              showSwapUsage = true;
              textColor = "none";
              useMonospaceFont = true;
              usePadding = false;
            }
            {
              icon = "rocket";
              iconColor = "none";
              id = "Launcher";
            }
            {
              defaultSettings = {
                autoStartBreaks = false;
                autoStartWork = false;
                longBreakDuration = 15;
                sessionsBeforeLongBreak = 4;
                shortBreakDuration = 5;
                workDuration = 25;
              };
              id = "plugin:pomodoro";
            }
            {
              defaultSettings = {
                compactMode = false;
                defaultDuration = 0;
                iconColor = "none";
              };
              id = "plugin:timer";
            }
          ];

          center = [
            {
              compactMode = true;
              compactShowAlbumArt = true;
              compactShowVisualizer = false;
              hideMode = "hidden";
              hideWhenIdle = false;
              id = "MediaMini";
              maxWidth = 2750;
              panelShowAlbumArt = true;
              panelShowVisualizer = true;
              scrollingMode = "hover";
              showAlbumArt = true;
              showArtistFirst = false;
              showProgressRing = true;
              showVisualizer = true;
              textColor = "none";
              useFixedWidth = false;
              visualizerType = "wave";
            }
          ];

          right = [
            {
              id = "Spacer";
              width = 20;
            }
            {
              blacklist = [ ];
              chevronColor = "none";
              colorizeIcons = true;
              drawerEnabled = true;
              hidePassive = false;
              id = "Tray";
              pinned = [ ];
            }
            {
              id = "Spacer";
              width = 20;
            }
            {
              displayMode = "onhover";
              iconColor = "none";
              id = "KeyboardLayout";
              showIcon = true;
              textColor = "none";
            }
            {
              displayMode = "onhover";
              iconColor = "none";
              id = "Microphone";
              middleClickCommand = "pwvucontrol || pavucontrol";
              textColor = "none";
            }
            {
              displayMode = "onhover";
              iconColor = "none";
              id = "Volume";
              middleClickCommand = "pwvucontrol || pavucontrol";
              textColor = "none";
            }
            {
              displayMode = "onhover";
              iconColor = "none";
              id = "Bluetooth";
              textColor = "none";
            }
            {
              displayMode = "onhover";
              iconColor = "none";
              id = "Network";
              textColor = "none";
            }
            {
              applyToAllMonitors = false;
              displayMode = "onhover";
              iconColor = "none";
              id = "Brightness";
              textColor = "none";
            }
            {
              deviceNativePath = "";
              displayMode = "onhover";
              hideIfIdle = false;
              hideIfNotDetected = true;
              id = "Battery";
              showNoctaliaPerformance = false;
              showPowerProfiles = false;
            }
            {
              clockColor = "none";
              customFont = "";
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm - dd MM";
              id = "Clock";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
            }
            {
              hideWhenZero = false;
              hideWhenZeroUnread = false;
              iconColor = "none";
              id = "NotificationHistory";
              showUnreadBadge = true;
              unreadBadgeColor = "primary";
            }
          ];
        };

        screenOverrides = [ ];
      };

      general = {
        avatarImage = "";
        dimmerOpacity = 0.5;
        showScreenCorners = false;
        forceBlackScreenCorners = false;
        scaleRatio = 0.95;
        radiusRatio = 0.5;
        iRadiusRatio = 0.5;
        boxRadiusRatio = 0;
        screenRadiusRatio = 1;
        animationSpeed = 1;
        animationDisabled = false;
        compactLockScreen = false;
        lockScreenAnimations = false;
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
        telemetryEnabled = false;
        enableLockScreenCountdown = true;
        lockScreenCountdownDuration = 10000;
        autoStartAuth = false;
        allowPasswordWithFprintd = false;
        clockStyle = "custom";
        clockFormat = "hh\\nmm";
        lockScreenMonitors = [ ];
        lockScreenBlur = 0;
        lockScreenTint = 0;
        reverseScroll = false;

        keybinds = {
          keyUp = [ "Up" ];
          keyDown = [ "Down" ];
          keyLeft = [ "Left" ];
          keyRight = [ "Right" ];
          keyEnter = [ "Return" ];
          keyEscape = [ "Esc" ];
          keyRemove = [ "Del" ];
        };
      };

      ui = {
        fontDefault = "JetBrainsMono Nerd Font";
        fontFixed = "JetBrainsMono Nerd Font Mono";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
        panelBackgroundOpacity = 0.7;
        panelsAttachedToBar = false;
        settingsPanelMode = "centered";
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        networkPanelView = "wifi";
        bluetoothHideUnnamedDevices = false;
        boxBorderEnabled = true;
      };

      location = {
        name = "Sydney";
        weatherEnabled = true;
        weatherShowEffects = true;
        useFahrenheit = false;
        use12hourFormat = false;
        showWeekNumberInCalendar = true;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
        hideWeatherTimezone = false;
        hideWeatherCityName = false;
      };

      calendar.cards = [
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
          id = "weather-card";
        }
      ];

      wallpaper = {
        enabled = true;
        overviewEnabled = true;
        directory = "/home/mvayk/Pictures/wallpapers/";
        monitorDirectories = [ ];
        enableMultiMonitorDirectories = false;
        showHiddenFiles = false;
        viewMode = "recursive";
        setWallpaperOnAllMonitors = true;
        fillMode = "crop";
        fillColor = "#000000";
        useSolidColor = false;
        solidColor = "#1a1a2e";
        automationEnabled = false;
        wallpaperChangeMode = "random";
        randomIntervalSec = 300;
        transitionDuration = 1500;
        transitionType = "random";
        skipStartupTransition = false;
        transitionEdgeSmoothness = 0.05;
        panelPosition = "follow_bar";
        hideWallpaperFilenames = false;
        overviewBlur = 0.4;
        overviewTint = 0.6;
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
        sortOrder = "name";
        favorites = [ ];
      };

      appLauncher = {
        enableClipboardHistory = false;
        autoPasteClipboard = false;
        enableClipPreview = true;
        clipboardWrapText = true;
        clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
        clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
        position = "center";
        pinnedApps = [ ];
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "xterm -e";
        customLaunchPrefixEnabled = false;
        customLaunchPrefix = "";
        viewMode = "grid";
        showCategories = true;
        iconMode = "tabler";
        showIconBackground = true;
        enableSettingsSearch = true;
        enableWindowsSearch = true;
        enableSessionSearch = true;
        ignoreMouseInput = false;
        screenshotAnnotationTool = "";
        overviewLayer = false;
        density = "default";
      };

      controlCenter = {
        position = "close_to_bar_button";
        diskPath = "/";
        shortcuts = {
          left = [
            { id = "Network"; }
            { id = "Bluetooth"; }
            { id = "WallpaperSelector"; }
            { id = "DarkMode"; }
          ];
          right = [
            { id = "Notifications"; }
            { id = "PowerProfile"; }
            { id = "KeepAwake"; }
            { id = "NightLight"; }
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
        swapWarningThreshold = 80;
        swapCriticalThreshold = 90;
        diskWarningThreshold = 80;
        diskCriticalThreshold = 90;
        diskAvailWarningThreshold = 20;
        diskAvailCriticalThreshold = 10;
        batteryWarningThreshold = 20;
        batteryCriticalThreshold = 5;
        enableDgpuMonitoring = false;
        useCustomColors = false;
        warningColor = "";
        criticalColor = "";
        externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
      };

      dock = {
        enabled = true;
        position = "bottom";
        displayMode = "auto_hide";
        dockType = "floating";
        backgroundOpacity = 0.7;
        floatingRatio = 1;
        size = 1.5;
        onlySameOutput = false;
        monitors = [ ];
        pinnedApps = [ ];
        colorizeIcons = false;
        pinnedStatic = false;
        inactiveIndicators = false;
        deadOpacity = 0.6;
        animationSpeed = 1;
        sitOnFrame = false;
        showFrameIndicator = true;
      };

      network = {
        wifiEnabled = true;
        airplaneModeEnabled = false;
        bluetoothRssiPollingEnabled = false;
        bluetoothRssiPollIntervalMs = 10000;
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
        disableDiscoverability = false;
      };

      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "center";
        showHeader = true;
        showKeybinds = true;
        largeButtonsStyle = true;
        largeButtonsLayout = "grid";
        powerOptions = [
          {
            action = "lock";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "1";
          }
          {
            action = "suspend";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "2";
          }
          {
            action = "hibernate";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "3";
          }
          {
            action = "reboot";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "4";
          }
          {
            action = "logout";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "5";
          }
          {
            action = "shutdown";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "6";
          }
        ];
      };

      notifications = {
        enabled = true;
        enableMarkdown = false;
        density = "default";
        monitors = [ ];
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 0.7;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        clearDismissed = true;
        saveToHistory = {
          low = true;
          normal = true;
          critical = true;
        };
        sounds = {
          enabled = true;
          volume = 1;
          separateSounds = false;
          criticalSoundFile = "";
          normalSoundFile = "";
          lowSoundFile = "";
          excludedApps = "spotify";
        };
        enableMediaToast = false;
        enableKeyboardLayoutToast = true;
        enableBatteryToast = true;
      };

      osd = {
        enabled = true;
        location = "top_center";
        autoHideMs = 2000;
        overlayLayer = true;
        backgroundOpacity = 0.7;
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
        volumeFeedback = false;
      };

      brightness = {
        brightnessStep = 10;
        enforceMinimum = true;
        enableDdcSupport = false;
      };

      colorSchemes = {
        useWallpaperColors = true;
        amoledOverride = true;
        predefinedScheme = "Ayu";
        darkMode = true;
        schedulingMode = "off";
        manualSunrise = "06:30";
        manualSunset = "18:30";
        generationMethod = "vibrant";
        monitorForColors = "";
      };

      templates = {
        activeTemplates = [
          {
            enabled = true;
            id = "gtk";
          }
          {
            enabled = true;
            id = "qt";
          }
          {
            enabled = true;
            id = "kcolorscheme";
          }
          {
            enabled = true;
            id = "kitty";
          }
          {
            enabled = true;
            id = "ghostty";
          }
          {
            enabled = true;
            id = "discord";
          }
          {
            enabled = true;
            id = "spicetify";
          }
          {
            enabled = true;
            id = "emacs";
          }
          {
            enabled = true;
            id = "niri";
          }
        ];
        enableUserTheming = true;
      };

      nightLight = {
        enabled = false;
        forced = false;
        autoSchedule = false;
        nightTemp = "1090";
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
        startup = "";
        session = "";
      };

      plugins.autoUpdate = false;

      desktopWidgets = {
        enabled = true;
        gridSnap = false;
        monitorWidgets = [ ];
      };
    };
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      environment = {
        XDG_CURRENT_DESKTOP = "niri";
        XCURSOR_THEME = "Bibata-Modern-Classic";
        XCURSOR_SIZE = "36";
      };

      cursor = {
        theme = "Bibata-Modern-Classic";
        size = 24;
      };

      input = {
        focus-follows-mouse.enable = true;
        keyboard = {
          xkb = {
            layout = "us";
            options = "caps:escape_shifted_capslock";
          };
        };
        mouse = {
          accel-profile = "flat";
          accel-speed = 0.0;
        };
        touchpad = {
          natural-scroll = false;
          tap = true;
        };
      };

      outputs =
        if machine == "flandre" then
          {
            "HDMI-A-1" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 60.0;
              };
              position = {
                x = 0;
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
                x = 1920;
                y = 0;
              };
            };
            "DP-1" = {
              mode = {
                width = 2560;
                height = 1440;
                refresh = 240.001;
              };
              position = {
                x = 4480;
                y = 0;
              };
            };
          }
        else
          {
            "eDP-1" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 60.0;
              };
              position = {
                x = 0;
                y = 0;
              };
            };
          };

      layout = {
        gaps = 8;
        center-focused-column = "never";
        background-color = "transparent";

        preset-column-widths = [
          { proportion = 0.333333; }
          { proportion = 0.5; }
          { proportion = 0.666667; }
        ];

        default-column-width = {
          proportion = 0.5;
        };

        focus-ring = {
          enable = false;
          width = 2;
          active.color = "#FFFFFFFF";
          inactive.color = "#000000FF";
        };

        border = {
          enable = true;
          active.color = "#FFFFFFFF";
          inactive.color = "#000000FF";
          width = 1;
        };

        shadow = {
          enable = true;
          offset = {
            x = 2;
            y = 3;
          };
          softness = 24;
          color = "#00000055";
        };
      };

      animations.slowdown = 1.0;

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
        { command = [ "nm-applet" ]; }
      ];

      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 10.0;
            top-right = 10.0;
            bottom-left = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [ { app-id = "^com\\.mitchellh\\.ghostty$"; } ];
          draw-border-with-background = false;
        }
      ];

      layer-rules = [
        {
          matches = [ { namespace = "^noctalia-wallpaper"; } ];
          place-within-backdrop = true;
        }
      ];

      binds = {
        "Mod+T".action.spawn = [ "ghostty" ];
        "Mod+W".action.spawn = [ "chromium" ];
        "Mod+E".action.spawn = [ "dolphin" ];

        "Mod+O".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "lockScreen"
          "lock"
        ];
        "Pause".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "muteInput"
        ];
        "Mod+Semicolon".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "launcher"
          "emoji"
        ];
        "Mod+I".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "launcher"
          "calculator"
        ];
        "Mod+A".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "launcher"
          "toggle"
        ];
        "Mod+Page_Up".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "increase"
        ];
        "Mod+Page_Down".action.spawn = [
          "noctalia-shell"
          "ipc"
          "call"
          "volume"
          "decrease"
        ];

        "End".action.spawn = [
          "sh"
          "-c"
          "grim -g \"$(slurp)\" - | wl-copy"
        ];
        "Mod+Shift+S".action.screenshot = { };
        "Ctrl+Print".action.screenshot-screen = { };
        "Alt+Print".action.screenshot-window = { };

        "Mod+Q".action.close-window = { };
        "Mod+F".action.maximize-column = { };
        "Mod+Shift+F".action.fullscreen-window = { };
        "Mod+V".action.toggle-window-floating = { };
        "Mod+R".action.switch-preset-column-width = { };

        "Mod+M".action.quit = { };

        "Mod+H".action.focus-column-left = { };
        "Mod+L".action.focus-column-right = { };
        "Mod+K".action.focus-window-up = { };
        "Mod+J".action.focus-window-down = { };

        "Mod+Shift+H".action.move-column-left = { };
        "Mod+Shift+L".action.move-column-right = { };
        "Mod+Shift+K".action.move-window-up = { };
        "Mod+Shift+J".action.move-window-down = { };

        "Mod+Alt+L".action.set-column-width = "+10%";
        "Mod+Alt+H".action.set-column-width = "-10%";
        "Mod+Alt+K".action.set-window-height = "-10%";
        "Mod+Alt+J".action.set-window-height = "+10%";

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        "Mod+WheelScrollDown".action.focus-workspace-down = { };
        "Mod+WheelScrollUp".action.focus-workspace-up = { };

        "Mod+S".action.toggle-overview = { };
      }
      // lib.optionalAttrs (machine == "laptop") {
        "XF86AudioRaiseVolume".action.spawn = [
          "pamixer"
          "--increase"
          "5"
        ];
        "XF86AudioLowerVolume".action.spawn = [
          "pamixer"
          "--decrease"
          "5"
        ];
        "XF86MonBrightnessUp".action.spawn = [
          "brightnessctl"
          "set"
          "1%+"
        ];
        "XF86MonBrightnessDown".action.spawn = [
          "brightnessctl"
          "set"
          "1%-"
        ];
      };
    };
    # dsjlfk asdjfl kdas 
    # include = [ "${config.home.homeDirectory}/.config/niri/noctalia.kdl" ];
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.home.homeDirectory}/.config/qt5ct/colors/noctalia.conf
    custom_palette=true
    icon_theme=kora
    standard_dialogs=xdgdesktopportal
    style=Breeze

    [Interface]
    activate_item_on_single_click=1
    buttonbox_layout=0
    cursor_flash_time=1000
    dialog_buttons_have_icons=1
    double_click_interval=400
    gui_effects=@Invalid()
    keyboard_scheme=2
    menus_have_icons=true
    show_shortcuts_in_context_menus=true
    stylesheets=@Invalid()
    toolbutton_style=4
    underline_shortcut=1
    wheel_scroll_lines=3

    [Fonts]
    fixed="JetBrainsMono Nerd Font Mono,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
    general="JetBrainsMono Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"

    [Troubleshooting]
    force_raster_widgets=1
    ignored_applications=@Invalid()
  '';

  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/noctalia.conf
    custom_palette=true
    icon_theme=kora
    standard_dialogs=xdgdesktopportal
    style=Breeze

    [Interface]
    activate_item_on_single_click=1
    buttonbox_layout=0
    cursor_flash_time=1000
    dialog_buttons_have_icons=1
    double_click_interval=400
    gui_effects=@Invalid()
    keyboard_scheme=2
    menus_have_icons=true
    show_shortcuts_in_context_menus=true
    stylesheets=@Invalid()
    toolbutton_style=4
    underline_shortcut=1
    wheel_scroll_lines=3

    [Fonts]
    fixed="JetBrainsMono Nerd Font Mono,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
    general="JetBrainsMono Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"

    [Troubleshooting]
    force_raster_widgets=1
    ignored_applications=@Invalid()
  '';

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  programs.zsh.initContent = ''
    eval "$(starship init zsh)"
    export NIXOS_DE="niri"
  '';

  home.packages = with pkgs; [
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    lxappearance
    kdePackages.kirigami
    kdePackages.qtstyleplugin-kvantum
    kdePackages.breeze-gtk
    kdePackages.breeze
    kora-icon-theme
    adw-gtk3
    nwg-look

    # apple-cursor
    bibata-cursors
    grim
    slurp
    wl-clipboard

    qt6Packages.qtimageformats
    qt6Packages.qtsvg
    libsForQt5.qtimageformats
    libsForQt5.qtsvg
    libwebp
    libjpeg
    libpng
    librsvg

    quickshell.packages.${pkgs.system}.default
    noctalia.packages.${pkgs.system}.default
  ];
}
