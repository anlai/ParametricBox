/**
    Rectangle with rounded edges (rounded on 4 edges only)
**/
module rounded_rectangle(x, y, z, roundness) {
    x_offset = x/2 - roundness/2;
    y_offset = y/2 - roundness/2;

    translate([0, 0, z/2])
    hull() {
        for (coord=[[x_offset,y_offset],[x_offset,-y_offset],[-x_offset,y_offset],[-x_offset,-y_offset]])
            translate([coord.x,coord.y,0])
            cylinder(d=roundness,h=z,$fn=360,center=true);
    }
}

/**
    Body of the case, with lip cutout to fit the lid

        w: inside width (x)
        d: inside depth (y)
        h: inside height (z)
        wall_thickness:  wall thickness
        inner_roundness: roundness of the inside corners
        outer_roundness: roundness of the outside corners
        lip_height: height of the cutout to fit the lid
        fudge: fudge factor for fitment, gets subtracted (makes it thicker)
**/
module body(w, d, h, wall_thickness, inner_roundness, outer_roundness, lip_height, fudge) {
    thickness = wall_thickness * 2; // account for 2 walls
    outer_w = w + thickness;
    outer_d = d + thickness;
    
    difference() {
        // outer side
        rounded_rectangle(outer_w, outer_d, h, outer_roundness);
        // inside cutout
        rounded_rectangle(w, d, h, inner_roundness);

        translate([0, 0, h-lip_height])
        lip(w, d, lip_height, wall_thickness, inner_roundness, outer_roundness, fudge);
    }
}

/**
    Lip shape to make cutout or lip of the lid

        w: inside width (x)
        d: inside depth (y)
        h: inside height (z)
        wall_thickness:  wall thickness
        inner_roundness: roundness of the inside corners
        outer_roundness: roundness of the outside corners
        fudge: fudge factor for fitment, gets subtracted (makes it thicker)
**/
module lip(w, d, h, wall_thickness, inner_roundness, outer_roundness, fudge) {
    thickness = wall_thickness * 2;
    outer_w = w + thickness;
    outer_d = d + thickness;
    inner_w = w + (thickness/2) - fudge;
    inner_d = d + (thickness/2) - fudge;

    union() {
        difference() {
            rounded_rectangle(outer_w, outer_d, h, outer_roundness);
            rounded_rectangle(inner_w, inner_d, h, inner_roundness);
        }
    }
}