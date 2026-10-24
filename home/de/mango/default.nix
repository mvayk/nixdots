{
  config,
  pkgs,
  lib,
  inputs,
  theme,
  machine,
  ...
}: let
  tags = lib.range 1 9;
  tagBinds =
    lib.concatMap (n: let
      s = toString n;
    in [
      "SUPER,${s},view,${s},0"
      "SUPER+SHIFT,${s},tag,${s},0"
    ])
    tags;
in {
  imports = [
    ./theme/${theme}/default.nix
    ../../presets/wayland.nix
    inputs.mango.hmModules.mango
  ];

  wayland.windowManager.mango = {
    enable = true;
    settings = {
      sloppy_focus = 1;
      xkb_rules_layout = "us";
      xkb_rules_options = "caps:escape_shifted_capslock";
      mouse_accel_profile = 1;
      mouse_accel_speed = 0.0;
      tap_to_click = 1;
      trackpad_natural_scrolling = 0;
      trackpad_scroll_factor = 0.25;
      tag_animation_direction = 0;

      scroller_default_proportion = 1.0;
      scroller_proportion_preset = "0.5,0.333333,0.666667";
      tag_rule = [
        "id:1,layout_name:scroller"
        "id:2,layout_name:tile"
        "id:3,layout_name:grid"
        "id:4,layout_name:monocle"
        "id:5,layout_name:deck"
        "id:6,layout_name:center_tile"
        "id:7,layout_name:dwindle"
        "id:8,layout_name:vertical_scroller"
        "id:9,layout_name:scroller"
      ];

      circle_layout = "scroller,tile,grid,dwindle,center_tile,monocle,deck";

      monitor_rule =
        if machine == "flandre"
        then [
          "name:^DP-2$,width:2560,height:1440,refresh:240,x:0,y:720"
          "name:^DP-1$,width:2560,height:1440,refresh:240,x:2560,y:720"
          "name:^DP-3$,width:2560,height:1440,refresh:240,x:5120,y:0,rr:3"
        ]
        else [
          "name:^eDP-1$,width:1920,height:1080,refresh:144,x:0,y:0"
        ];

      bind =
        [
          "SUPER,u,reload_config"
          "SUPER,t,spawn,ghostty"
          "SUPER,w,spawn,zen-beta"
          "SUPER,d,spawn,neovide"
          "SUPER,e,spawn,dolphin"

          "SUPER+SHIFT,s,spawn_shell,grim -g \"$(slurp)\" - | tee ~/Documents/sync/pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy"
          "CTRL,Print,spawn_shell,grim - | wl-copy"

          "SUPER,q,killclient"
          "SUPER,f,togglemaximizescreen"
          "SUPER+SHIFT,f,togglefullscreen"
          "SUPER,v,togglefloating"
          "SUPER,r,switch_proportion_preset"
          "SUPER,m,quit"
          "SUPER,s,toggleoverview"

          "SUPER,h,focusdir,left"
          "SUPER,l,focusdir,right"
          "SUPER,k,focusdir,up"
          "SUPER,j,focusdir,down"

          "SUPER+SHIFT,h,exchange_client,left"
          "SUPER+SHIFT,l,exchange_client,right"
          "SUPER+SHIFT,k,exchange_client,up"
          "SUPER+SHIFT,j,exchange_client,down"

          "SUPER+CTRL,h,focusmon,left"
          "SUPER+CTRL,l,focusmon,right"
          "SUPER+CTRL,k,focusmon,up"
          "SUPER+CTRL,j,focusmon,down"
          "SUPER+SHIFT+CTRL,h,tagmon,left"
          "SUPER+SHIFT+CTRL,l,tagmon,right"

          "SUPER+ALT,l,resizewin,+50,+0"
          "SUPER+ALT,h,resizewin,-50,+0"
          "SUPER+ALT,k,resizewin,+0,-50"
          "SUPER+ALT,j,resizewin,+0,+50"

          "SUPER,n,switch_layout"
          "SUPER+CTRL,t,setlayout,tile"
          "SUPER+CTRL,s,setlayout,scroller"
          "SUPER+CTRL,g,setlayout,grid"
          "SUPER+CTRL,d,setlayout,dwindle"
          "SUPER+CTRL,m,setlayout,monocle"
          "SUPER+CTRL,c,setlayout,center_tile"
        ]
        ++ tagBinds
        ++ lib.optionals (machine == "coerxion") [
          "NONE,XF86AudioRaiseVolume,spawn,pamixer --increase 5"
          "NONE,XF86AudioLowerVolume,spawn,pamixer --decrease 5"
          "NONE,XF86MonBrightnessUp,spawn,brightnessctl set 1%+"
          "NONE,XF86MonBrightnessDown,spawn,brightnessctl set 1%-"
        ];

      axisbind = [
        "SUPER,UP,focusdir,left"
        "SUPER,DOWN,focusdir,right"
        "SUPER+SHIFT,UP,viewtoleft"
        "SUPER+SHIFT,DOWN,viewtoright"
      ];
      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
      ];
    };
  };
}
