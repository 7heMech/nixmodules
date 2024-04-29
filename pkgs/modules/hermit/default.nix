{ pkgs, lib, ... }:
let
  version = "0.38.2";

  hermit = pkgs.buildGoModule rec {
    pname = "hermit";
    version = "0.38.2";

    src = pkgs.fetchFromGitHub {
      rev = "v${version}";
      owner = "cashapp";
      repo = "hermit";
      hash = "sha256-cBVTIpY85lrKJ1bX1mIlUW1oWEHgg8wjdUh+0FHUp80=";
    };

    vendorHash = "sha256-W8n7WA1gHx73jHF69apoKnDCIKlbWkj5f1wVITt7F+M=";

    subPackages = [ "cmd/hermit" ];

    ldflags = [
      "-X main.version=${version}"
      "-X main.channel=stable"
    ];

    meta = with lib; {
      homepage = "https://cashapp.github.io/hermit";
      description = "Hermit manages isolated, self-bootstrapping sets of tools in software projects.";
      license = licenses.asl20;
      mainProgram = "hermit";
    };
  };
in
{
  id = "hermit-${version}";
  name = "Hermit Environment Manager";
  description = "Hermit manages isolated, self-bootstrapping sets of tools in software projects.";

  replit.dev.packages = [
    hermit
  ];
}
