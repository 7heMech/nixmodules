{ pkgs, lib, ... }:

let
  ruby = pkgs.ruby_3_1;
  rubyPackages = pkgs.rubyPackages_3_1;
  ruby-version = lib.versions.majorMinor "${ruby.version}";
in

{
  id = "ruby-${ruby-version}";
  name = "Ruby Tools";

  replit.packages = [
    ruby
  ];

  replit.runners.bundle = {
    name = "bundle exec ruby";
    language = "ruby";

    compile = "${ruby}/bin/bundle install";
    start = "${ruby}/bin/bundle exec ruby $file";
    fileParam = true;
  };

  # TODO: enable this once we have a runner selector
  # replit.runners.ruby-script = {
  #   name = "ruby";
  #   language = "ruby";

  #   start = "${ruby}/bin/ruby $file";
  #   fileParam = true;
  # };

  replit.dev.languageServers.solargraph = {
    name = "Solargraph: A Ruby Language Server";
    language = "ruby";

    start = "${rubyPackages.solargraph}/bin/solargraph stdio";
  };

  replit.dev.packagers.ruby = {
    name = "Ruby";
    language = "ruby";
    features = {
      packageSearch = true;
      guessImports = true;
      enabledForHosting = false;
    };
  };
}
