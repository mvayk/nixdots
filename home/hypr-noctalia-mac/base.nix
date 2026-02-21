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
                textColor = "primary";
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

        keybinds = {
            keyUp = [ "Up" ];
            keyDown = [ "Down" ];
            keyLeft = [ "Left" ];
            keyRight = [ "Right" ];
            keyEnter = [ "Return" ];
            keyEscape = [ "Esc" ];
            keyRemove = [ "Del" ];
        };

        reverseScroll = false;
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
        { enabled = true; id = "calendar-header-card"; }
        { enabled = true; id = "calendar-month-card"; }
        { enabled = true; id = "weather-card"; }
        ];
    };

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
        { enabled = true; id = "profile-card"; }
        { enabled = true; id = "shortcuts-card"; }
        { enabled = true; id = "audio-card"; }
        { enabled = true; id = "brightness-card"; }
        { enabled = true; id = "weather-card"; }
        { enabled = true; id = "media-sysmon-card"; }
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
        { action = "lock";      command = ""; countdownEnabled = true; enabled = true; keybind = "1"; }
        { action = "suspend";   command = ""; countdownEnabled = true; enabled = true; keybind = "2"; }
        { action = "hibernate"; command = ""; countdownEnabled = true; enabled = true; keybind = "3"; }
        { action = "reboot";    command = ""; countdownEnabled = true; enabled = true; keybind = "4"; }
        { action = "logout";    command = ""; countdownEnabled = true; enabled = true; keybind = "5"; }
        { action = "shutdown";  command = ""; countdownEnabled = true; enabled = true; keybind = "6"; }
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
        enabledTypes = [ 0 1 2 4 ];
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
        generationMethod = "fruit-salad";
        monitorForColors = "";
    };

    templates = {
        activeTemplates = [
        { enabled = true; id = "gtk"; }
        { enabled = true; id = "qt"; }
        { enabled = true; id = "kcolorscheme"; }
        { enabled = true; id = "kitty"; }
        { enabled = true; id = "ghostty"; }
        { enabled = true; id = "discord"; }
        { enabled = true; id = "spicetify"; }
        { enabled = true; id = "emacs"; }
        { enabled = true; id = "hyprland"; }
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

    plugins = {
        autoUpdate = false;
    };

    desktopWidgets = {
        enabled = true;
        gridSnap = false;
        monitorWidgets = [ ];
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

      # animations = {
      #   enabled = true;
      #   bezier = [
      #     "linear, 0, 0, 1, 1"
      #     "md3_standard, 0.2, 0, 0, 1"
      #     "md3_decel, 0.05, 0.7, 0.1, 1"
      #     "md3_accel, 0.3, 0, 0.8, 0.15"
      #     "overshot, 0.05, 0.9, 0.1, 1.1"
      #     "crazyshot, 0.1, 1.5, 0.76, 0.92"
      #     "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
      #     "fluent_decel, 0.1, 1, 0, 1"
      #     "easeInOutCirc, 0.85, 0, 0.15, 1"
      #     "easeOutCirc, 0, 0.55, 0.45, 1"
      #     "easeOutExpo, 0.16, 1, 0.3, 1"
      #   ];
      #   animation = [
      #     "windows, 1, 3, md3_decel, popin 60%"
      #     "border, 1, 1, linear"
      #     "borderangle, 1, 80, linear, loop"
      #     "fade, 1, 2.5, md3_decel"
      #     "workspaces, 1, 3.5, easeOutExpo, slide"
      #     "specialWorkspace, 1, 3, md3_decel, slidevert"
      #   ];
      # };


animations = {
  enabled = true;
  bezier = [
    "wind, 0.05, 0.9, 0.1, 1"
    "winIn, 0.1, 1.1, 0.1, 1.1"
    "winOut, 0.3, -0.3, 0, 1"
    "liner, 1, 1, 1, 1"
    "md3_standard, 0.2, 0, 0, 1"
    "md3_decel, 0.05, 0.7, 0.1, 1"
    "md3_accel, 0.3, 0, 0.8, 0.15"
    "overshot, 0.05, 0.9, 0.1, 1.1"
    "crazyshot, 0.1, 1.5, 0.76, 0.92"
    "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
    "menu_decel, 0.1, 1, 0, 1"
    "menu_accel, 0.38, 0.04, 1, 0.07"
    "easeInOutCirc, 0.85, 0, 0.15, 1"
    "easeOutCirc, 0, 0.55, 0.45, 1"
    "easeOutExpo, 0.16, 1, 0.3, 1"
    "softAcDecel, 0.26, 0.26, 0.15, 1"
    "md2, 0.4, 0, 0.2, 1"
  ];
  animation = [
    "border, 1, 1, liner"
    "borderangle, 1, 30, liner, loop"
    "windows, 1, 6, wind, slide"
    "windowsIn, 1, 6, winIn, slide"
    "windowsOut, 1, 5, winOut, slide"
    "windowsMove, 1, 5, wind, slide"
    "fade, 1, 3, md3_decel"
    "layersIn, 1, 3, menu_decel, slide"
    "layersOut, 1, 1.6, menu_accel"
    "fadeLayersIn, 1, 2, menu_decel"
    "fadeLayersOut, 1, 4.5, menu_accel"
    "workspaces, 1, 5, wind, slidevert"
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

/*
*/
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

    [SettingsWindow]
    geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x1\xd3\0\0\x1\xfa\0\0\0\0\0\0\0\0\0\0\x1\xd3\0\0\x1\xfa\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x1\xd3\0\0\x1\xfa)

    [Troubleshooting]
    force_raster_widgets=1
    ignored_applications=@Invalid()
  '';

/*
*/

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
