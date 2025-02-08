/**
    Rectangle with rounded edges (rounded on 4 edges only)
**/
module rounded_rectangle(x, y, z, roundness, chamfer_top_angle = 0, chamfer_top_height = 0, chamfer_bottom_angle = 0, chamfer_bottom_height = 0) {
    x_offset = x/2 - roundness/2;
    y_offset = y/2 - roundness/2;

    hull() {
        for (coord=[[x_offset,y_offset],[x_offset,-y_offset],[-x_offset,y_offset],[-x_offset,-y_offset]])
            translate([coord.x,coord.y,0])
            cylinder_chamfer(roundness, z, chamfer_top_angle, chamfer_top_height, chamfer_bottom_angle, chamfer_bottom_height, 360);
            // cylinder(d=roundness,h=z,$fn=360,center=true);
    }
}

function needs_chamfer(angle, height) = (angle > 0 && angle < 90) && (height > 0);
function chamfered_d(d,a) = (d/2 * cos(a)) * 2;

/**
    Create a cylinder with chamfered edges, centered and bottom at z=0

    Arguments:
        d: diameter of the cylinder
        h: total height of the cylinder
        chamfer_top_angle: angle of the chamfer for the top side
        chamfer_top_height: height of the chamfer for the top side
        chamfer_bottom_angle: angle of the chamfer for the bottom side
        chamfer_bottom_height: height of the chamfer for the bottom side
        fn: # of fragments to draw (default: 360)
**/
module cylinder_chamfer(d, h, chamfer_top_angle = 0, chamfer_top_height = 0, chamfer_bottom_angle = 0, chamfer_bottom_height = 0, fn=360) {
    assert(chamfer_top_height < h/2, "top chamfer cannot be more than half the total height of the cylinder");
    assert(chamfer_bottom_height < h/2, "bottom chamfer cannot be more than half the total height of the cylinder");

    has_top_chamfer = needs_chamfer(chamfer_top_angle, chamfer_top_height);
    has_bot_chamfer = needs_chamfer(chamfer_bottom_angle, chamfer_bottom_height);

    union() {

        // bottom
        if (has_bot_chamfer) {
            cylinder(d1 = chamfered_d(d, chamfer_bottom_angle), d2 = d, h = chamfer_bottom_height, $fn = fn);
        }

        // middle
        translate([0, 0, has_bot_chamfer ? chamfer_bottom_height : 0])
        cylinder(d = d, h = h - chamfer_bottom_height - chamfer_top_height, $fn = fn);

        // top
        if (has_top_chamfer) {
            translate([0, 0, h - chamfer_top_height])
            cylinder(d1 = d, d2 = chamfered_d(d, chamfer_top_angle), h = chamfer_top_height, $fn = fn);
        }

    }    
}

/**
    Body of the case, with lip cutout to fit the lid

    Arguments:
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