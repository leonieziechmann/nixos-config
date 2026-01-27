{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bash
  ];

  system.activationScripts.binbash = {
    deps = ["binsh"];
    text = ''
      ln -s "${lib.getExe pkgs.bash}" "/bin/bash"
    '';
  };
}
