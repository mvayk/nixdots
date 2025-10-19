{ config, pkgs, ... }:
{
  environment.etc."fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "type": "auto",
        "padding": {
          "top": 1,
          "left": 2
        }
      },
      "display": {
        "separator": "  ",
        "color": {
          "keys": "cyan",
          "title": "bold magenta"
        }
      },
      "modules": [
        {
          "type": "title",
          "format": "{#bold}{#magenta}{user-name-colored}{#at}{host-name-colored}"
        },
        {
          "type": "separator",
          "string": "─"
        },
        {
          "type": "os",
          "key": " OS",
          "keyColor": "blue"
        },
        {
          "type": "host",
          "key": "󰌢 Host",
          "keyColor": "blue"
        },
        {
          "type": "kernel",
          "key": " Kernel",
          "keyColor": "blue"
        },
        {
          "type": "uptime",
          "key": "󰔚 Uptime",
          "keyColor": "blue"
        },
        {
          "type": "packages",
          "key": "󰏖 Packages",
          "keyColor": "blue"
        },
        {
          "type": "shell",
          "key": " Shell",
          "keyColor": "blue"
        },
        {
          "type": "display",
          "key": "󰍹 Display",
          "keyColor": "blue"
        },
        {
          "type": "wm",
          "key": " WM",
          "keyColor": "blue"
        },
        {
          "type": "theme",
          "key": "󰉼 Theme",
          "keyColor": "blue"
        },
        {
          "type": "icons",
          "key": "󰀻 Icons",
          "keyColor": "blue"
        },
        {
          "type": "terminal",
          "key": " Terminal",
          "keyColor": "blue"
        },
        {
          "type": "terminalfont",
          "key": " Font",
          "keyColor": "blue"
        },
        {
          "type": "separator",
          "string": "─"
        },
        {
          "type": "cpu",
          "key": "󰻠 CPU",
          "keyColor": "green"
        },
        {
          "type": "gpu",
          "key": "󰢮 GPU",
          "keyColor": "green"
        },
        {
          "type": "memory",
          "key": " Memory",
          "keyColor": "green"
        },
        {
          "type": "disk",
          "key": "󰋊 Disk",
          "keyColor": "green"
        },
        {
          "type": "battery",
          "key": "󰁹 Battery",
          "keyColor": "green"
        },
        {
          "type": "separator",
          "string": "─"
        },
        {
          "type": "colors",
          "paddingLeft": 2,
          "symbol": "circle"
        }
      ]
    }
  '';
}
