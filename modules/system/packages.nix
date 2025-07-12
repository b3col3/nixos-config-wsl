{
  pkgs,
  pkgs-unstable,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      # Dev
      devbox
      gh
      go
      nixfmt-rfc-style

      # utils
      wget
    ];
  };
}
