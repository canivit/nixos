{ nixpkgs, pkgs, config, ...}:
let
  marketExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-icons";
      publisher = "vscode-icons-team";
      version = "11.12.0";
      sha256 = "sha256-jyc6m6lfwSYt5xg2H5TGdxheKptho87C7eN4xuU5IYg=";
    }

    {
      name = "cake-vscode";
      publisher = "cake-build";
      version = "2.0.0";
      sha256 = "sha256-aBgTPB4bSKMjq4WmbZH+a96ljWUh6MpsNpKYtCNTzNM=";
    }

    {
      name = "dotnet-interactive-vscode";
      publisher = "ms-dotnettools";
      version = "1.0.3452021";
      sha256 = "sha256-3AU0q6eKPC6/YURtlBCXa3BUU3HqpKI1n7VOOjHF/o4=";
    }
  ];
in
  {
    home-manager.users.can.programs.vscode = {
      enable = true;
    #package = pkgs.vscode-fhsWithPackages (ps: with ps; [ dotnet-sdk ]);
    package = pkgs.unstable.vscode;

    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      mskelton.one-dark-theme
      esbenp.prettier-vscode
      ms-python.python
      bbenoist.nix
      arrterian.nix-env-selector
      github.copilot
      pkgs.unstable.vscode-extensions.ms-dotnettools.csharp
      pkgs.unstable.vscode-extensions.ms-vscode.cpptools
    ] ++ marketExtensions;

    keybindings = [
      {
        key = "ctrl+=";
        command = "editor.action.fontZoomIn";
      }

      {
        key = "ctrl+-";
        command = "editor.action.fontZoomOut";
      }

      {
        key = "ctrl+0";
        command = "editor.action.fontZoomReset";
      }

      {
        key = "ctrl+shift+v";
        command = "toggleVim";
      }
    ];

    userSettings = {
      #"window.titleBarStyle" = "native";
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "One Dark";
      "workbench.iconTheme" = "vscode-icons";
      "editor.minimap.enabled" = true;
      "editor.fontFamily" = "JetBrains Mono";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 15;
      "editor.tabSize" = 2;
      "editor.mouseWheelZoom" = true;
      "terminal.integrated.fontFamily" = "Fira Code";
      "terminal.integrated.fontSize" = 15;
      "terminal.external.linuxExec" = "alacritty";
      "terminal.integrated.scrollback" = 1000;
      "terminal.integrated.defaultProfile.linux" = "fish";
      "debug.console.fontSize" = 15;

      "vim.useSystemClipboard" = true;

      "workbench.startupEditor" = "none";

      "[html]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      "[css]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      #"[csharp]" = {
      #  "editor.defaultFormatter" = "ms-dotnettools.csharp";
      #};
    };
  };
}
