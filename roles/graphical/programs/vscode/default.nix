{ nixpkgs, pkgs, config, ... }:
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

    {
      name = "Ruby";
      publisher = "rebornix";
      version = "0.28.1";
      sha256 = "sha256-HAUdv+2T+neJ5aCGiQ37pCO6x6r57HIUnLm4apg9L50=";
    }

    {
      name = "vscode-ruby";
      publisher = "wingrunr21";
      version = "0.28.0";
      sha256 = "sha256-H3f1+c31x+lgCzhgTb0uLg9Bdn3pZyJGPPwfpCYrS70=";
    }
  ];

  settings = builtins.fromJSON (builtins.readFile ./settings.json);
in
{
  home-manager.users.can.programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;

    extensions = with pkgs.unstable.vscode-extensions; [
      vscodevim.vim
      mskelton.one-dark-theme
      esbenp.prettier-vscode
      ms-python.python
      bbenoist.nix
      arrterian.nix-env-selector
      github.copilot
      #pkgs.unstable.vscode-extensions.ms-dotnettools.csharp
      #pkgs.unstable.vscode-extensions.ms-vscode.cpptools
      matklad.rust-analyzer
      ocamllabs.ocaml-platform
      elixir-lsp.vscode-elixir-ls
      mkhl.direnv
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

    userSettings = settings;
  };
}
