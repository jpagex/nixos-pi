{ config, pkgs, lib, ... }:
{

  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix>
  ];

  sdImage.compressImage = true;

  boot.kernelPackages = pkgs.linuxPackages_rpi3;

  # !!! Needed for the virtual console to work on the RPi 3, as the default of 16M doesn't seem to be enough.
  # If X.org behaves weirdly (I only saw the cursor) then try increasing this to 256M.
  # On a Raspberry Pi 4 with 4 GB, you should either disable this parameter or increase to at least 64M if you want the USB ports to work.
  boot.kernelParams = [ "cma=256M" ];

  # Settings above are the bare minimum
  # All settings below are customized depending on your needs

  environment.systemPackages = with pkgs; [
    vim
    curl
    bind
    iptables
    openvpn
    python3
    nodejs-14_x
    docker-compose
  ];

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "eastwood";
    };
  };

  virtualisation.docker.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.mutableUsers = true;
  users.users.nixos.shell = pkgs.zsh;
  users.users.nixos.extraGroups = [ "wheel" "networkmanager" "video" "docker" ];
  users.extraUsers.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyQQJgFL7kJbP+DFX90Emhtv46i9eUfn0DBsUSG4sqZZyDll4C2cq8+91ZS1iw5cpMkSoh0f/3ZxkZihChMxa9ddr2BSm2kQSFRFbJShLS3+lzoT4rUIkFAeRECYUeUb+uS1GENa7fa0hJX866jg5ELPz378l1G2BtfecsTSc1xfojLTfYz6pfDIsVZzbg3+g8Uf9maGnrtqA3YzofSSGrUBzAXnYvvhMd2a9cIaiGjypsAqdTN/A+7ZWFeH1HeNQ33XW75F59wiJvA2jFTJBAOW9ptHDwe0VAiU7ffjgu3urrcaA8UIySRUFM1+tczxJ/3QtFmWljiEvxOFFxoEhN jeremy@Eldunari.local"
  ];
}
