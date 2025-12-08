{ config, pkgs, ... }:
let
  nixDir = ./nix;
  getNixFiles = dir:
    if builtins.pathExists dir then
      let
        files = builtins.attrNames (builtins.readDir dir);
        isNixFile = name: builtins.match ".*\\.nix$" name != null;
        nixFiles = builtins.filter isNixFile files;
      in
        map (name: "${dir}/${name}") nixFiles
    else [];
in
{
  imports = getNixFiles nixDir ++ [
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

  home.packages = with pkgs; [
    # Qt theming
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    lxappearance

    grim
    slurp
    wl-clipboard

    git
    gh              # GitHub CLI
    git-lfs         # Git Large File Storage
    delta           # Better git diff viewer
    lazygit         # Terminal UI for git
  ];

  programs.git = {
    enable = true;
    
    settings = {
      user = {
        name = "mvayk";
        email = "mvayk@mvayk.mvayk";
      };

      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "vim";
      
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      
      delta = {
        navigate = true;
        light = false;
        side-by-side = true;
      };
      
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      editor = "vim";
    };
  };
}
