include <ParametricBox-Constants.scad>
use <ParametricBox-Shared.scad>
use <gridfinity-extended/modules/module_gridfinity.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate_common.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate.scad>

function calculate_magnet(d, h) = d > 0 && h > 0 ? [d, h] : [0,0];

module gridfinity_box(width, depth, height, wall_thickness, stackable, bottom_wall_thickness, magnet_size) {
    w = width * GF_BASEPLATE_UNIT_SIZE;
    d = depth * GF_BASEPLATE_UNIT_SIZE;
    h = (height * GF_UNIT_HEIGHT) + (magnet_size.y > 0 ? magnet_size.y : 0);

    translate([0, 0, stackable ? GF_LIP_HEIGHT : 0])
    union() {
        body(w, d, h, wall_thickness, bottom_wall_thickness, GF_BASEPLATE_ROUNDNESS, GF_BASEPLATE_ROUNDNESS, GF_LIP_HEIGHT);

        translate([-w/2, -d/2, bottom_wall_thickness])
        gridfinity_baseplate(width, depth, magnetSize=magnet_size);
    }

    // scale_factor = .95;
    // scaled_offset_x = -(w * scale_factor)/2;
    // scaled_offset_y = -(d * scale_factor)/2;

    if (stackable) {

        gridfinity_cavities(width, depth, .98);

        // translate([scaled_offset_x, scaled_offset_y, 0])
        // gridcopy(width, depth, positionGridx = "center", positionGridy = "center") {
        //     scale([scale_factor, scale_factor, 1])
        //     frame_cavity(1, 1);
        // }

        // translate([-w/2, -d/2, 0])
        // gridcopy(width, depth, positionGridx="center", positionGridy="center") {
        //     scale([.98,.98,1])
        //     frame_cavity(1,1);
        // }

        // frame_cavity(width, depth);
        lip(w, d, GF_LIP_HEIGHT, wall_thickness, GF_BASEPLATE_ROUNDNESS, GF_BASEPLATE_ROUNDNESS, 0);
    }
}

module gridfinity_lid(width, depth, wall_thickness, top_thickness, top_grid, bottom_grid, magnet_size, fudge) {
    w = width * GF_BASEPLATE_UNIT_SIZE;
    d = depth * GF_BASEPLATE_UNIT_SIZE;

    lid(w, d, wall_thickness, top_thickness, GF_BASEPLATE_ROUNDNESS, GF_BASEPLATE_ROUNDNESS, GF_LIP_HEIGHT, fudge);

    gridfinity_cavities(width, depth, .98);

    // translate([-w/2, -d/2, 0])
    // frame_cavity(width, depth);

    if (top_grid) {
        translate([-w/2, -d/2, GF_LIP_HEIGHT+top_thickness])
        gridfinity_baseplate(width, depth, magnetSize=magnet_size);
    }
}

module gridfinity_cavities(width, depth, scale_factor) {
    x_offset = (width % 2 == 0 ? GF_BASEPLATE_UNIT_SIZE/2 : 0) - ( floor(width/2) * GF_BASEPLATE_UNIT_SIZE );
    y_offset = (depth % 2 == 0 ? GF_BASEPLATE_UNIT_SIZE/2 : 0) - ( floor(depth/2) * GF_BASEPLATE_UNIT_SIZE );

    for (r = [0:width-1]) {        
        for (c = [0:depth-1]) {
            translate([x_offset,y_offset,0]) 
            translate([c*GF_BASEPLATE_UNIT_SIZE, r*GF_BASEPLATE_UNIT_SIZE, 0])
            scale([scale_factor, scale_factor, 1])
            translate([-GF_BASEPLATE_UNIT_SIZE/2, -GF_BASEPLATE_UNIT_SIZE/2, 0])
            frame_cavity(1, 1);  
        }
    }
}