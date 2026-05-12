{ pkgs, ... }:
{
  users.users.mvayk = {
    uid          = 1000;
    isNormalUser = true;
    shell        = pkgs.zsh;
    extraGroups  = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "video"
      "audio"
      "plugdev"
      "input"
    ];
    hashedPasswordFile = "/run/secrets/mvayk-password";
  };
}
