{ config, pkgs, lib, ... }:
{

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "cma=256M" ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  swapDevices = [{ device = "/swapfile"; size = 1024; }];

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  users.extraUsers.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyQQJgFL7kJbP+DFX90Emhtv46i9eUfn0DBsUSG4sqZZyDll4C2cq8+91ZS1iw5cpMkSoh0f/3ZxkZihChMxa9ddr2BSm2kQSFRFbJShLS3+lzoT4rUIkFAeRECYUeUb+uS1GENa7fa0hJX866jg5ELPz378l1G2BtfecsTSc1xfojLTfYz6pfDIsVZzbg3+g8Uf9maGnrtqA3YzofSSGrUBzAXnYvvhMd2a9cIaiGjypsAqdTN/A+7ZWFeH1HeNQ33XW75F59wiJvA2jFTJBAOW9ptHDwe0VAiU7ffjgu3urrcaA8UIySRUFM1+tczxJ/3QtFmWljiEvxOFFxoEhN jeremy@Eldunari.local"
  ];
}
