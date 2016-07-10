m8_shaft_diameter = 9;
m8_nut_diameter = 15.7;
m8_pocket_depth = 7;
nut_holder_len = 30;
nut_holder_wall = 3;
nut_bottom_wall = 3;
nut_holder_outer_diam = m8_nut_diameter+2*nut_holder_wall;
nut_holder_flat_diam = nut_holder_outer_diam/(2*sqrt(1+(1/3)));

module leadscrew_nut_holder() {
	// rotate so hexagon is along positive y axis
	rotate([-90,0,0]){
		difference() {
			union() {
				// main hut holder profile
				difference() {
					// outer hexagon
					cylinder(r=nut_holder_outer_diam/2, h=nut_holder_len, $fn=6);
					// cut out inner hexagon at size of expected nut
					translate([0,0,-1])
						cylinder(r=m8_nut_diameter/2, h=nut_holder_len+2, $fn=6);
				}
				// wall below top nut
				translate([0,0,m8_pocket_depth])
					cylinder(r=nut_holder_outer_diam/2, h=nut_bottom_wall, $fn=6); 
			}
			// cut out shaft hole
			cylinder(r=m8_shaft_diameter/2, h=nut_holder_len, $fn=32);
		}
	}
}

module leadscrew_nut_holder_profile() {
	// rotate so hexagon is along positive y axis
	rotate([-90,0,0])
		// outer hexagon only
		translate([0,0,-1])
			cylinder(r=nut_holder_outer_diam/2, h=nut_holder_len+2, $fn=6);
}

m5_shaft_diam = 6;
m5_head_diam = 9;
m5_head_inset = 3;

dist_to_wheel = 10;
half_wheel = 11/2;
wheel_spacer = 25.4/4 /* 1/4" */;
x_axis_plate_thick = 6;

dist_to_shaft = dist_to_wheel+half_wheel+wheel_spacer+x_axis_plate_thick;
block_margin = 2;
mounting_spread_w = 30;
mounting_spread_h = 20;
block_base_w = mounting_spread_w+m5_head_diam+2*block_margin;
block_base_h = mounting_spread_h+m5_head_diam+2*block_margin;
block_base_thick = 10;

module leadscrew_block() { 
	difference() {
		union() {
			// nut holder
			leadscrew_nut_holder();
			// center support block under nut holder
			difference() {
				translate([-nut_holder_outer_diam/2,0,-dist_to_shaft])
					cube([nut_holder_outer_diam,nut_holder_len,dist_to_shaft]);
				leadscrew_nut_holder_profile();
			}
			// mounting block base
			translate([-block_base_w/2,
										-(block_base_h-nut_holder_len)/2,-dist_to_shaft]) 
				cube([block_base_w,block_base_h,block_base_thick]);
		}
		// mounting holes
		translate([-block_base_w/2,
										-(block_base_h-nut_holder_len)/2,-dist_to_shaft]) 
		translate([m5_head_diam/2+block_margin, m5_head_diam/2+block_margin, -1]) 
		union() {
			for (xoff=[0,mounting_spread_w]) {
				for (yoff=[0,mounting_spread_h/2,mounting_spread_h]) {
					translate([xoff,yoff,0]) {
					// bolt hole
					cylinder(r=m5_shaft_diam/2, h=block_base_thick+2,$fn=32);
					// countersink for head
					translate([0,0,block_base_thick-m5_head_inset])
						cylinder(r=m5_head_diam/2, h=500,$fn=32);
					}
				}
			}
		}
	}
}

leadscrew_block();
