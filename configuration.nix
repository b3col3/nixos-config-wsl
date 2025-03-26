{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
    ./home.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "angoupil";
  };

  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };

    fish = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      wget
    ];
  };

  users.users.nixos = {
    isNormalUser = true;

    extraGroups = [
      "wheel"
      "docker"
    ];

    shell = pkgs.fish;
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };
  
  system.stateVersion = "24.11";
}
