{ pkgs, ... }:

{
services.printing.enable = true;
services.printing.drivers = [ pkgs.splix pkgs.brscan4 ];
hardware.sane.enable = true;

}
