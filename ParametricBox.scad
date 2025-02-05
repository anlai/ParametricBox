use <ParametricBox-Gridfinity.scad>

// Box Type
type = "gridfinity"; // [gridfinity, standard]

stackable = false;
// outer wall thickness
wall_thickness = 2;
// lid thickness (when not stackable)
top_wall_thickness = 2;
// bottom wall thickness (when not stackable)
bottom_wall_thickness = 2;

/* [Gridfinity Parameters] */
gf_width = 5;
gf_depth = 5;
gf_height = 6;

/* [Standard Parameters] */
std_width = 40;
std_depth = 40;
std_height = 40;

module __Customizer_Limit__ () {}

if (type == "gridfinity") {
    translate([-gf_width*21-10, 0, 0])
    gridfinity_lid(gf_width, gf_depth, wall_thickness, top_wall_thickness);

    translate([gf_width*21+10, 0, 0])
    gridfinity_box(gf_width, gf_depth, gf_height, wall_thickness, stackable, bottom_wall_thickness);
}