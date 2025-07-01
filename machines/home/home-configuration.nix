{ pkgs, lib, ... }:
let
  inherit (lib.hm.gvariant) mkTuple mkUnit32;