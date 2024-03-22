{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    asdf-vm
    clang
  ];
  home-manager.users.can.home.file.".config/fish/completions/asdf.fish".source = "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.fish";
}
