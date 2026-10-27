{
  pkgs,
  lib,
  config,
  mkSub,
  ...
}: let
  cfg = config.my.virtualisation;
in {
  options.my.virtualisation = {
    enable = lib.mkEnableOption "libvirt/QEMU";
    gui.enable = mkSub (cfg.enable && config.my.desktop.enable) "virt-manager";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          vhostUserPackages = [pkgs.virtiofsd];
        };
      };
      environment.systemPackages = [pkgs.OVMF];
    })

    (lib.mkIf cfg.gui.enable {programs.virt-manager.enable = true;})
  ];
}
