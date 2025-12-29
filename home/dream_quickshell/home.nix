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
        #QT_QUICK_BACKEND = "software";
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
        theme = {
            name = "Orchis-Dark";
            package = pkgs.orchis-theme;
        };
    };

    qt = {
        enable = true;
        platformTheme.name = "kde";
        style.name = "breeze";
    };

    programs.noctalia-shell = {
        enable = true;
        settings = {
            systemd.enable = true;
            settingsVersion = 21;
            setupCompleted = true;
            bar = {
                position = "top";
                backgroundOpacity = 0.75;
                monitors = [ "default" ];
                density = "default";
                showCapsule = false;
                floating = true;
                marginVertical = 0.25;
                marginHorizontal = 1.0;
                outerCorners = false;
                exclusive = true;
                widgets = {
                    left = [
                    {
                        id = "ControlCenter";
                    }
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
                    ];
                };
            };
            general = {
                avatarImage = "";
                dimDesktop = true;
                showScreenCorners = false;
                forceBlackScreenCorners = false;
                scaleRatio = 1;
                radiusRatio = 0.25;
                screenRadiusRatio = 1;
                animationSpeed = 1;
                animationDisabled = true;
                compactLockScreen = false;
                lockOnSuspend = true;
                enableShadows = false;
                shadowDirection = "bottom_right";
                shadowOffsetX = 2;
                shadowOffsetY = 3;
                language = "";
            };
            ui = {
                fontDefault = "JetBrainsMono Nerd Font";
                fontFixed = "JetBrainsMono Nerd Font Mono";
                fontDefaultScale = 1;
                fontFixedScale = 1;
                tooltipsEnabled = true;
                panelsAttachedToBar = false;
                settingsPanelAttachToBar = false;
            };
            location = {
                name = "Sydney";
                weatherEnabled = true;
                useFahrenheit = false;
                use12hourFormat = false;
                showWeekNumberInCalendar = true;
                showCalendarEvents = true;
                showCalendarWeather = true;
                analogClockInCalendar = false;
                firstDayOfWeek = -1;
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
                overviewEnabled = true;
                directory = "/home/mvayk/Pictures/wallpapers/";
                enableMultiMonitorDirectories = false;
                recursiveSearch = true;
                setWallpaperOnAllMonitors = true;
                defaultWallpaper = "/home/mvayk/Pictures/wallpapers/bay.JPG";
                fillMode = "crop";
                fillColor = "#000000";
                randomEnabled = false;
                randomIntervalSec = 300;
                transitionDuration = 1500;
                transitionType = "random";
                transitionEdgeSmoothness = 0.05;
                monitors = [ "default" ];
                panelPosition = "follow_bar";
            };
            appLauncher = {
                enableClipboardHistory = false;
                position = "center";
                backgroundOpacity = 1;
                pinnedExecs = [ ];
                useApp2Unit = false;
                sortByMostUsed = true;
                terminalCommand = "xterm -e";
                customLaunchPrefixEnabled = false;
                customLaunchPrefix = "";
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
                enabled = false;
                displayMode = "always_visible";
                backgroundOpacity = 1;
                floatingRatio = 1;
                size = 1;
                onlySameOutput = true;
                monitors = [ ];
                pinnedApps = [ ];
                colorizeIcons = false;
            };
            network = {
                wifiEnabled = true;
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
                cavaFrameRate = 30;
                visualizerType = "linear";
                visualizerQuality = "high";
                mprisBlacklist = [ ];
                preferredPlayer = "";
            };
            brightness = {
                brightnessStep = 5;
                enforceMinimum = true;
                enableDdcSupport = false;
            };
            colorSchemes = {
                useWallpaperColors = false;
                predefinedScheme = "";
                darkMode = true;
                schedulingMode = "off";
                manualSunrise = "06:30";
                manualSunset = "18:30";
                matugenSchemeType = "scheme-matugen";
                generateTemplatesForPredefined = true;
            };
            templates = {
                gtk = false;
                qt = false;
                kcolorscheme = false;
                alacritty = false;
                kitty = true;
                ghostty = false;
                foot = false;
                wezterm = false;
                fuzzel = false;
                discord = false;
                pywalfox = false;
                vicinae = false;
                walker = false;
                code = false;
                spicetify = false;
                enableUserTemplates = false;
                discord_vesktop = true;
                discord_webcord = false;
                discord_armcord = false;
                discord_equibop = false;
                discord_lightcord = false;
                discord_dorion = false;
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
        qt6Packages.qt6ct
        libsForQt5.qt5ct
        whitesur-icon-theme
        rose-pine-gtk-theme
        lxappearance
        catppuccin-qt5ct
        bibata-cursors
        hyprland
        grim
        slurp
        qt6Packages.qtimageformats
        qt6Packages.qtsvg

        libsForQt5.qtimageformats
        libsForQt5.qtsvg

        libwebp
        libjpeg
        libpng
        librsvg
        wl-clipboard
        hypridle
        matugen
        nwg-look
        quickshell.packages.${pkgs.system}.default
        noctalia.packages.${pkgs.system}.default  # Add this line
    ];
}
