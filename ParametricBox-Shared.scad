/**
    Rectangle with rounded edges (rounded on 4 edges only)
**/
module rounded_rectangle(x,y,z,roundness=5,center=true) {
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