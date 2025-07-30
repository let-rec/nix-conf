{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        rust-lang.rust-analyzer
        jnoortheen.nix-ide
        dbaeumer.vscode-eslint
        tamasfe.even-better-toml
        bierner.markdown-mermaid
        pkief.material-icon-theme
        pkief.material-product-icons
      ];
      userSettings = {
        "github.copilot.enable" = {
          "*" = false;
          "plaintext" = false;
          "markdown" = false;
          "scminput" = false;
        };
        "terminal.integrated.defaultProfile.osx" = "zsh";
        "workbench.iconTheme" = "vscode-icons";
        "diffEditor.ignoreTrimWhitespace" = false;
        "vsicons.dontShowNewVersionMessage" = true;
        "liveServer.settings.donotShowInfoMsg" = true;
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
              "nixos" = {
                "expr" = "(builtins.getFlake \"/absolute/path/to/flake\").nixosConfigurations.<name>.options";
              };
              "home-manager" = {
                "expr" = "(builtins.getFlake \"/absolute/path/to/flake\").homeConfigurations.<name>.options";
              };
              "nix-darwin" = {
                "expr" = "(builtins.getFlake \"$\{workspaceFolder}/path/to/flake\").darwinConfigurations.<name>.options";
              };
            };
          };
        };
      };
    };
  };
}
