use <ParametricBox-Shared.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate_common.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate.scad>

// Gridfinity Constants
GF_UNIT_SIZE = 41.5;
GF_UNIT_HEIGHT = 7;
GF_LIP_HEIGHT = 4.4;

GF_BASEPLATE_UNIT_SIZE = 42;
GF_BASEPLATE_HEIGHT = 5;
GF_BASEPLATE_ROUNDNESS = 8;

function calculate_magnet(d, h) = d > 0 && h > 0 ? [d, h] : [0,0];

module gridfinity_box(width, depth, height, wall_thickness, stackable, bottom_wall_thickness, fudge, magnet_size) {
    w = width * GF_BASEPLATE_UNIT_SIZE;
    d = depth * GF_BASEPLATE_UNIT_SIZE;
    h = height * GF_UNIT_HEIGHT;

    lift_height = stackable ? GF_LIP_HEIGHT : bottom_wall_thickness;
    translate([0, 0, lift_height]){
        body(w, d, h, wall_thickness, GF_BASEPLATE_ROUNDNESS, GF_BASEPLATE_ROUNDNESS, GF_LIP_HEIGHT, fudge);
        translate([-w/2, -d/2, 0])
        gridfinity_baseplate(width, depth, magnetSize=magnet_size);
    }
    
    // render the bottom
    if (stackable) {
        translate([-w/2, -d/2, 0])
        frame_cavity(width, depth);

        lip(w, d, GF_LIP_HEIGHT, wall_thickness, GF_BASEPLATE_ROUNDNESS, GF_BASEPLATE_ROUNDNESS, 0);
    } else {
        translate([0, 0, bottom_wall_thickness/2])
        rounded_rectangle(w+(2*wall_thickness), d+(2*wall_thickness), bottom_wall_thickness, GF_BASEPLATE_ROUNDNESS);
    }
}

module gridfinity_lid(width, depth, wall_thickness, top_thickness, top_grid, bottom_grid, magnet_size) {
    w = width * GF_BASEPLATE_UNIT_SIZE;
    d = depth * GF_BASEPLATE_UNIT_SIZE;

    translate([-w/2, -d/2, 0])
    frame_cavity(width, depth);

    translate([0, 0, GF_LIP_HEIGHT])
    rounded_rectangle(w+(2*wall_thickness), d+(2*wall_thickness), top_thickness, GF_BASEPLATE_ROUNDNESS);

    lip(w, d, GF_LIP_HEIGHT, wall_thickness, GF_BASEPLATE_ROUNDNESS, GF_BASEPLATE_ROUNDNESS, 0);

    if (top_grid) {
        translate([-w/2, -d/2, GF_LIP_HEIGHT+top_thickness])
        gridfinity_baseplate(width, depth, magnetSize=magnet_size);
    }
}
