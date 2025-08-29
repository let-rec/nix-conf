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
    packages = with pkgs; [
      anki
    ];
  #   sessionVariables = {
  #   STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
  #     "\${HOME}/.steam/root/compatibilitytools.d";
  # };
  };

  programs.home-manager.enable = true;
}
