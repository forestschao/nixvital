{ config, pkgs, ... }:

{
  # In case we need ipv4 NAT for forwarding.
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };
  virtualisation.libvirtd.enable = true;
  users.extraUsers."$[config.vital.mainUser}".extraGroups = [ "libvi2rtd" ];
}
