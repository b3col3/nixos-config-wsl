{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz;
in
{
  imports =
    [
      (import "${home-manager}/nixos")
    ];

  home-manager.users.nixos = { pkgs, ... }: {
    home = {
      stateVersion = "24.11";

      packages = with pkgs; [
        nixfmt-rfc-style
        minikube
        kubectl
      ];
    };

    programs = {
      fish = {
        enable = true;

        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';

        shellAliases = {
          ll = "ls -la";
          update = "sudo nixos-rebuild switch";

          # navigation shortcuts
          ".." = "cd ..";
          "..." = "cd ../../";
          "...." = "cd ../../../";
          "....." = "cd ../../../../";

          # git shortcuts
          ga = "git add .";
          gc = "git commit";
          gapa = "git add --patch";
          grpa = "git reset --patch";
          gst = "git status";
          gdh = "git diff HEAD";
          gp = "git push";
          gph = "git push -u origin HEAD";
          gco = "git checkout";
          gcob = "git checkout -b";
          gcm = "git checkout master";
          gcd = "git checkout develop";
          gsp = "git stash push -m";
          gsa = "git stash apply stash";
          gsl = "git stash list";

          # kubectl shortcut
          k = "kubectl";
        };
      };

      git = {
        enable = true;
        # userName = "";
        # userEmail = "";

        extraConfig = {
          credential.helper = "store";
        };
      };
    };
  };
}
