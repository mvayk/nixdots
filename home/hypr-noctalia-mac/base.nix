{ config, pkgs, noctalia, quickshell, matugen, lib, ... }:
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
        ../../modules/options.nix
        ../../common/shared-home.nix
        ../../modules/hyprland/core.nix
        noctalia.homeModules.default
    ];
    home.file = {
        ".config" = {
            source = ./. + "/${config.home.username}/.config";
            recursive = true;
        };
    };

    home.pointerCursor = {
        package = pkgs.apple-cursor;
        name = "macOS";
        size = 24;
    };

programs.noctalia-shell = {
  enable = true;
  settings = {
    settingsVersion = 46;
    bar = {
      barType = "simple";
      position = "top";
      monitors = [];
      density = "default";
      showOutline = false;
      showCapsule = false;
      capsuleOpacity = 1;
      backgroundOpacity = 0.7;
      useSeparateOpacity = true;
      floating = false;
      marginVertical = 5;
      marginHorizontal = 18;
      frameThickness = 8;
      frameRadius = 12;
      outerCorners = false;
      exclusive = true;
      hideOnOverview = false;
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
            icon = "rocket";
            id = "Launcher";
            usePrimaryColor = false;
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
            id = "plugin:timer";
          }
          {
            compactMode = true;
            diskPath = "/";
            id = "SystemMonitor";
            showCpuTemp = true;
            showCpuUsage = true;
            showDiskUsage = false;
            showGpuTemp = false;
            showLoadAverage = true;
            showMemoryAsPercent = false;
            showMemoryUsage = true;
            showNetworkStats = false;
            showSwapUsage = true;
            useMonospaceFont = true;
            usePrimaryColor = false;
          }
          {
            compactMode = false;
            compactShowAlbumArt = true;
            compactShowVisualizer = false;
            hideMode = "hidden";
            hideWhenIdle = false;
            id = "MediaMini";
            maxWidth = 145;
            panelShowAlbumArt = true;
            panelShowVisualizer = true;
            scrollingMode = "hover";
            showAlbumArt = true;
            showArtistFirst = false;
            showProgressRing = true;
            showVisualizer = true;
            useFixedWidth = false;
            visualizerType = "wave";
          }
        ];
        center = [
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
            reverseScroll = false;
            showApplications = true;
            showBadge = true;
            showLabelsOnlyWhenOccupied = true;
            unfocusedIconsOpacity = 1;
          }
        ];
        right = [
          {
            id = "Spacer";
            width = 20;
          }
          {
            blacklist = [];
            colorizeIcons = true;
            drawerEnabled = true;
            hidePassive = false;
            id = "Tray";
            pinned = [];
          }
          {
            id = "Spacer";
            width = 20;
          }
          {
            displayMode = "onhover";
            id = "KeyboardLayout";
            showIcon = true;
          }
          {
            displayMode = "onhover";
            id = "Microphone";
            middleClickCommand = "pwvucontrol || pavucontrol";
          }
          {
            displayMode = "onhover";
            id = "Volume";
            middleClickCommand = "pwvucontrol || pavucontrol";
          }
          {
            displayMode = "onhover";
            id = "Bluetooth";
          }
          {
            displayMode = "onhover";
            id = "Network";
          }
          {
            displayMode = "onhover";
            id = "Brightness";
          }
          {
            deviceNativePath = "";
            displayMode = "onhover";
            hideIfIdle = false;
            hideIfNotDetected = true;
            id = "Battery";
            showNoctaliaPerformance = false;
            showPowerProfiles = false;
            warningThreshold = 30;
          }
          {
            customFont = "";
            formatHorizontal = "HH:mm ddd, MMM dd";
            formatVertical = "HH mm - dd MM";
            id = "Clock";
            tooltipFormat = "HH:mm ddd, MMM dd";
            useCustomFont = false;
            usePrimaryColor = false;
          }
          {
            hideWhenZero = false;
            hideWhenZeroUnread = false;
            id = "NotificationHistory";
            showUnreadBadge = true;
          }
        ];
      };
      screenOverrides = [];
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
          id = "weather-card";
        }
      ];
    };
    wallpaper = {
      enabled = true;
      overviewEnabled = true;
      directory = "/home/mvayk/Pictures/wallpapers/";
      monitorDirectories = [];
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
      clipboardWrapText = true;
      clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
      clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
      position = "center";
      pinnedApps = [];
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
      ignoreMouseInput = false;
      screenshotAnnotationTool = "";
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
      enabled = true;
      position = "bottom";
      displayMode = "auto_hide";
      backgroundOpacity = 0.7;
      floatingRatio = 1;
      size = 1.5;
      onlySameOutput = false;
      monitors = [];
      pinnedApps = [];
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
      largeButtonsStyle = true;
      largeButtonsLayout = "grid";
      showNumberLabels = true;
      powerOptions = [
        {
          action = "lock";
          command = "";
          countdownEnabled = true;
          enabled = true;
        }
        {
          action = "suspend";
          command = "";
          countdownEnabled = true;
          enabled = true;
        }
        {
          action = "hibernate";
          command = "";
          countdownEnabled = true;
          enabled = true;
        }
        {
          action = "reboot";
          command = "";
          countdownEnabled = true;
          enabled = true;
        }
        {
          action = "logout";
          command = "";
          countdownEnabled = true;
          enabled = true;
        }
        {
          action = "shutdown";
          command = "";
          countdownEnabled = true;
          enabled = true;
        }
      ];
    };
    notifications = {
      enabled = true;
      monitors = [];
      location = "top_right";
      overlayLayer = true;
      backgroundOpacity = 0.7;
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
        volume = 1;
        separateSounds = false;
        criticalSoundFile = "";
        normalSoundFile = "";
        lowSoundFile = "";
        excludedApps = "spotify";
      };
      enableMediaToast = false;
    };
    osd = {
      enabled = true;
      location = "top_center";
      autoHideMs = 2000;
      overlayLayer = true;
      backgroundOpacity = 0.7;
      enabledTypes = [ 0 1 2 4 ];
      monitors = [];
    };
    audio = {
      volumeStep = 5;
      volumeOverdrive = true;
      cavaFrameRate = 30;
      visualizerType = "linear";
      mprisBlacklist = [];
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
      predefinedScheme = "Ayu";
      darkMode = true;
      schedulingMode = "off";
      manualSunrise = "06:30";
      manualSunset = "18:30";
      generationMethod = "tonal-spot";
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
          id = "hyprland";
        }
      ];
      enableUserTheming = true;
    };
    nightLight = {
      enabled = true;
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
    desktopWidgets = {
      enabled = true;
      gridSnap = false;
      monitorWidgets = [];
    };
  };
};

wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XCURSOR_SIZE,38"
        "HYPRCURSOR_THEME,macOS"
        "HYPRCURSOR_SIZE,24"
      ];
      exec-once = [
        "noctalia-shell"
        "nm-applet"
        "hyprctl setcursor macOS 24"
      ];

      bind = [
          "$mainMod, O, exec, noctalia-shell ipc call lockScreen lock"
          ", PAUSE, exec, noctalia-shell ipc call volume muteInput"
          "$mainMod, semicolon, exec, noctalia-shell ipc call launcher emoji"
          "$mainMod, I, exec, noctalia-shell ipc call launcher calculator"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, dolphin"
          "$mainMod, T, exec, ghostty"
          "$mainMod, W, exec, brave"
          "$mainMod, V, togglefloating,"
          "$mainMod, A, exec, noctalia-shell ipc call launcher toggle"
          "$mainMod, page_up, exec, noctalia-shell ipc call volume increase"
          "$mainMod, page_down, exec, noctalia-shell ipc call volume decrease"
          "$mainMod, P, pseudo,"
          "$mainMod, N, togglesplit,"
          "$mainMod, F, fullscreen"
          "$mainMod, G, exec, $HOME/.config/hypr/scripts/toggle-gaps.sh"
      ];

      source = "noctalia/noctalia-colors.conf";

      general = {
        gaps_in = 2;
        gaps_out = 8;
        border_size = 1;
        "col.active_border" = "$primary $secondary $tertiary 45deg";
        "col.inactive_border" = "$surface";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 24;
          render_power = 4;
          color = "rgba(00000055)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 1, linear"
          "borderangle, 1, 80, linear, loop"
          "fade, 1, 2.5, md3_decel"
          "workspaces, 1, 3.5, easeOutExpo, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };
    };
  };

    programs.zsh = {
        oh-my-zsh = {
            theme = "mh";
        };
        initContent = ''
            eval "$(starship init zsh)"
        '';
    };

    programs.starship = {
        enable = true;
    };


# this shit is driving me up the wall
    qt = {
        enable = true;
        platformTheme.name = "qtct";
        style = {
            # name = "breeze";
        };
    };


/* qt.qt5ctSettings = {
    Appearance = {
        style = "breeze";
        icon_theme = "Kora";
        standar_dialogs = "xdgdesktopportal";
    };
    Fonts = {
        fixed = "\"JetBrainsMono Nerd Font Mono,10\"";
        general = "\"JetBrainsMono Nerd Font,10\"";
    };
}; */

  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.home.homeDirectory}/.config/qt5ct/colors/noctalia.conf
    custom_palette=true
    icon_theme=kora
    standard_dialogs=xdgdesktopportal
    style=Breeze

    [Fonts]
    fixed="JetBrainsMono Nerd Font Mono,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
    general="JetBrainsMono Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"

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

    [SettingsWindow]
    geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x1\xd3\0\0\x1\xfa\0\0\0\0\0\0\0\0\0\0\x1\xd3\0\0\x1\xfa\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x1\xd3\0\0\x1\xfa)

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

    [Fonts]
    fixed="JetBrainsMono Nerd Font Mono,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
    general="JetBrainsMono Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"

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

    [SettingsWindow]
    geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x1\xd3\0\0\x1\xfa\0\0\0\0\0\0\0\0\0\0\x1\xd3\0\0\x1\xfa\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x1\xd3\0\0\x1\xfa)

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
            name = "Kora";
            package = pkgs.kora-icon-theme;
        };

        font = {
            name = "JetBrainsMono Nerd Font";
            size = 10;
        };

        gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = true;
        };
        
        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = true;
        };
    };

    home.sessionVariables = {
    };

    home.packages = with pkgs; [
        qt6Packages.qt6ct
        libsForQt5.qt5ct
        lxappearance
        kdePackages.kirigami
        kdePackages.qtstyleplugin-kvantum
        kdePackages.breeze-gtk
        kora-icon-theme
        kdePackages.breeze
        adw-gtk3
        nwg-look

        bibata-cursors
        hyprland
        grim
        slurp
        qt6Packages.qtimageformats
        qt6Packages.qtsvg
        matugen.packages.${pkgs.system}.default
        simp1e-cursors

        libsForQt5.qtimageformats
        libsForQt5.qtsvg
        libwebp
        libjpeg
        libpng
        librsvg
        wl-clipboard
        quickshell.packages.${pkgs.system}.default
        noctalia.packages.${pkgs.system}.default
    ];
}
