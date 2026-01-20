{ config, pkgs, lib, ... }:

{
    programs.yazi = {
        enable = true;
        enableZshIntegration = true;

        settings = {
            manager = {
                show_hidden = true;
                sort_by = "natural";
                sort_sensitive = false;
                sort_reverse = false;
                sort_dir_first = true;
                linemode = "size";
                show_symlink = true;
            };

            preview = {
                tab_size = 2;
                max_width = 600;
                max_height = 900;
                cache_dir = "";
            };

            opener = {
                edit = [
                { run = ''$EDITOR "$@"''; block = true; for = "unix"; }
                ];
                play = [
                { run = ''mpv "$@"''; orphan = true; for = "unix"; }
                ];
                view_image = [
                { run = ''feh "$@"''; orphan = true; for = "unix"; }
                ];
                view_pdf = [
                { run = ''zathura "$@"''; orphan = true; for = "unix"; }
                ];
                open = [
                { run = ''xdg-open "$@"''; desc = "Open"; for = "linux"; }
                { run = ''open "$@"''; desc = "Open"; for = "macos"; }
                ];
            };

            open = {
                rules = [
                { mime = "text/*"; use = "edit"; }
                { mime = "image/*"; use = "view_image"; }
                { mime = "video/*"; use = "play"; }
                { mime = "audio/*"; use = "play"; }
                { mime = "application/pdf"; use = "view_pdf"; }
                { mime = "inode/directory"; use = "open"; }
                ];
            };
        };

        keymap = {
            manager.prepend_keymap = [
            { on = [ "<C-s>" ]; run = "shell '$SHELL' --block --confirm"; desc = "Open shell"; }
            { on = [ "l" ]; run = "plugin --sync smart-enter"; desc = "Enter directory or open file"; }
            { on = [ "g" "h" ]; run = "cd ~"; desc = "Go to home"; }
            { on = [ "g" "c" ]; run = "cd ~/.config"; desc = "Go to config"; }
            { on = [ "g" "d" ]; run = "cd ~/Downloads"; desc = "Go to downloads"; }
            { on = [ "y" ]; run = "yank"; desc = "Yank selected files"; }
            ];
        };
    };
}
