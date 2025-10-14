{ config, pkgs, ... }:

{
    imports =
    [
        ./hardware-configuration.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";

    networking.networkmanager.enable = true;

    time.timeZone = "Australia/Sydney";

    i18n.defaultLocale = "en_AU.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_AU.UTF-8";
        LC_IDENTIFICATION = "en_AU.UTF-8";
        LC_MEASUREMENT = "en_AU.UTF-8";
        LC_MONETARY = "en_AU.UTF-8";
        LC_NAME = "en_AU.UTF-8";
        LC_NUMERIC = "en_AU.UTF-8";
        LC_PAPER = "en_AU.UTF-8";
        LC_TELEPHONE = "en_AU.UTF-8";
        LC_TIME = "en_AU.UTF-8";
    };

    services.xserver.xkb = {
        layout = "au";
        variant = "";
    };

    environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        SUDO_EDITOR = "nvim";
    };

    services.printing.enable = true;
    services.xserver = {
        enable = true;	
        windowManager.i3.enable = true;
    };

    services.displayManager.ly.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    users.users.mvayk = {
        isNormalUser = true;
        description = "John";
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
    };

    programs.neovim.enable = true;
    programs.dconf.enable = true;
    programs.firefox.enable = true;
    programs.zsh.enable = true;
    programs.neovim.defaultEditor = true;
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        git
        neovim
        curl
        wget
        keepassxc
        networkmanagerapplet
        xclip
        zsh
        unzip
        gcc
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.iosevka
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.openssh.enable = true;
    system.stateVersion = "25.05";
}
