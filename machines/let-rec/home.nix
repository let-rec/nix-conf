{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.hm.gvariant) mkTuple mkUint32;
  hp = import ../../modules/home {inherit pkgs lib;};
in {
  imports = with hp; [
    vscode
    git
    zsh
    fastfetch
    bash
    direnv
    firefox
  ];

  home.stateVersion = "24.11";

  gtk = {
    enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple ["xkb" "us"])
        (mkTuple ["xkb" "ru"])
      ];
    };
  };

  # "org/gnome/desktop/peripherals/touchpad" = {
  #   tap-to-click = true;
  #   two-finger-scrolling-enabled = true;
  # };
  # "org/gnome/desktop/interface" = {
  #   color-scheme = "prefer-dark";
  #   font-name = "SF Pro Display 11";
  #   document-font-name = "SF Pro Display 11";
  #   monospace-font-name = "SF Mono Medium 12";
  #   show-battery-percentage = true;
  # };
  # "org/gnome/desktop/session" = {
  #   idle-delay = mkUint32 900;
  # };
  # "org/gnome/desktop/wm/preferences" = {
  #   button-layout = "appmenu:minimize,maximize,close";
  #   titlebar-font = "SF Pro Display Bold 11";
  # };
  # "org/gnome/settings-daemon/plugins/color" = {
  #   night-light-enabled = true;
  #   night-light-temperature = mkUint32 3700;
  # };
  # "org/gnome/settings-daemon/plugins/media-keys" = {
  #   custom-keybindings = [
  #     "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
  #     "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
  #     "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
  #     "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
  #   ];
  # };
  # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
  #   name = "Browser";
  #   command = "firefox";
  #   binding = "<Super>f";
  # };
  # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
  #   name = "Browser Private";
  #   command = "firefox --private-window";
  #   binding = "<Shift><Super>f";
  # };
  # "org/gtk/gtk4/settings/file-chooser" = {
  #   sort-directories-first = true;
  # };

  home.packages = with pkgs; [
    # floorp
    # ticktick
    # slack
    # zulip
    keepassxc
    # stacer
    # transmission_4-gtk
    # baobab
    # smartmontools
    # gcolor3
    # flameshot
    # libqalculate
    # nfs-utils
    # gnomeExtensions.appindicator
    # CLI
    difftastic
    htop
    jq
    ripgrep
    rlwrap
    spek
    tokei
    tree
    just
    # Documents
    mdbook
    mdbook-toc
    # anki
    # obsidian
    # poppler_utils
    # newsboat
    # Media
    ffmpeg-full
    yt-dlp
    optipng
    # Agda
    (agda.withPackages (ps:
      with ps; [
        standard-library
      ]))
    # Nix
    nil
    nixd
    nixpkgs-fmt
    # Lean
    elan
  ];
}
