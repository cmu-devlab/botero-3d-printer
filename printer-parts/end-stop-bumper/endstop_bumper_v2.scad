$fn=64;
difference() {
	union() {
		cylinder(r=20/2,h=3);
		cylinder(r=6/2, h=6);
		for (angle=[0:45:359.99]) {
			rotate([0,0,angle]) 
			translate([-10,-0.5,0]) 
				cube([20,1,4.5]);
		}
	}
	translate([0,0,1]) cylinder(r=3.0/2, h=6);
}