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

module gridfinity_box(width, depth, height, wall_thickness, stackable, bottom_wall_thickness, magnet_size) {
    w = width * GF_BASEPLATE_UNIT_SIZE;
    d = depth * GF_BASEPLATE_UNIT_SIZE;
    h = height * GF_UNIT_HEIGHT;

    translate([0, 0, stackable ? GF_LIP_HEIGHT : 0])
    union() {
        difference() {
            // shell + bottom
            union() {
                // inner shell + lip
                rounded_rectangle(w+wall_thickness, d+wall_thickness, h+bottom_wall_thickness, GF_BASEPLATE_ROUNDNESS);
                // outer shell
                rounded_rectangle(
                    w+(2*wall_thickness),
                    d+(2*wall_thickness),
                    h+bottom_wall_thickness-GF_LIP_HEIGHT,
                    GF_BASEPLATE_ROUNDNESS,
                    chamfer_top_angle=75,
                    chamfer_top_height=2
                    );
            }

            // cutout for the inside cavity
            translate([0, 0, bottom_wall_thickness])
            rounded_rectangle(w, d, h, GF_BASEPLATE_ROUNDNESS);        
        }
        
        translate([-w/2, -d/2, bottom_wall_thickness+2])
        gridfinity_baseplate(width, depth, magnetSize=magnet_size);
    }

    if (stackable) {
        translate([-w/2, -d/2, 0])
        frame_cavity(width, depth);
        lip(w, d, GF_LIP_HEIGHT, wall_thickness, GF_BASEPLATE_ROUNDNESS, GF_BASEPLATE_ROUNDNESS, 0);
    }
}

module gridfinity_lid(width, depth, wall_thickness, top_thickness, top_grid, bottom_grid, magnet_size) {
    w = width * GF_BASEPLATE_UNIT_SIZE;
    d = depth * GF_BASEPLATE_UNIT_SIZE;

    difference() {
        rounded_rectangle(
            w+(2*wall_thickness), 
            d+(2*wall_thickness), 
            GF_LIP_HEIGHT+top_thickness,
            GF_BASEPLATE_ROUNDNESS,
            chamfer_top_angle=45,
            chamfer_top_height=2
            );

        rounded_rectangle(w+wall_thickness, d+wall_thickness, GF_LIP_HEIGHT, GF_BASEPLATE_ROUNDNESS);
    }

    translate([-w/2, -d/2, 0])
    frame_cavity(width, depth);

    if (top_grid) {
        translate([-w/2, -d/2, GF_LIP_HEIGHT+top_thickness])
        gridfinity_baseplate(width, depth, magnetSize=magnet_size);
    }
}
