{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    extraPackages = with pkgs; [
      ffmpeg
      imagemagick
      glow
      bat
      exiftool

      fd
      ripgrep
      fzf
      zoxide

      _7zz
      unrar

      jq
      mediainfo
      glow
    ];

    plugins = with pkgs.yaziPlugins; {
      full-border = full-border;
      toggle-pane = toggle-pane;
      bypass = bypass;
      jump-to-char = jump-to-char;
      relative-motions = relative-motions;
      bookmarks = bookmarks;

      git = git;
      lazygit = lazygit;

      chmod = chmod;
      compress = compress;
      diff = diff;
      smart-filter = smart-filter;
      smart-paste = smart-paste;

      glow = glow;
      mediainfo = mediainfo;
      miller = miller;
      mime-ext = mime-ext;

      mount = mount;
      dupes = dupes;
    };

    initLua = ''
      require("full-border"):setup()
      require("git"):setup()
      require("relative-motions"):setup({ show_numbers = "relative_absolute", show_motion = true })
      require("mime-ext"):setup({
        with_files = { "Makefile", "Dockerfile", ".gitignore", ".env" },
      })
    '';

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "T";
          run = "plugin toggle-pane max-preview";
          desc = "Maximise preview pane";
        }
        {
          on = [
            "T"
            "p"
          ];
          run = "plugin toggle-pane --args=hide-preview";
          desc = "Hide preview pane";
        }
        {
          on = [
            "T"
            "P"
          ];
          run = "plugin toggle-pane --args=show-parent";
          desc = "Show parent pane";
        }

        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "Chmod selected files";
        }

        {
          on = [
            "c"
            "z"
          ];
          run = "plugin compress";
          desc = "Compress selected files";
        }

        {
          on = [
            "c"
            "d"
          ];
          run = "plugin diff";
          desc = "Diff hovered vs selected";
        }

        {
          on = "f";
          run = "plugin jump-to-char";
          desc = "Jump to next file starting with char";
        }

        {
          on = "F";
          run = "plugin smart-filter";
          desc = "Smart filter";
        }

        {
          on = [
            "b"
            "m"
          ];
          run = "plugin bookmarks --args=save";
          desc = "Save bookmark";
        }
        {
          on = [
            "b"
            "'"
          ];
          run = "plugin bookmarks --args=jump";
          desc = "Jump to bookmark";
        }
        {
          on = [
            "b"
            "d"
          ];
          run = "plugin bookmarks --args=delete";
          desc = "Delete bookmark";
        }

        {
          on = [
            "g"
            "l"
          ];
          run = "plugin lazygit";
          desc = "Open lazygit";
        }

        {
          on = [
            "g"
            "m"
          ];
          run = "plugin mount";
          desc = "Open mount manager";
        }

        {
          on = [
            "g"
            "u"
          ];
          run = "plugin dupes";
          desc = "Find duplicate files";
        }
      ];
    };

    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_symlink = true;
        ratio = [
          1
          4
          3
        ];
      };

      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        image_filter = "lanczos3";
        image_quality = 90;
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };

      tasks = {
        micro_workers = 5;
        macro_workers = 10;
        bizarre_retry = 5;
      };

      opener = {
        edit = [
          {
            run = ''$EDITOR "$@"'';
            block = true;
            desc = "$EDITOR";
            for = "unix";
          }
        ];
        play = [
          {
            run = ''mpv --force-window "$@"'';
            orphan = true;
            desc = "mpv";
            for = "unix";
          }
        ];
        view = [
          {
            run = ''feh -Z --start-at "$@"'';
            orphan = true;
            desc = "feh";
            for = "unix";
          }
        ];
      };

      open = {
        rules = [
          {
            mime = "text/*";
            use = [
              "edit"
              "reveal"
            ];
          }
          {
            mime = "video/*";
            use = [
              "play"
              "reveal"
            ];
          }
          {
            mime = "audio/*";
            use = [
              "play"
              "reveal"
            ];
          }
          {
            mime = "image/*";
            use = [
              "view"
              "reveal"
            ];
          }
          {
            mime = "inode/directory";
            use = "open";
          }
          {
            mime = "*";
            use = [
              "open"
              "edit"
              "reveal"
            ];
          }
        ];
      };
    };
  };
}
