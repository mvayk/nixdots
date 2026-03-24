{
  config,
  pkgs,
  lib,
  machine,
  de,
  ...
}:
{
  imports = [
    ../../features/ghostty.nix
    ../../features/fastfetch.nix
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
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
          {
            proportion = 0.333333;
          }
          {
            proportion = 0.5;
          }
          {
            proportion = 0.666667;
          }
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
        {
          command = [
            "noctalia-shell"
          ];
        }
        {
          command = [
            "nm-applet"
          ];
        }
        {
          command = [
            "xwayland-satellite"
          ];
        }
      ];

      prefer-no-csd = true;
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
          matches = [
            {
              app-id = "^com\\.mitchellh\\.ghostty$";
            }
          ];
          draw-border-with-background = false;
        }
      ];

      layer-rules = [
        {
          matches = [
            {
              namespace = "^noctalia-wallpaper";
            }
          ];
          place-within-backdrop = false;
        }
      ];

      binds = {
        "Mod+T".action.spawn = [
          "ghostty"
        ];
        "Mod+W".action.spawn = [
          "chromium"
        ];
        "Mod+E".action.spawn = [
          "dolphin"
        ];

        "Mod+O".action.spawn = [
          "dms"
          "ipc"
          "call"
          "lock"
          "lock"
        ];
        "Pause".action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "micmute"
        ];
        "Mod+Semicolon".action.spawn = [
          "dms"
          "ipc"
          "call"
          "spotlight"
          "toggleQuery"
          "!"
        ];
        "Mod+A".action.spawn = [
          "dms"
          "ipc"
          "call"
          "spotlight"
          "toggle"
        ];
        "Mod+Page_Up".action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "increment"
          "5"
        ];
        "Mod+Page_Down".action.spawn = [
          "dms"
          "ipc"
          "call"
          "audio"
          "decrement"
          "5"
        ];

        "End".action.spawn = [
          "sh"
          "-c"
          "grim -g \"$(slurp)\" - | tee ~/Documents/sync/pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy"
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

        "Mod+Ctrl+H".action.focus-monitor-left = { };
        "Mod+Ctrl+L".action.focus-monitor-right = { };
        "Mod+Ctrl+K".action.focus-monitor-up = { };
        "Mod+Ctrl+J".action.focus-monitor-down = { };
        "Mod+Shift+Ctrl+H".action.move-window-to-monitor-left = { };
        "Mod+Shift+Ctrl+L".action.move-window-to-monitor-right = { };

        "Mod+WheelScrollUp" = {
          cooldown-ms = 10;
          action.focus-column-left = { };
        };
        "Mod+WheelScrollDown" = {
          cooldown-ms = 10;
          action.focus-column-right = { };
        };
        "Mod+Shift+WheelScrollDown" = {
          cooldown-ms = 10;
          action.focus-workspace-down = { };
        };
        "Mod+Shift+WheelScrollUp" = {
          cooldown-ms = 10;
          action.focus-workspace-up = { };
        };

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
    color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/matugen.conf
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
    color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/matugen.conf
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
    /*
      theme = {
        name = "adw-gtk3-dark";
        package =
          pkgs.adw-gtk3;
      };
    */
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

  xdg.configFile = {
    "gtk-4.0/gtk.css".text = ''
      @import url("file://${config.home.homeDirectory}/.config/gtk-4.0/dank-colors.css");
    '';
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.configFile = {
    "DankMaterialShell/settings.json".text = ''
              {
        "currentThemeName": "dynamic",
        "currentThemeCategory": "dynamic",
        "customThemeFile": "/home/mvayk/.config/DankMaterialShell/themes/nord/theme.json",
        "registryThemeVariants": {},
        "matugenScheme": "scheme-rainbow",
        "runUserMatugenTemplates": true,
        "matugenTargetMonitor": "",
        "popupTransparency": 0.8,
        "dockTransparency": 1,
        "widgetBackgroundColor": "sth",
        "widgetColorMode": "default",
        "controlCenterTileColorMode": "primary",
        "buttonColorMode": "primary",
        "cornerRadius": 12,
        "niriLayoutGapsOverride": -1,
        "niriLayoutRadiusOverride": -1,
        "niriLayoutBorderSize": -1,
        "hyprlandLayoutGapsOverride": -1,
        "hyprlandLayoutRadiusOverride": -1,
        "hyprlandLayoutBorderSize": -1,
        "mangoLayoutGapsOverride": -1,
        "mangoLayoutRadiusOverride": -1,
        "mangoLayoutBorderSize": -1,
        "use24HourClock": true,
        "showSeconds": false,
        "padHours12Hour": false,
        "useFahrenheit": false,
        "windSpeedUnit": "kmh",
        "nightModeEnabled": false,
        "animationSpeed": 2,
        "customAnimationDuration": 500,
        "syncComponentAnimationSpeeds": true,
        "popoutAnimationSpeed": 1,
        "popoutCustomAnimationDuration": 150,
        "modalAnimationSpeed": 1,
        "modalCustomAnimationDuration": 150,
        "enableRippleEffects": true,
        "wallpaperFillMode": "Fill",
        "blurredWallpaperLayer": false,
        "blurWallpaperOnOverview": false,
        "showLauncherButton": true,
        "showWorkspaceSwitcher": true,
        "showFocusedWindow": true,
        "showWeather": true,
        "showMusic": true,
        "showClipboard": true,
        "showCpuUsage": true,
        "showMemUsage": true,
        "showCpuTemp": true,
        "showGpuTemp": true,
        "selectedGpuIndex": 0,
        "enabledGpuPciIds": [],
        "showSystemTray": true,
        "showClock": true,
        "showNotificationButton": true,
        "showBattery": true,
        "showControlCenterButton": true,
        "showCapsLockIndicator": true,
        "controlCenterShowNetworkIcon": true,
        "controlCenterShowBluetoothIcon": true,
        "controlCenterShowAudioIcon": true,
        "controlCenterShowAudioPercent": false,
        "controlCenterShowVpnIcon": true,
        "controlCenterShowBrightnessIcon": false,
        "controlCenterShowBrightnessPercent": false,
        "controlCenterShowMicIcon": false,
        "controlCenterShowMicPercent": true,
        "controlCenterShowBatteryIcon": false,
        "controlCenterShowPrinterIcon": false,
        "controlCenterShowScreenSharingIcon": true,
        "showPrivacyButton": true,
        "privacyShowMicIcon": false,
        "privacyShowCameraIcon": false,
        "privacyShowScreenShareIcon": false,
        "controlCenterWidgets": [
          {
            "id": "volumeSlider",
            "enabled": true,
            "width": 50
          },
          {
            "id": "brightnessSlider",
            "enabled": true,
            "width": 50
          },
          {
            "id": "wifi",
            "enabled": true,
            "width": 50
          },
          {
            "id": "bluetooth",
            "enabled": true,
            "width": 50
          },
          {
            "id": "audioOutput",
            "enabled": true,
            "width": 50
          },
          {
            "id": "audioInput",
            "enabled": true,
            "width": 50
          },
          {
            "id": "nightMode",
            "enabled": true,
            "width": 50
          },
          {
            "id": "darkMode",
            "enabled": true,
            "width": 50
          }
        ],
        "showWorkspaceIndex": true,
        "showWorkspaceName": false,
        "showWorkspacePadding": false,
        "workspaceScrolling": false,
        "showWorkspaceApps": true,
        "workspaceDragReorder": true,
        "maxWorkspaceIcons": 3,
        "workspaceAppIconSizeOffset": 0,
        "groupWorkspaceApps": true,
        "workspaceFollowFocus": false,
        "showOccupiedWorkspacesOnly": false,
        "reverseScrolling": false,
        "dwlShowAllTags": false,
        "workspaceColorMode": "default",
        "workspaceOccupiedColorMode": "none",
        "workspaceUnfocusedColorMode": "default",
        "workspaceUrgentColorMode": "default",
        "workspaceFocusedBorderEnabled": false,
        "workspaceFocusedBorderColor": "primary",
        "workspaceFocusedBorderThickness": 2,
        "workspaceNameIcons": {},
        "waveProgressEnabled": true,
        "scrollTitleEnabled": true,
        "audioVisualizerEnabled": true,
        "audioScrollMode": "volume",
        "audioWheelScrollAmount": 5,
        "clockCompactMode": false,
        "focusedWindowCompactMode": false,
        "runningAppsCompactMode": true,
        "barMaxVisibleApps": 0,
        "barMaxVisibleRunningApps": 0,
        "barShowOverflowBadge": true,
        "appsDockHideIndicators": false,
        "appsDockColorizeActive": false,
        "appsDockActiveColorMode": "primary",
        "appsDockEnlargeOnHover": false,
        "appsDockEnlargePercentage": 125,
        "appsDockIconSizePercentage": 100,
        "keyboardLayoutNameCompactMode": false,
        "runningAppsCurrentWorkspace": true,
        "runningAppsGroupByApp": false,
        "runningAppsCurrentMonitor": false,
        "appIdSubstitutions": [],
        "centeringMode": "index",
        "clockDateFormat": "",
        "lockDateFormat": "",
        "mediaSize": 1,
        "appLauncherViewMode": "list",
        "spotlightModalViewMode": "list",
        "browserPickerViewMode": "grid",
        "browserUsageHistory": {},
        "appPickerViewMode": "grid",
        "filePickerUsageHistory": {},
        "sortAppsAlphabetically": false,
        "appLauncherGridColumns": 4,
        "spotlightCloseNiriOverview": true,
        "spotlightSectionViewModes": {},
        "appDrawerSectionViewModes": {},
        "niriOverviewOverlayEnabled": true,
        "dankLauncherV2Size": "compact",
        "dankLauncherV2BorderEnabled": false,
        "dankLauncherV2BorderThickness": 2,
        "dankLauncherV2BorderColor": "primary",
        "dankLauncherV2ShowFooter": true,
        "dankLauncherV2UnloadOnClose": false,
        "useAutoLocation": false,
        "weatherEnabled": true,
        "networkPreference": "auto",
        "iconTheme": "kora",
        "cursorSettings": {
          "theme": "System Default",
          "size": 24,
          "niri": {
            "hideWhenTyping": false,
            "hideAfterInactiveMs": 0
          },
          "hyprland": {
            "hideOnKeyPress": false,
            "hideOnTouch": false,
            "inactiveTimeout": 0
          },
          "dwl": {
            "cursorHideTimeout": 0
          }
        },
        "launcherLogoMode": "apps",
        "launcherLogoCustomPath": "",
        "launcherLogoColorOverride": "",
        "launcherLogoColorInvertOnMode": false,
        "launcherLogoBrightness": 0.5,
        "launcherLogoContrast": 1,
        "launcherLogoSizeOffset": 0,
        "fontFamily": "JetBrainsMono Nerd Font",
        "monoFontFamily": "JetBrainsMono Nerd Font Mono",
        "fontWeight": 800,
        "fontScale": 1,
        "notepadUseMonospace": true,
        "notepadFontFamily": "",
        "notepadFontSize": 14,
        "notepadShowLineNumbers": false,
        "notepadTransparencyOverride": -1,
        "notepadLastCustomTransparency": 0.7,
        "soundsEnabled": true,
        "useSystemSoundTheme": false,
        "soundNewNotification": true,
        "soundVolumeChanged": true,
        "soundPluggedIn": true,
        "acMonitorTimeout": 0,
        "acLockTimeout": 0,
        "acSuspendTimeout": 0,
        "acSuspendBehavior": 0,
        "acProfileName": "",
        "batteryMonitorTimeout": 0,
        "batteryLockTimeout": 0,
        "batterySuspendTimeout": 0,
        "batterySuspendBehavior": 0,
        "batteryProfileName": "",
        "batteryChargeLimit": 100,
        "lockBeforeSuspend": false,
        "loginctlLockIntegration": true,
        "fadeToLockEnabled": true,
        "fadeToLockGracePeriod": 5,
        "fadeToDpmsEnabled": true,
        "fadeToDpmsGracePeriod": 5,
        "launchPrefix": "",
        "brightnessDevicePins": {},
        "wifiNetworkPins": {},
        "bluetoothDevicePins": {},
        "audioInputDevicePins": {},
        "audioOutputDevicePins": {},
        "gtkThemingEnabled": false,
        "qtThemingEnabled": false,
        "syncModeWithPortal": true,
        "terminalsAlwaysDark": false,
        "runDmsMatugenTemplates": true,
        "matugenTemplateGtk": true,
        "matugenTemplateNiri": true,
        "matugenTemplateHyprland": false,
        "matugenTemplateMangowc": false,
        "matugenTemplateQt5ct": true,
        "matugenTemplateQt6ct": true,
        "matugenTemplateFirefox": false,
        "matugenTemplatePywalfox": true,
        "matugenTemplateZenBrowser": true,
        "matugenTemplateVesktop": true,
        "matugenTemplateEquibop": false,
        "matugenTemplateGhostty": true,
        "matugenTemplateKitty": false,
        "matugenTemplateFoot": false,
        "matugenTemplateAlacritty": false,
        "matugenTemplateNeovim": true,
        "matugenTemplateWezterm": false,
        "matugenTemplateDgop": true,
        "matugenTemplateKcolorscheme": true,
        "matugenTemplateVscode": false,
        "matugenTemplateEmacs": true,
        "showDock": false,
        "dockAutoHide": false,
        "dockSmartAutoHide": false,
        "dockGroupByApp": false,
        "dockOpenOnOverview": false,
        "dockPosition": 1,
        "dockSpacing": 4,
        "dockBottomGap": 0,
        "dockMargin": 0,
        "dockIconSize": 40,
        "dockIndicatorStyle": "circle",
        "dockBorderEnabled": false,
        "dockBorderColor": "surfaceText",
        "dockBorderOpacity": 1,
        "dockBorderThickness": 1,
        "dockIsolateDisplays": false,
        "dockLauncherEnabled": false,
        "dockLauncherLogoMode": "apps",
        "dockLauncherLogoCustomPath": "",
        "dockLauncherLogoColorOverride": "",
        "dockLauncherLogoSizeOffset": 0,
        "dockLauncherLogoBrightness": 0.5,
        "dockLauncherLogoContrast": 1,
        "dockMaxVisibleApps": 0,
        "dockMaxVisibleRunningApps": 0,
        "dockShowOverflowBadge": true,
        "notificationOverlayEnabled": false,
        "notificationPopupShadowEnabled": true,
        "notificationPopupPrivacyMode": false,
        "modalDarkenBackground": false,
        "lockScreenShowPowerActions": true,
        "lockScreenShowSystemIcons": true,
        "lockScreenShowTime": true,
        "lockScreenShowDate": true,
        "lockScreenShowProfileImage": true,
        "lockScreenShowPasswordField": true,
        "lockScreenShowMediaPlayer": true,
        "lockScreenPowerOffMonitorsOnLock": false,
        "lockAtStartup": false,
        "enableFprint": false,
        "maxFprintTries": 15,
        "lockScreenActiveMonitor": "all",
        "lockScreenInactiveColor": "#000000",
        "lockScreenNotificationMode": 0,
        "hideBrightnessSlider": false,
        "notificationTimeoutLow": 5000,
        "notificationTimeoutNormal": 5000,
        "notificationTimeoutCritical": 0,
        "notificationCompactMode": false,
        "notificationPopupPosition": 0,
        "notificationAnimationSpeed": 1,
        "notificationCustomAnimationDuration": 400,
        "notificationHistoryEnabled": true,
        "notificationHistoryMaxCount": 50,
        "notificationHistoryMaxAgeDays": 7,
        "notificationHistorySaveLow": true,
        "notificationHistorySaveNormal": true,
        "notificationHistorySaveCritical": true,
        "notificationRules": [],
        "osdAlwaysShowValue": false,
        "osdPosition": 5,
        "osdVolumeEnabled": true,
        "osdMediaVolumeEnabled": true,
        "osdMediaPlaybackEnabled": false,
        "osdBrightnessEnabled": true,
        "osdIdleInhibitorEnabled": true,
        "osdMicMuteEnabled": true,
        "osdCapsLockEnabled": true,
        "osdPowerProfileEnabled": true,
        "osdAudioOutputEnabled": true,
        "powerActionConfirm": true,
        "powerActionHoldDuration": 0.5,
        "powerMenuActions": [
          "reboot",
          "logout",
          "poweroff",
          "lock",
          "suspend",
          "restart"
        ],
        "powerMenuDefaultAction": "logout",
        "powerMenuGridLayout": false,
        "customPowerActionLock": "",
        "customPowerActionLogout": "",
        "customPowerActionSuspend": "",
        "customPowerActionHibernate": "",
        "customPowerActionReboot": "",
        "customPowerActionPowerOff": "",
        "updaterHideWidget": false,
        "updaterUseCustomCommand": false,
        "updaterCustomCommand": "",
        "updaterTerminalAdditionalParams": "",
        "displayNameMode": "system",
        "screenPreferences": {
          "wallpaper": [
            "all"
          ]
        },
        "showOnLastDisplay": {},
        "niriOutputSettings": {},
        "hyprlandOutputSettings": {},
        "displayProfiles": {},
        "activeDisplayProfile": {},
        "displayProfileAutoSelect": false,
        "displayShowDisconnected": false,
        "displaySnapToEdge": true,
        "barConfigs": [
          {
            "id": "default",
            "name": "Main Bar",
            "enabled": true,
            "position": 0,
            "screenPreferences": [
              {
                "name": "DP-1",
                "model": "Q27G42ZE",
                "modelIndex": 1
              },
              {
                "name": "DP-3",
                "model": "Q27G42ZE",
                "modelIndex": 0
              }
            ],
            "showOnLastDisplay": true,
            "leftWidgets": [
              "launcherButton",
              "workspaceSwitcher",
              "focusedWindow"
            ],
            "centerWidgets": [
              "music",
              "clock",
              "weather"
            ],
            "rightWidgets": [
              "systemTray",
              "clipboard",
              "cpuUsage",
              "memUsage",
              "notificationButton",
              "battery",
              "controlCenterButton"
            ],
            "spacing": 0,
            "innerPadding": 0,
            "bottomGap": 0,
            "transparency": 0.4,
            "widgetTransparency": 1,
            "squareCorners": true,
            "noBackground": true,
            "maximizeWidgetIcons": false,
            "maximizeWidgetText": false,
            "removeWidgetPadding": false,
            "widgetPadding": 8,
            "gothCornersEnabled": true,
            "gothCornerRadiusOverride": false,
            "gothCornerRadiusValue": 12,
            "borderEnabled": true,
            "borderColor": "surfaceText",
            "borderOpacity": 1,
            "borderThickness": 1,
            "widgetOutlineEnabled": false,
            "widgetOutlineColor": "primary",
            "widgetOutlineOpacity": 1,
            "widgetOutlineThickness": 1,
            "fontScale": 0.99,
            "iconScale": 1,
            "autoHide": false,
            "autoHideDelay": 250,
            "showOnWindowsOpen": false,
            "openOnOverview": false,
            "visible": true,
            "popupGapsAuto": true,
            "popupGapsManual": 4,
            "maximizeDetection": true,
            "scrollEnabled": true,
            "scrollXBehavior": "column",
            "scrollYBehavior": "workspace",
            "shadowIntensity": 55,
            "shadowOpacity": 60,
            "shadowColorMode": "surface",
            "shadowCustomColor": "#000000",
            "clickThrough": false
          }
        ],
        "desktopClockEnabled": false,
        "desktopClockStyle": "analog",
        "desktopClockTransparency": 0.8,
        "desktopClockColorMode": "primary",
        "desktopClockCustomColor": {
          "r": 1,
          "g": 1,
          "b": 1,
          "a": 1,
          "hsvHue": -1,
          "hsvSaturation": 0,
          "hsvValue": 1,
          "hslHue": -1,
          "hslSaturation": 0,
          "hslLightness": 1,
          "valid": true
        },
        "desktopClockShowDate": true,
        "desktopClockShowAnalogNumbers": false,
        "desktopClockShowAnalogSeconds": true,
        "desktopClockX": -1,
        "desktopClockY": -1,
        "desktopClockWidth": 280,
        "desktopClockHeight": 180,
        "desktopClockDisplayPreferences": [
          "all"
        ],
        "systemMonitorEnabled": false,
        "systemMonitorShowHeader": true,
        "systemMonitorTransparency": 0.8,
        "systemMonitorColorMode": "primary",
        "systemMonitorCustomColor": {
          "r": 1,
          "g": 1,
          "b": 1,
          "a": 1,
          "hsvHue": -1,
          "hsvSaturation": 0,
          "hsvValue": 1,
          "hslHue": -1,
          "hslSaturation": 0,
          "hslLightness": 1,
          "valid": true
        },
        "systemMonitorShowCpu": true,
        "systemMonitorShowCpuGraph": true,
        "systemMonitorShowCpuTemp": true,
        "systemMonitorShowGpuTemp": false,
        "systemMonitorGpuPciId": "",
        "systemMonitorShowMemory": true,
        "systemMonitorShowMemoryGraph": true,
        "systemMonitorShowNetwork": true,
        "systemMonitorShowNetworkGraph": true,
        "systemMonitorShowDisk": true,
        "systemMonitorShowTopProcesses": false,
        "systemMonitorTopProcessCount": 3,
        "systemMonitorTopProcessSortBy": "cpu",
        "systemMonitorGraphInterval": 60,
        "systemMonitorLayoutMode": "auto",
        "systemMonitorX": -1,
        "systemMonitorY": -1,
        "systemMonitorWidth": 320,
        "systemMonitorHeight": 480,
        "systemMonitorDisplayPreferences": [
          "all"
        ],
        "systemMonitorVariants": [],
        "desktopWidgetPositions": {},
        "desktopWidgetGridSettings": {},
        "desktopWidgetInstances": [],
        "desktopWidgetGroups": [],
        "builtInPluginSettings": {},
        "clipboardEnterToPaste": false,
        "launcherPluginVisibility": {},
        "launcherPluginOrder": [],
        "configVersion": 5
      }
    '';
  };

  programs.zsh.initContent = ''
    eval "$(starship init zsh)"
    export NIXOS_DE="niri"
  '';

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  home.packages = with pkgs; [
    xwayland-satellite
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
  ];
}
