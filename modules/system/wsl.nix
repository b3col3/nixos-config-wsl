{
  pkgs,
  state-version,
  env-config,
  ...
}:

{
  environment.localBinInPath = true;

  wsl = {
    enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
  };

  system.stateVersion = state-version;
}
