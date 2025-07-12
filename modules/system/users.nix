{
  pkgs,
  env-config,
  ...
}:

{
  users.users.${env-config.username} = {
    isNormalUser = true;
    description = env-config.username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];

    shell = pkgs.fish;
  };
}
