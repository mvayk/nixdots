{...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        ┌$username$all└─$character
      '';
      right_format = "";
      # custard = {
      #   symbol = "in";
      #   style_user = "italic white";
      #   style_root = "italic white";
      #   format = "[$custard]($style)";
      # };
      username = {
        disabled = false;
        show_always = true;
        style_user = "bold red";
        style_root = "bold red";
        format = "[\\[]()[$user]($style)[\\]]()[ in ]()";
      };
      hostname = {
        disabled = true;
        ssh_only = false;
        format = "[@](white)[$hostname]($style) ";
        style = "bold italic purple";
        ssh_symbol = " ";
      };
      os = {
        disabled = true;
        format = "[$symbol]($style) ";
      };
      # character = {
      #   disabled = false;
      #   success_symbol = "[](bold white)";
      #   error_symbol = "[](bold red)";
      # };
      character = {
        disabled = false;
        success_symbol = "[󰫍](bold green)";
        error_symbol = "[󰫍](bold red)";
      };
      cmd_duration = {
        disabled = false;
        min_time = 2000;
        format = "[$duration]($style)";
        style = "bold yellow";
      };
      git_metrics = {
        disabled = false;
        added_style = "bold green";
        deleted_style = "bold red";
        format = "[+$added]($added_style)/[-$deleted]($deleted_style) ";
      };
      battery = {
        disabled = true;
      };
      jobs = {
        disabled = true;
      };
      aws = {
        symbol = " ";
      };
      buf = {
        symbol = " ";
      };
      bun = {
        symbol = " ";
      };
      c = {
        symbol = " ";
      };
      cpp = {
        symbol = " ";
      };
      cmake = {
        symbol = " ";
      };
      conda = {
        symbol = " ";
      };
      crystal = {
        symbol = " ";
      };
      dart = {
        symbol = " ";
      };
      deno = {
        symbol = " ";
      };
      directory = {
        read_only = " 󰌾";
      };
      docker_context = {
        symbol = " ";
      };
      elixir = {
        symbol = " ";
      };
      elm = {
        symbol = " ";
      };
      fennel = {
        symbol = " ";
      };
      fortran = {
        symbol = " ";
      };
      fossil_branch = {
        symbol = " ";
      };
      gcloud = {
        symbol = " ";
      };
      git_branch = {
        symbol = " ";
      };
      git_commit = {
        tag_symbol = "  ";
      };
      golang = {
        symbol = " ";
      };
      gradle = {
        symbol = " ";
      };
      guix_shell = {
        symbol = " ";
      };
      haskell = {
        symbol = " ";
      };
      haxe = {
        symbol = " ";
      };
      hg_branch = {
        symbol = " ";
      };
      java = {
        symbol = " ";
      };
      julia = {
        symbol = " ";
      };
      kotlin = {
        symbol = " ";
      };
      lua = {
        symbol = " ";
      };
      memory_usage = {
        symbol = "󰍛 ";
      };
      meson = {
        symbol = "󰔷 ";
      };
      nim = {
        symbol = "󰆥 ";
      };
      nix_shell = {
        symbol = " ";
      };
      nodejs = {
        symbol = " ";
      };
      ocaml = {
        symbol = " ";
      };
      os.symbols = {
        Alpaquita = " ";
        Alpine = " ";
        AlmaLinux = " ";
        Amazon = " ";
        Android = " ";
        AOSC = " ";
        Arch = " ";
        Artix = " ";
        CachyOS = " ";
        CentOS = " ";
        Debian = " ";
        DragonFly = " ";
        Elementary = " ";
        Emscripten = " ";
        EndeavourOS = " ";
        Fedora = " ";
        FreeBSD = " ";
        Garuda = "󰛓 ";
        Gentoo = " ";
        HardenedBSD = "󰞌 ";
        Illumos = "󰈸 ";
        Ios = "󰀷 ";
        Kali = " ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Manjaro = " ";
        Mariner = " ";
        MidnightBSD = " ";
        Mint = " ";
        NetBSD = " ";
        NixOS = " ";
        Nobara = " ";
        OpenBSD = "󰈺 ";
        openSUSE = " ";
        OracleLinux = "󰌷 ";
        Pop = " ";
        Raspbian = " ";
        Redhat = " ";
        RedHatEnterprise = " ";
        RockyLinux = " ";
        Redox = "󰀘 ";
        Solus = "󰠳 ";
        SUSE = " ";
        Ubuntu = " ";
        Unknown = " ";
        Void = " ";
        Windows = "󰍲 ";
        Zorin = " ";
      };
      package = {
        symbol = "󰏗 ";
      };
      perl = {
        symbol = " ";
      };
      php = {
        symbol = " ";
      };
      pijul_channel = {
        symbol = " ";
      };
      pixi = {
        symbol = "󰏗 ";
      };
      python = {
        symbol = " ";
      };
      rlang = {
        symbol = "󰟔 ";
      };
      ruby = {
        symbol = " ";
      };
      rust = {
        symbol = "󱘗 ";
      };
      scala = {
        symbol = " ";
      };
      status = {
        symbol = " ";
      };
      swift = {
        symbol = " ";
      };
      xmake = {
        symbol = " ";
      };
      zig = {
        symbol = " ";
      };
    };
  };
}
