{
  description = "Configuration Nix pour WSL";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      nixos-wsl,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      stateVersion = "25.05";

      envConfig = builtins.fromJSON (builtins.readFile ./env.json);

      systemConfig = ./modules/system;
      homeManagerConfig = ./modules/home;

      specialArgs = {
        pkgs-unstable = nixpkgs-unstable;
        state-version = stateVersion;
        env-config = envConfig;
      };
    in
    {
      nixosConfigurations = {
        ${envConfig.hostname} = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;

          modules = [
            # WSL
            nixos-wsl.nixosModules.wsl

            systemConfig

            # Home-manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.${envConfig.username} = homeManagerConfig;
            }
          ];
        };
      };
    };
}
