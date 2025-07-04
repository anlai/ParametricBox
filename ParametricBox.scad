include <ParametricBox-Constants.scad>
use <ParametricBox-Gridfinity.scad>
use <ParametricBox-Shared.scad>

// Box Type
type = "gridfinity"; // [gridfinity, standard]

// Component
component = "box"; // [box, lid, label]

// stackable boxes
stackable = false;

// outer wall thickness
wall_thickness = 4;
// lid thickness (when not stackable)
lid_thickness = 2;
// bottom wall thickness (when not stackable)
bottom_wall_thickness = 2.4;

fudge = .3; // [0:.1:1]

/* [Gridfinity Parameters] */
gf_width = 5;
gf_depth = 5;
gf_height = 6;
// additional height in mm to add
gf_extra_height = 2; 

gf_magnet_d = 6.1; // [0:.1:7]
gf_magnet_height = 2; // [0:.1:3]
gf_embed_magnets = false;

gf_lid_top_grid = false;
gf_lid_bottom_grid = true;

gf_stacking_lip = true;

/* [Standard Parameters] */
// inside width
std_width = 150;
// inside depth
std_depth = 150;
// inside height
std_height = 100;

// roundness of the box
roundness = 8;
// lid and stacking lip height
lip_height = 5;

/* [Label] */
// width of label
label_width = 70;
// height of label
label_height = 26;

module __Customizer_Limit__ () {}

if (type == "gridfinity") {
    magnet_size = calculate_magnet(gf_magnet_d, gf_magnet_height);

    // translate([-(gf_width*42)-(2*wall_thickness)-20, 0, 0])

    if (component == "lid") {
        gridfinity_lid(
            gf_width, 
            gf_depth,
            wall_thickness,
            lid_thickness, 
            gf_lid_top_grid, 
            gf_lid_bottom_grid, 
            magnet_size, 
            fudge
            );
    }

    if (component == "box") {
        gridfinity_box(
            gf_width, 
            gf_depth, 
            gf_height, 
            gf_extra_height,
            wall_thickness, 
            stackable, 
            gf_stacking_lip,
            bottom_wall_thickness, 
            magnet_size,
            gf_embed_magnets,
            fudge
            );
    }

} else {
    // translate([-std_width-20, 0, 0])
    if (component == "lid") {
        lid(
            std_width, 
            std_depth, 
            wall_thickness, 
            lid_thickness, 
            roundness, 
            roundness, 
            lip_height, 
            fudge
            );
    }
    
    if (component == "box") {
        translate([0, 0, stackable ? lip_height : 0])
        body(
            std_width, 
            std_depth, 
            std_height,
            wall_thickness,
            bottom_wall_thickness,
            roundness,
            roundness,
            lip_height
            );

        if (stackable) {
            lip(std_width, std_depth, lip_height, wall_thickness, roundness, roundness, fudge);
        }
    }
}

function label_y_offset(depth, wall_thickness) = -((depth/2)+wall_thickness);
function label_z_offset(height, bottom_wall_thickness, label_height, stackable, lip_height) = (((height+bottom_wall_thickness)-label_height)/2)-(stackable ? 0 : lip_height);

if (component == "box" && label_width > 0 && label_height > 0) {
    label_y_offset = label_y_offset(
        type == "gridfinity" ? gf_depth*GF_BASEPLATE_UNIT_SIZE : std_depth,
        wall_thickness
    );
    label_z_offset = label_z_offset(
        type == "gridfinity" ? gf_height*GF_UNIT_HEIGHT : std_height, //(gf_height*GF_UNIT_HEIGHT) + (stackable ? GF_LIP_HEIGHT : 0) : std_height + (stackable ? lip_height : 0),
        bottom_wall_thickness,
        label_height,
        stackable,
        type == "gridfinity" ? GF_LIP_HEIGHT : lip_height
    );

    translate([0, label_y_offset, label_z_offset])
    label_holder(label_width, label_height, fudge);
}

if (component == "label") {
    cube([label_width, label_height, .8]);
}