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

gf_lid_top_grid = true;
gf_lid_bottom_grid = true;

/* [Standard Parameters] */
// inside width
std_width = 40;
// inside depth
std_depth = 40;
// inside height
std_height = 40;

module __Customizer_Limit__ () {}

if (type == "gridfinity") {
    // translate([-gf_width*21-10, 0, 0])
    // gridfinity_lid(gf_width, gf_depth, wall_thickness, top_wall_thickness);

    magnet_size = calculate_magnet(gf_magnet_diameter, gf_magnet_height);

    gridfinity_lid(gf_width, gf_depth, wall_thickness, top_wall_thickness, gf_lid_top_grid, gf_lid_bottom_grid, magnet_size);

    // translate([gf_width*21+10, 0, 0])
    // gridfinity_box(gf_width, gf_depth, gf_height, wall_thickness, stackable, bottom_wall_thickness, fudge, magnet_size);
}