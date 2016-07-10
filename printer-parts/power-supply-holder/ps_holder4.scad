ps_slip = 1;
ps_h = 86+ps_slip;
ps_w = 150+ps_slip;
ps_len = 140+ps_slip;
hole_bl = [6,16];
hole_br = [ps_w-30, 6];
hole_tl = [6, ps_h-6];
hole_tr = [ps_w-6, ps_h-6];
hole_diam = 4;
hole_pad = 12;
wall = 3;
beam = 6;
hanger_len = 20; // single wide
hanger_w = 20*2; // two tall
hanger_thick = beam+wall;
hanger_hole_diam = 5.5;
hanger_hole_offset = 10;
hanger_hole_spacing = 20;
strap_w = 30;
strap_margin = 2;
strap_holder_sz = 6;
strap_slot = 3;


module top_mount() {
	difference() {
		translate([-wall,-wall,-wall]) 
		union() {
			// block for bar across
			cube([beam+wall, wall+ps_len/2+hanger_len/2+strap_w, beam+wall]);
			// beam going around corner and up to left hole
			cube([beam+wall+hole_pad/2, beam+wall, hole_bl[1]+hole_pad/2+wall]);
			// right strap holder
			translate([-strap_holder_sz,wall+ps_len/2+hanger_len/2,0])
				difference() {
					cube([strap_holder_sz,strap_w,beam+wall]);
					translate([strap_holder_sz/2-strap_slot/2+wall/2,strap_margin,0])
						cube([strap_slot,strap_w-2*strap_margin,beam+wall]);
				}
			// left strap holder
			translate([-strap_holder_sz,wall+ps_len/2-hanger_len/2-strap_w,0])
				difference() {
					cube([strap_holder_sz,strap_w,beam+wall]);
					translate([strap_holder_sz/2-strap_slot/2+wall/2,strap_margin,0])
						cube([strap_slot,strap_w-2*strap_margin,beam+wall]);
				}
			// hanger
			translate([-(hanger_w), ps_len/2-hanger_len/2+wall, 0]) 
				difference() {
					cube([hanger_w,hanger_len,hanger_thick]);
					for (row = [0:1]) 
						for (col = [0:1])
							translate([
									hanger_hole_offset+row*hanger_hole_spacing, 
									hanger_hole_offset+col*hanger_hole_spacing,0]) 
								cylinder(r=hanger_hole_diam/2, h=hanger_thick);
				}
		}
		// cut out for body of PS
		translate([-ps_slip/2,-ps_slip/2,0]) cube([ps_w,ps_len,ps_h]);
		// cut through so bottom of base is open instead of solid
		translate([beam,beam,-wall]) cube([ps_w-2*beam,ps_len-2*beam,ps_h]);
		// drill mounting hole
		translate([hole_bl[0],0,hole_bl[1]]) rotate([90,0,0]) 
			cylinder(r=hole_diam/2, h=wall);
	}
}

module bottom_mount() {
	difference() {
		translate([-wall,-wall,-wall]) 
		union() {
			// block for bar across
			translate([0,ps_len/2-hanger_len/2-strap_w+wall,0])
				cube([beam+wall, hanger_len+strap_w*2, beam+wall]);
			// right strap holder
			translate([-strap_holder_sz,wall+ps_len/2+hanger_len/2,0])
				difference() {
					cube([strap_holder_sz,strap_w,beam+wall]);
					translate([strap_holder_sz/2-strap_slot/2+wall/2,strap_margin,0])
						cube([strap_slot,strap_w-2*strap_margin,beam+wall]);
				}
			// left strap holder
			translate([-strap_holder_sz,wall+ps_len/2-hanger_len/2-strap_w,0])
				difference() {
					cube([strap_holder_sz,strap_w,beam+wall]);
					translate([strap_holder_sz/2-strap_slot/2+wall/2,strap_margin,0])
						cube([strap_slot,strap_w-2*strap_margin,beam+wall]);
				}
			// hanger
			translate([-hanger_w/2, ps_len/2-hanger_len/2+wall, 0]) 
				difference() {
					cube([hanger_w/2,hanger_len,hanger_thick]);
					translate([-hanger_hole_offset+hanger_hole_spacing, 
									hanger_hole_offset,0]) 
								cylinder(r=hanger_hole_diam/2, h=hanger_thick);
				}
		}
		// cut out for body of PS
		translate([-ps_slip/2,-ps_slip/2,0]) cube([ps_w,ps_len,ps_h]);
		// cut through so bottom of base is open instead of solid
		translate([beam,beam,-wall]) cube([ps_w-2*beam,ps_len-2*beam,ps_h]);
	}
}

top_mount();
// bottom_mount();
translate([35,0,0]) bottom_mount();

