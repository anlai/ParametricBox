use <gridfinity-extended/modules/module_gridfinity.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate_common.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate.scad>

use <ParametricBox-Shared.scad>

part = "gf_grid_magnet"; //[gf_grid_magnet, stacking_tolerance]

/* [gridfinity grid maagnet] */

gfg_magnet_diameter = 6.1;
gfg_magnet_height = 2;

/* [stacking tolerance] */

st_fudge = .3;

module __Customizer_Limit__ () {}

if (part == "gf_grid_magnet") {
    difference() {
        union() {
            gridfinity_baseplate(1,1,magnetSize=[gfg_magnet_diameter, gfg_magnet_height]);
            
            translate([5,0,0]) {
                translate([0,-5,0])
                cube([30,5,.2]);
                color("red")
                translate([1,-4,0])
                linear_extrude(.4)
                text(text=str("d=",gfg_magnet_diameter," h=",gfg_magnet_height),size=4);
            }
        }

        translate([0,12,0])
        cube([42,42,42]);
    }
}

if (part == "stacking_tolerance") {

    side = 42;
    height = 10;
    wall_thickness = 4;
    top_bottom_thickness = 1;
    roundness = 8;
    lip = 4.4;

    body(side, side, height, wall_thickness, top_bottom_thickness, roundness, roundness, lip);

    translate([side+wall_thickness+10,0,0])
    lid(side, side, wall_thickness, top_bottom_thickness, roundness, roundness, lip, st_fudge);

}