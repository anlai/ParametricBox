/**
    Rectangle with rounded edges (rounded on 4 edges only)
**/
module rounded_rectangle(x, y, z, roundness=5, center=true) {
    // center the rectangle
    if (center) {
        x_offset = x/2 - roundness/2;
        y_offset = y/2 - roundness/2;

        hull() {
            for (coord=[[x_offset,y_offset],[x_offset,-y_offset],[-x_offset,y_offset],[-x_offset,-y_offset]])
                translate([coord.x,coord.y,0])
                cylinder(d=roundness,h=z,$fn=360,center=center);
        }
    }
    // shape based on 0,0 for bottom left corner
    else
    {
        translate([roundness/2,roundness/2,0])
        hull() {
            for(coord=[[0,0],[x-roundness,0],[0,y-roundness],[x-roundness,y-roundness]])
                translate([coord.x,coord.y])
                cylinder(d=roundness,h=z,$fn=360,center=false);
        }
    }
}

/**
    Body of the case, with lip cutout to fit the lid

        w:
        d:
        h:
        wall_thickness:
        inner_roundness:
        outer_roundness:
        lip_height:
        fudge:
**/
module body(w, d, h, wall_thickness, inner_roundness, outer_roundness, lip_height, fudge) {

    translate([0, 0, h/2])
    difference() {
        // outer side
        rounded_rectangle()
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
    outer_w = w + wall_thickness;
    outer_d = d + wall_thickness;
    inner_w = w + (wall_thickness/2) - fudge;
    inner_d = d + (wall_thickness/2) - fudge;

    translate([0, 0, h/2])
    union() {
        difference() {
            rounded_rectangle(outer_w, outer_d, h, GF_BASEPLATE_ROUNDNESS);
            rounded_rectangle(inner_w, inner_d, h, GF_BASEPLATE_ROUNDNESS);
        }
    }
}