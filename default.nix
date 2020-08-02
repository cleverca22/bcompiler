let
  lib = import <nixpkgs/lib>;
in lib.fix (self: {
  #busybox = (import <nixpkgs/pkgs/stdenv/linux/bootstrap-files/x86_64.nix>).busybox;
  busybox = (import <nixpkgs> {}).busybox;
  mkDerivation = args: builtins.derivation ({
    inherit (self) busybox;
    system = builtins.currentSystem;
    builder = "${self.busybox}/bin/busybox";
    args = [ "ash" ./builder.sh ];
  } // args);
  hex1 = self.mkDerivation {
    name = "hex1";
    buildCommand = ''
      $builder mkdir -pv $out/bin
      $builder cp ${./hex1} $out/bin/hex1
    '';
  };
  hex2a = self.mkDerivation {
    name = "hex2a";
    buildInputs = [ self.hex1 ];
    buildCommand = ''
      mkdir -pv $out/bin/
      hex1 < ${./hex2a.he} > $out/bin/hex2
      chmod +x $out/bin/hex2
    '';
  };
  hex2b = self.mkDerivation {
    name = "hex2b";
    buildInputs = [ self.hex2a ];
    buildCommand = ''
      mkdir -p $out/bin
      hex2 < ${./hex2b.he} > $out/bin/hex2
      chmod +x $out/bin/hex2
    '';
  };
  hex2c = self.mkDerivation {
    name = "hex2c";
    buildInputs = [ self.hex2b ];
    buildCommand = ''
      mkdir -p $out/bin
      hex2 < ${./hex2c.he} > $out/bin/hex2
      chmod +x $out/bin/hex2
    '';
  };
  hex3a = self.mkDerivation {
    name = "hex3a";
    buildInputs = [ self.hex2c ];
    buildCommand = ''
      mkdir -p $out/bin
      hex2 < ${./hex3a.he} > $out/bin/hex3
      chmod +x $out/bin/hex3
    '';
  };
  hex3b = self.mkDerivation {
    name = "hex3b";
    buildInputs = [ self.hex3a ];
    buildCommand = ''
      mkdir -p $out/bin
      hex3 < ${./hex3b.he} > $out/bin/hex3
      chmod +x $out/bin/hex3
    '';
  };
  hex4a = self.mkDerivation {
    name = "hex4a";
    buildInputs = [ self.hex3b ];
    buildCommand = ''
      mkdir -p $out/bin
      hex3 < ${./hex4a.he} > $out/bin/hex4
      chmod +x $out/bin/hex4
    '';
  };
  hex4b = self.mkDerivation {
    name = "hex4b";
    buildInputs = [ self.hex4a ];
    buildCommand = ''
      mkdir -p $out/bin
      hex4 < ${./hex4b.he} > $out/bin/hex4
      chmod +x $out/bin/hex4
    '';
  };
  hex5a = self.mkDerivation {
    name = "hex5a";
    buildInputs = [ self.hex4b ];
    buildCommand = ''
      mkdir -p $out/bin
      hex4 < ${./hex5a.he} > $out/bin/hex5
      chmod +x $out/bin/hex5
    '';
  };
  hex5b = self.mkDerivation {
    name = "hex5b";
    buildInputs = [ self.hex5a ];
    buildCommand = ''
      mkdir -p $out/bin
      hex5 < ${./hex5b.he} > $out/bin/hex5
      chmod +x $out/bin/hex5
    '';
  };
  hex5c = self.mkDerivation {
    name = "hex5c";
    buildInputs = [ self.hex5b ];
    buildCommand = ''
      mkdir -p $out/bin
      hex5 < ${./hex5c.he} > $out/bin/hex5
      chmod +x $out/bin/hex5
    '';
  };
  bcc = self.mkDerivation {
    name = "bcc";
    buildInputs = [ self.hex5c ];
    buildCommand = ''
      mkdir -p $out/bin
      cat ${./header.bc} ${./bcc.bc} | hex5 > $out/bin/bcc
      chmod +x $out/bin/bcc
    '';
  };
})
