{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    difftastic.enable = true;

    userName = "let-rec";
    userEmail = "toxtayevhamidulloh6997@gmail.com";

    signing = {
      signByDefault = true;
      key = "06F6FCE379C490BAC47F4ACEE9180B76B6DB2E66";
    };

    extraConfig = {
      init.defaultBranch = "main";
      http.sslVerify = false;
      pull.rebase = false;
    };
  };
}
