{ config, pkgs, ... }:
{
    imports = [
        ../../common/shared-home.nix
        ../../home/experimental_kanagawa/home.nix
    ];
}
