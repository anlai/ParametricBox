include <ParametricBox-Constants.scad>
use <ParametricBox-Shared.scad>
use <gridfinity-extended/modules/module_gridfinity.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate_common.scad>
use <gridfinity-extended/modules/module_gridfinity_baseplate.scad>

function calculate_magnet(d, h) = d > 0 && h > 0 ? [d, h] : [0,0];

module gridfinity_box(width, depth, height, extra_height, wall_thickness, stackable, stacking_lip, bottom_wall_thickness, magnet_size, embed_magnets, fudge) {
    w = width * GF_BASEPLATE_UNIT_SIZE;
    d = depth * GF_BASEPLATE_UNIT_SIZE;
    h = (height * GF_UNIT_HEIGHT) + (!embed_magnets && magnet_size.y > 0 ? magnet_size.y : 0) + 3.5; // gf height + lift from magents + stacking lip (3.5 seems to be the norm vs the 4.4 in the spec)

    if (embed_magnets && magnet_size.y > 0) {
        assert(magnet_size.y < bottom_wall_thickness, "bottom wall thickness has to be thicker than magnet thickness");
    }

    translate([0, 0, stackable ? GF_LIP_HEIGHT : 0])
    difference() {
        union() {
            body(w, d, h+extra_height, wall_thickness, bottom_wall_thickness, GF_BASEPLATE_ROUNDNESS, GF_BASEPLATE_ROUNDNESS, GF_LIP_HEIGHT);

            translate([-w/2, -d/2, bottom_wall_thickness])
            gridfinity_baseplate(width, depth, magnetSize=embed_magnets ? [0,0] : magnet_size);
        }

        if (embed_magnets && magnet_size.x > 0) {
            translate([0, 0, bottom_wall_thickness - magnet_size.y])
            gridfinity_magnets(width, depth, magnet_size.x, magnet_size.y);
        }
    }

    if (stackable) {
        gridfinity_cavities(width, depth, .98);

        if (stacking_lip) {
            lip(w, d, GF_LIP_HEIGHT, wall_thickness, GF_BASEPLATE_ROUNDNESS, GF_BASEPLATE_ROUNDNESS, fudge);
        }
    }
}

module gridfinity_lid(width, depth, wall_thickness, top_thickness, top_grid, bottom_grid, magnet_size, fudge) {
    w = width * GF_BASEPLATE_UNIT_SIZE;
    d = depth * GF_BASEPLATE_UNIT_SIZE;

    lid(w, d, wall_thickness, top_thickness, GF_BASEPLATE_ROUNDNESS, GF_BASEPLATE_ROUNDNESS, GF_LIP_HEIGHT, fudge);

    if (bottom_grid) {
        gridfinity_cavities(width, depth, .98);
    }

    if (top_grid) {
        translate([-w/2, -d/2, GF_LIP_HEIGHT+top_thickness])
        gridfinity_baseplate(width, depth, magnetSize=magnet_size);
    }
}

module gridfinity_cavities(width, depth, scale_factor) {
    x_offset = (width % 2 == 0 ? GF_BASEPLATE_UNIT_SIZE/2 : 0) - ( floor(width/2) * GF_BASEPLATE_UNIT_SIZE );
    y_offset = (depth % 2 == 0 ? GF_BASEPLATE_UNIT_SIZE/2 : 0) - ( floor(depth/2) * GF_BASEPLATE_UNIT_SIZE );

    for (r = [0:depth-1]) {        
        for (c = [0:width-1]) {
            translate([x_offset,y_offset,0]) 
            translate([c*GF_BASEPLATE_UNIT_SIZE, r*GF_BASEPLATE_UNIT_SIZE, 0])
            scale([scale_factor, scale_factor, 1])
            translate([-GF_BASEPLATE_UNIT_SIZE/2, -GF_BASEPLATE_UNIT_SIZE/2, 0])
            frame_cavity(1, 1);  
        }
    }
}

module gridfinity_magnets(width, depth, magnet_diameter, magnet_thickness) {
    x_offset = (width % 2 == 0 ? GF_BASEPLATE_UNIT_SIZE/2 : 0) - ( floor(width/2) * GF_BASEPLATE_UNIT_SIZE );
    y_offset = (depth % 2 == 0 ? GF_BASEPLATE_UNIT_SIZE/2 : 0) - ( floor(depth/2) * GF_BASEPLATE_UNIT_SIZE );

    for (r = [0:depth-1]) {        
        for (c = [0:width-1]) {
            translate([x_offset,y_offset,0]) 
            translate([c*GF_BASEPLATE_UNIT_SIZE, r*GF_BASEPLATE_UNIT_SIZE, 0])
            gridfinity_unit_magnets(magnet_diameter, magnet_thickness);
        }
    }
}

module gridfinity_unit_magnets(magnet_diameter, magnet_thickness) {
    // x/y offset of magnets from the center
    offset = 13;

    for(coord = [[offset,offset],[offset,-offset],[-offset,offset],[-offset,-offset]])
    {
        color("red")
        translate([coord.x,coord.y,0])
        cylinder(d=magnet_diameter, h=magnet_thickness, $fn=360);
    }
}
