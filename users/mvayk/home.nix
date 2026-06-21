{de, ...}: {
  imports = [
    #../../home/base.nix
    (../../home/de + "/${de}/default.nix")

    ../../home/features/zsh.nix
    ../../home/features/yazi.nix
    ../../home/features/fish.nix
    ../../home/features/starship.nix
    ../../home/features/btop.nix
    ../../home/features/tmux.nix
  ];

  home = {
    username = "mvayk";
    homeDirectory = "/home/mvayk";
    stateVersion = "25.05";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
    MANPAGER = "bat";
    CARGO_HOME = "$HOME/.cargo";
  };

  home.sessionPath = ["$HOME/.cargo/bin"];

  programs.home-manager.enable = true;

  services.syncthing.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "mvayk";
        email = "45300955+mvayk@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core = {
        editor = "nvim";
        autocrlf = false;
      };
      diff.colorMoved = "zebra";
      aliases = {
        lg = "log --oneline --graph --decorate";
        st = "status -sb";
        co = "checkout";
        br = "branch";
        undo = "reset HEAD~1 --mixed";
      };
    };
  };

  programs.lazygit.enable = true;
}
