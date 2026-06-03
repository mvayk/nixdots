{ ... }:
{
  xdg.configFile."fastfetch/config.jsonc".text = ''
      {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "logo": {
          "type": "kitty",
          "source": "/etc/nixos/home/features/fastfetch/uruha_rushia_render_jmsg7.png",
          "height": 12,
          "padding": {
            "top": 2,
            "right": 5,
            "left": 3
          }
        },
    "display": {
          "separator": " ⟫  ",
          "color": {
              "keys": "magenta",
              "title": "red"
          },
          "constants": [
              "──────────────────────────────────────────"
          ]
      },
      "modules": [
          {
              "type": "title",
              "format": " {user-name-colored}@{host-name-colored} ",
              "output": {
                  "color": {
                      "user": "red",
                      "at": "white",
                      "host": "yellow"
                  }
              }
          },
          {
              "type": "custom",
              "format": "{$1}",
              "output": { "color": "red" }
          },
          {
              "type": "os",
              "key": " 󰌢  DISTRO   ",
              "format": "{2}"
          },
          {
              "type": "kernel",
              "key": " 󰚀  KERNEL   ",
              "format": "{2}"
          },
          {
              "type": "uptime",
              "key": " 󱎫  ACTIVE   "
          },
          {
              "type": "custom",
              "format": "{$1}",
              "output": { "color": "red" }
          },
          {
              "type": "cpu",
              "key": " 󰻠  CPU      ",
              "format": "{1} @ {6}"
          },
          {
              "type": "gpu",
              "key": " 󰢮  GPU      ",
              "format": "{2}"
          },
          {
              "type": "memory",
              "key": " 󰍛  MEMORY   ",
              "format": "{1} / {2} ({3})"
          },
          {
              "type": "disk",
              "key": " 󰋊  STORAGE  ",
              "format": "{1} / {2} ({3})",
              "folders": "/"
          },
          {
              "type": "custom",
              "format": "{$1}",
              "output": { "color": "red" }
          },
          {
              "type": "shell",
              "key": "   SHELL    ",
              "format": "{1} {4}"
          },
          {
              "type": "wm",
              "key": " 󱂬  WM       ",
              "format": "{1}"
          },
          {
              "type": "terminal",
              "key": "   CONSOLE  "
          },
          {
              "type": "custom",
              "format": "{$1}",
              "output": { "color": "red" }
          },
          {
              "type": "command",
              "key": " 󱐋  BATTERY  ",
              "text": "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{print $2}'",
              "format": "{}"
          },
          {
              "type": "break"
          },
          {
              "type": "colors",
              "symbol": "circle",
              "block": {
                  "range": [1, 6]
              }
          }
      ]
      }
  '';
}
