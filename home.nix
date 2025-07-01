{
  outputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    #outputs.homeModules.bash
    outputs.homeModules.vscode
    #outputs.homeModules.firefox
    #outputs.homeModules.direnv
    outputs.homeModules.zsh
    outputs.homeModules.git
    #outputs.homeModules.ssh
    #outputs.homeModules.zed
    #outputs.homeModules.nixpkgs
    #outputs.homeModules.packages
    outputs.homeModules.fastfetch
    outputs.homeModules.nixpkgs
  ];
  home = {
    stateVersion = "24.11";
    username = "letrec";
    homeDirectory = "/home/letrec";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;

}