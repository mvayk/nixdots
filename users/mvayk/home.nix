{ de, ... }:
{
  imports = [
    ../../home/base.nix
    (../../home/de + "/${de}/default.nix")
  ];

  home = {
    username     = "mvayk";
    homeDirectory = "/home/mvayk";
    stateVersion = "25.05";
  };

  home.sessionVariables = {
    EDITOR   = "nvim";
    PAGER    = "bat";
    MANPAGER = "bat";
    CARGO_HOME = "$HOME/.cargo";
  };

  home.sessionPath = [ "$HOME/.cargo/bin" ];

  programs.home-manager.enable = true;
}
