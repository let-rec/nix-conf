{
  outputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    outputs.homeModules.starship
    outputs.homeModules.zsh
    outputs.homeModules.git
    # outputs.homeModules.ssh
    outputs.homeModules.nixpkgs
    outputs.homeModules.packages
    outputs.homeModules.fastfetch
    outputs.homeModules.vscode
    # outputs.homeModules.firefox
  ];
  home = {
    stateVersion = "24.11";
    username = "letrec";
    homeDirectory = "/home/letrec";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;
}
