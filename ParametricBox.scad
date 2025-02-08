use <ParametricBox-Gridfinity.scad>
use <ParametricBox-Shared.scad>

// Box Type
type = "gridfinity"; // [gridfinity, standard]

stackable = false;
// outer wall thickness
wall_thickness = 6;
// lid thickness (when not stackable)
top_wall_thickness = 2;
// bottom wall thickness (when not stackable)
bottom_wall_thickness = 2;

fudge = .1; // [0:.1:5]

/* [Gridfinity Parameters] */
gf_width = 5;
gf_depth = 5;
gf_height = 6;

gf_magnet_diameter = 6.1; // [0:.1:7]
gf_magnet_height = 2; // [0:.1:3]

gf_lid_top_grid = false;
gf_lid_bottom_grid = true;

/* [Standard Parameters] */
// inside width
std_width = 150;
// inside depth
std_depth = 150;
// inside height
std_height = 100;

roundness = 8;
lip_height = 5;

module __Customizer_Limit__ () {}

// if (type == "gridfinity") {
//     magnet_size = calculate_magnet(gf_magnet_diameter, gf_magnet_height);

//     translate([-(gf_width*42)-(2*wall_thickness)-20, 0, 0])
//     gridfinity_lid(gf_width, gf_depth, wall_thickness, top_wall_thickness, gf_lid_top_grid, gf_lid_bottom_grid, magnet_size, fudge);

//     gridfinity_box(gf_width, gf_depth, gf_height, wall_thickness, stackable, bottom_wall_thickness, magnet_size);
// } else {
//     translate([-std_width-20, 0, 0])
//     lid(std_width, std_depth, wall_thickness, top_wall_thickness, roundness, roundness, lip_height, fudge);
    
//     translate([0, 0, stackable ? lip_height : 0])
//     body(
//         std_width, 
//         std_depth, 
//         std_height,
//         wall_thickness,
//         bottom_wall_thickness,
//         roundness,
//         roundness,
//         lip_height
//         );

//     if (stackable) {
//         lip(std_width, std_depth, lip_height, wall_thickness, roundness, roundness, fudge);
//     }
// }




label_holder(100, 50);