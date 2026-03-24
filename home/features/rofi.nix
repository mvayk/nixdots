{
  pkgs,
  ...
}:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    extraConfig = {
      show-icons = true;
      icon-theme = "Tela-dark";
      modi = "drun,run";
    };
  };

  xdg.configFile."rofi/config.rasi".text = ''
    * {
      font:             "JetBrainsMono Nerd Font 12";
      background-color: transparent;
      text-color:       #c1c1c1;
    }

    window {
      background-color: rgba(0,0,0,0.8);
      border:           1px;
      border-color:     rgba(255,255,255,0.4);
      width:            1200px;
    }

    mainbox {
      padding: 4px;
      spacing: 4px;
    }

    inputbar {
      background-color: rgba(64,64,64,0.2);
      border:           0px 0px 1px 0px;
      border-color:     rgba(255,255,255,0.4);
      padding:          0px 8px;
      spacing:          8px;
      children:         [prompt, entry];
    }

    prompt {
      text-color:  #486e6f;
      padding:     0px 8px 0px 0px;
      border:      0px 1px 0px 0px;
      border-color: rgba(255,255,255,0.4);
    }

    entry {
      placeholder:       "search...";
      placeholder-color: #888888;
      padding:           0px 8px;
    }

    listview {
      border:       1px 0px 0px 0px;
      border-color: rgba(64,64,64,0.4);
      padding:      4px 0px;
      spacing:      0px;
      lines:        8;
    }

    element {
      padding: 0px 8px;
      spacing: 8px;
      height:  28px;
    }

    element normal normal {
      background-color: transparent;
      text-color:       #aaaaaa;
    }

    element alternate normal {
      background-color: rgba(64,64,64,0.15);
      text-color:       #aaaaaa;
    }

    element selected normal {
      background-color: rgba(72,72,72,0.25);
      text-color:       #c1c1c1;
    }

    element normal urgent {
      text-color: #dd9999;
    }

    element alternate urgent {
      background-color: rgba(64,64,64,0.15);
      text-color:       #dd9999;
    }

    element selected urgent {
      background-color: rgba(160,102,102,0.25);
      text-color:       #dd9999;
    }

    element normal active {
      text-color: #999999;
    }

    element alternate active {
      background-color: rgba(64,64,64,0.15);
      text-color:       #999999;
    }

    element selected active {
      background-color: rgba(72,110,111,0.25);
      text-color:       #c1c1c1;
    }

    element-icon {
      size:  1.2em;
      padding: 0px 4px 0px 0px;
    }

    element-text {
      text-color:  inherit;
      color:       #aaaaaa;
    }
  '';
}
