use <gridfinity-extended/modules/module_gridfinity.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate_common.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate.scad>

part = "gf_grid_magnet"; //[gf_grid_magnet]

/* [gridfinity grid maagnet] */

magnet_diameter = 6.1;
magnet_height = 2;

module __Customizer_Limit__ () {}

if (part == "gf_grid_magnet") {

    difference() {
        union() {
            gridfinity_baseplate(1,1,magnetSize=[magnet_diameter, magnet_height]);
            
            translate([5,0,0]) {
                translate([0,-5,0])
                cube([30,5,.2]);
                color("red")
                translate([1,-4,0])
                linear_extrude(.4)
                text(text=str("d=",magnet_diameter," h=",magnet_height),size=4);
            }
        }

        translate([0,12,0])
        cube([42,42,42]);
    }
}