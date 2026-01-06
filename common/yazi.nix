# thanks claude
{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    
    settings = {
      manager = {
        show_hidden = false;
        show_symlink = true;
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "size";
        scrolloff = 5;
      };
      
      preview = {
        max_width = 1000;
        max_height = 1000;
        tab_size = 2;
        cache_dir = "";
      };
      
      opener = {
        edit = [
          { run = ''nvim "$@"''; block = true; }
        ];
        image = [
          { run = ''feh "$@"''; orphan = true; }
        ];
        video = [
          { run = ''mpv "$@"''; orphan = true; }
        ];
        play = [
          { run = ''mpv "$@"''; orphan = true; }
        ];
        extract = [
          { run = ''unar "$@"''; }
        ];
      };
      
      open = {
        rules = [
          { mime = "text/*"; use = "edit"; }
          { mime = "image/*"; use = "image"; }
          { mime = "video/*"; use = "video"; }
          { mime = "audio/*"; use = "play"; }
          { mime = "application/zip"; use = "extract"; }
          { mime = "application/x-tar"; use = "extract"; }
          { mime = "application/x-bzip2"; use = "extract"; }
          { mime = "application/x-gzip"; use = "extract"; }
          { mime = "application/x-7z-compressed"; use = "extract"; }
        ];
      };
    };
    
    keymap = {
      manager.prepend_keymap = [
        # Navigation (vim bindings)
        { on = [ "h" ]; run = "leave"; desc = "Go back to parent directory"; }
        { on = [ "j" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "k" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "l" ]; run = "enter"; desc = "Enter directory or open file"; }
        
        # Fast navigation
        { on = [ "g" "g" ]; run = "arrow -99999999"; desc = "Move to top"; }
        { on = [ "G" ]; run = "arrow 99999999"; desc = "Move to bottom"; }
        { on = [ "<C-u>" ]; run = "arrow -50%"; desc = "Move up half page"; }
        { on = [ "<C-d>" ]; run = "arrow 50%"; desc = "Move down half page"; }
        
        # Selection
        { on = [ "<Space>" ]; run = "toggle"; desc = "Toggle selection"; }
        { on = [ "v" ]; run = "visual_mode"; desc = "Enter visual mode"; }
        { on = [ "V" ]; run = "visual_mode --unset"; desc = "Exit visual mode"; }
        
        # File operations
        { on = [ "y" "y" ]; run = "yank"; desc = "Copy selected files"; }
        { on = [ "d" "d" ]; run = "remove"; desc = "Delete selected files"; }
        { on = [ "p" ]; run = "paste"; desc = "Paste files"; }
        { on = [ "P" ]; run = "paste --force"; desc = "Paste and overwrite"; }
        { on = [ "x" ]; run = "remove --permanently"; desc = "Delete permanently"; }
        
        # File creation
        { on = [ "a" ]; run = "create"; desc = "Create file or directory"; }
        { on = [ "r" ]; run = "rename"; desc = "Rename file"; }
        
        # Search and filter
        { on = [ "/" ]; run = "find"; desc = "Find file"; }
        { on = [ "n" ]; run = "find_arrow"; desc = "Next search result"; }
        { on = [ "N" ]; run = "find_arrow --previous"; desc = "Previous search result"; }
        { on = [ "f" ]; run = "filter"; desc = "Filter files"; }
        
        # Shell and edit
        { on = [ "!" ]; run = "shell"; desc = "Run shell command"; }
        { on = [ ":" ]; run = "shell --block"; desc = "Run shell command (blocking)"; }
        { on = [ "e" ]; run = "open"; desc = "Open file with default editor"; }
        
        # Hidden files
        { on = [ "z" "h" ]; run = "hidden toggle"; desc = "Toggle hidden files"; }
        
        # Sorting
        { on = [ "," "m" ]; run = "sort modified --dir-first"; desc = "Sort by modified time"; }
        { on = [ "," "s" ]; run = "sort size --dir-first"; desc = "Sort by size"; }
        { on = [ "," "n" ]; run = "sort natural --dir-first"; desc = "Sort naturally"; }
        
        # Tabs
        { on = [ "t" ]; run = "tab_create --current"; desc = "Create new tab"; }
        { on = [ "T" ]; run = "tab_close"; desc = "Close current tab"; }
        { on = [ "[" ]; run = "tab_switch -1 --relative"; desc = "Previous tab"; }
        { on = [ "]" ]; run = "tab_switch 1 --relative"; desc = "Next tab"; }
        
        # Misc
        { on = [ "q" ]; run = "quit"; desc = "Quit yazi"; }
        { on = [ "<C-r>" ]; run = "refresh"; desc = "Refresh directory"; }
        { on = [ "?" ]; run = "help"; desc = "Show help"; }
      ];
    };
    
    theme = {
      manager = {
        cwd = { fg = "cyan"; };
        hovered = { fg = "black"; bg = "lightblue"; };
        preview_hovered = { underline = true; };
        find_keyword = { fg = "yellow"; italic = true; };
        find_position = { fg = "magenta"; bg = "reset"; italic = true; };
        marker_selected = { fg = "lightgreen"; bg = "lightgreen"; };
        marker_copied = { fg = "lightyellow"; bg = "lightyellow"; };
        marker_cut = { fg = "lightred"; bg = "lightred"; };
        tab_active = { fg = "black"; bg = "lightblue"; };
        tab_inactive = { fg = "white"; bg = "darkgray"; };
        border_symbol = "│";
        border_style = { fg = "gray"; };
      };
      
      status = {
        separator_open = "";
        separator_close = "";
        separator_style = { fg = "gray"; bg = "gray"; };
        mode_normal = { fg = "black"; bg = "lightblue"; bold = true; };
        mode_select = { fg = "black"; bg = "lightgreen"; bold = true; };
        mode_unset = { fg = "black"; bg = "lightmagenta"; bold = true; };
        progress_label = { bold = true; };
        progress_normal = { fg = "blue"; bg = "black"; };
        progress_error = { fg = "red"; bg = "black"; };
      };
      
      select = {
        border = { fg = "blue"; };
        active = { fg = "magenta"; };
        inactive = { fg = "white"; };
      };
      
      input = {
        border = { fg = "blue"; };
        title = { };
        value = { };
        selected = { reversed = true; };
      };
      
      completion = {
        border = { fg = "blue"; };
        active = { bg = "darkgray"; };
        inactive = { };
      };
      
      tasks = {
        border = { fg = "blue"; };
        title = { };
        hovered = { underline = true; };
      };
      
      which = {
        cols = 3;
        mask = { bg = "black"; };
        cand = { fg = "lightcyan"; };
        rest = { fg = "darkgray"; };
        desc = { fg = "magenta"; };
        separator = "  ";
        separator_style = { fg = "darkgray"; };
      };
    };
  };
  
  # Dependencies
  home.packages = with pkgs; [
    yazi
    ffmpegthumbnailer  # Video thumbnails
    unar              # Archive extraction
    jq                # JSON preview
    poppler-utils     # PDF preview
    fd                # Better file finding
    ripgrep           # Better text search
    fzf               # Fuzzy finding
    zoxide            # Smart directory jumping
  ];
}
