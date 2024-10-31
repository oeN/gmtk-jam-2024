{ pkgs, lib, config, inputs, ... }:

{

  # https://devenv.sh/packages/
  packages = [ pkgs.stylua ];

  # https://devenv.sh/languages/
  languages.lua.enable = true;

}
