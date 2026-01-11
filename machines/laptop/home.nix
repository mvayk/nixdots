{ config, pkgs, ... }:
{
    imports = [
        ../../common/shared-home.nix
        ../../home/experimental_laptop/home.nix
    ];
}
