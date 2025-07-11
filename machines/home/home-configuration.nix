#{ pkgs, lib, ... }:
#let
#    hp = import ../../modules/home;
#in
#{
#    imports = with hp; [
#        vscode
#        git
#        packages
#        zsh
#    ];
#
#    home.stateVersion = "25.05";
#}
