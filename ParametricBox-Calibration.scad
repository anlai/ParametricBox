use <gridfinity-extended/modules/module_gridfinity.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate_common.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate.scad>

part = "grid"; //[]

magnet_diameter = 6.1;
magnet_height = 2;

if (part == "grid") {
    gridfinity_baseplate(1,1,magnetSize=[magnet_diameter, magnet_height]);
}