{ ... }:
{
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
