{ pkgs, python, python-ld-library-path }:
pkgs.buildGoModule rec {
  pname = "python-wrapped";
  version = "0.1.0";

  src = ./.;

  ldflags = [
    "-X main.ReplitPythonLdLibraryPath=${python-ld-library-path}"
    "-X main.PythonExePath=${python}/bin/python"
  ];

  vendorHash = null;

  meta = with pkgs.lib; {
    description = ''
      A replit proxy to Python which interpolates some critical bits
      of the environment at runtime
    '';
    homepage = "https://replit.com";
    license = licenses.mit;
    mainProgram = "python";
  };

  postInstall = ''
    cd $out/bin
    mv python-wrapper .python-wrapped
    ln -s .python-wrapped python
    ln -s .python-wrapped python${pkgs.lib.versions.major python.version}
    ln -s .python-wrapped python${pkgs.lib.versions.majorMinor python.version}
  '';
}
