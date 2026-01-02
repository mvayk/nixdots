{ config, pkgs, ... }:
{
    imports = getNixFiles nixDir ++ [
        ./zshrc.nix
    ];

    home.username = "mvayk";
    home.homeDirectory = "/home/mvayk";
    home.stateVersion = "25.05";

    programs.git = {
        enable = true;
        userName = "mvayk";
        userEmail = "mvayk@mvayk.mvayk";
    };

    services.syncthing = {
        enable = true;
        openDefaultPorts = true;
    };

    programs.zsh = {
        enable = true;
    };

    home.packages = with pkgs; [
    ];

    home.sessionVariables = {
    };
}
