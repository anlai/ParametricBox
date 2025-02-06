use <ParametricBox-Shared.scad>

// Gridfinity Constants
GF_UNIT_SIZE = 41.5;
GF_UNIT_HEIGHT = 7;
GF_LIP_HEIGHT = 4.4;

GF_BASEPLATE_UNIT_SIZE = 42;
GF_BASEPLATE_HEIGHT = 5;
GF_BASEPLATE_ROUNDNESS = 8;

module gridfinity_box(width, depth, height, wall_thickness, stackable, bottom_wall_thickness, fudge) {
    w = width * GF_BASEPLATE_UNIT_SIZE;
    d = depth * GF_BASEPLATE_UNIT_SIZE;
    h = (height * GF_UNIT_HEIGHT) + GF_LIP_HEIGHT;

    lift_height = bottom_wall_thickness;
    if (stackable) {
        // generate lid
        // set lift_height the height of the lid
        lift_height = GF_BASEPLATE_HEIGHT;
    } else {
        translate([0,0,bottom_wall_thickness/2])
        rounded_rectangle(w+wall_thickness, d+wall_thickness, bottom_wall_thickness, GF_BASEPLATE_ROUNDNESS);
    }

    translate([0, 0, lift_height])
    gridfinity_outer_wall(w, d, h, wall_thickness, fudge);
}

module gridfinity_lid(width, depth, wall_thickness, top_wall_thickness) {
    w = width * GF_BASEPLATE_UNIT_SIZE;
    d = depth * GF_BASEPLATE_UNIT_SIZE;

    // non-stackable lid
    translate([0, 0, top_wall_thickness/2])
    rounded_rectangle(w+wall_thickness, d+wall_thickness, top_wall_thickness);
    translate([0, 0, (wall_thickness/2)+top_wall_thickness])
    gridfinity_lip(w, d, wall_thickness);
}

module gridfinity_outer_wall(w, d, h, wall_thickness, fudge) {
    translate([0,0,h/2]) // move so it sits at 0
    difference() {
        // outer wall
        rounded_rectangle(w+wall_thickness, d+wall_thickness, h, GF_BASEPLATE_ROUNDNESS);
        // inner cavity
        rounded_rectangle(w, d, h, GF_BASEPLATE_ROUNDNESS);

        translate([0,0,h/2-(GF_LIP_HEIGHT/2)])
        gridfinity_lip(w, d, wall_thickness, fudge);
    }
}

module gridfinity_lip(w, d, wall_thickness, fudge) {
    lip(w, d, GF_LIP_HEIGHT, GF_BASEPLATE_ROUNDNESS, fudge);
}