{ config, pkgs, machine, theme, ... }:
{
    imports = [
        ../modules/tmux.nix
        ../modules/zshrc.nix
        ../modules/yazi.nix
    ];

    home.username = "mvayk";
    home.homeDirectory = "/home/mvayk";
    home.stateVersion = "25.05";

    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "mvayk";
                email = "45300955+mvayk@users.noreply.github.com";
            };
        };
    };

    services.syncthing = {
        enable = true;
    };

    programs.zsh = {
        enable = true;
    };

    home.packages = with pkgs; [
    ];

    home.sessionVariables = {
        NIXOS_MACHINE = machine;
        NIXOS_THEME   = theme;
        PAGER = "bat";
        EDITOR = "nvim";
    };
    home.sessionPath = [
        "$HOME/.cargo/bin"
    ];
}
