{ pkgs, python, pypkgs }:
pkgs.callPackage ./poetry-in-venv.nix {
  version = "1.5.4";
  url = https://storage.googleapis.com/poetry-bundles/poetry-1.5.5-python-3.10.14-bundle.tgz;
  sha256 = "sha256:0sfkj927jxc5qbi3lqnyya9l7hswy7w8ihk5acxivmj3gpxz547i";
  inherit python pypkgs;
}
