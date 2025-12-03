{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions;
        [
          vscodevim.vim
          rust-lang.rust-analyzer
          jnoortheen.nix-ide
          dbaeumer.vscode-eslint
          tamasfe.even-better-toml
          bierner.markdown-mermaid
          pkief.material-icon-theme
          pkief.material-product-icons
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "c-cpp-runner";
            publisher = "franneck94";
            version = "9.5.0";
            sha256 = "DNoDe118tJAB2buN8/4PJ73z2xg+HQOoRaLF1pldJTM=";
          }
        ];
      userSettings = {
        "files.autoSave" = "off";
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
        "editor.fontFamily" = "Iosevka, monospace";
        "editor.wordWrap" = "on";
        "editor.fontSize" = 17;
        "editor.lineHeight" = 1.5;
        "editor.wordWrapColumn" = 60;
        "diffEditor.wordWrap" = "on";
        "liveServer.settings.donotShowInfoMsg" = true;
        "explorer.confirmDelete" = false;
        "terminal.integrated.tabs.enabled" = true;
        "window.menuBarVisibility" = "compact";
        "editor.minimap.enabled" = false;
        "editor.tabSize" = 2;
        "haskell.manageHLS" = "GHCup";
        "workbench.colorTheme" = "Gruvbox Dark Hard";
        "workbench.productIconTheme" = "material-product-icons";

        "diffEditor.ignoreTrimWhitespace" = false;
        "extensions.autoCheckUpdates" = false;
        "terminal.integrated.defaultProfile.osx" = "zsh";
        "update.mode" = "none";
        "vsicons.dontShowNewVersionMessage" = true;
        "github.copilot.enable" = {
          "*" = false;
          "markdown" = false;
          "plaintext" = false;
          "scminput" = false;
        };
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [
                "nixfmt"
              ];
            };
            "options" = {
              "home-manager" = {
                "expr" = "(builtins.getFlake \"/absolute/path/to/flake\").homeConfigurations.<name>.options";
              };
              "nixos" = {
                "expr" = "(builtins.getFlake \"/absolute/path/to/flake\").nixosConfigurations.<name>.options";
              };
            };
          };
        };
      };
    };
  };
}
