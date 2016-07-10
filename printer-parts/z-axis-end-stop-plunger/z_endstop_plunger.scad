m3_nut_diam = 6.5;
m3_nut_thick = 3.5;
m3_nut_adjust = 0.5;
m3_diam = 3;
nut_block_w = 15;
nut_block_h = 10;
nut_block_d = 7;
bolt_clearance = 60;
arm_w = 15;
arm_thick = 4;
m5_diam = 5;
slot_len = 160;
arm_len = slot_len + bolt_clearance + nut_block_d;
arm_mount_margin = 8;
mount_spacer_thick = 3;

module nut_block() {
	difference() {
		// the block
		cube([nut_block_w, nut_block_d, nut_block_h]);
		// adjustment screw hole and nut trap
		translate([nut_block_w/2, 0, nut_block_h/2])
		rotate([-90,0,0]) 
		union() {
			// hole
			cylinder(r=m3_diam/2, h=nut_block_d*2, $fn=32);
			// nut trap
			translate([-m3_nut_adjust,0,nut_block_d/2-m3_nut_thick/2])
			union() {
				// nut shape
				cylinder(r=m3_nut_diam/2, h=m3_nut_thick);
				// cutout to slide in nut
				translate([0, -m3_nut_diam/2,0]) 
					cube([nut_block_w, m3_nut_diam, m3_nut_thick]); 
			}
		}
	}
}

module arm() {
	difference() {
		union() {
			cube([arm_w, arm_len, arm_thick]);
			translate([0,0,arm_thick])
				cube([arm_w, slot_len+2*arm_mount_margin, mount_spacer_thick]);
		}
		translate([arm_w/2, arm_mount_margin, 0])
			cylinder(r=m5_diam/2, h=arm_thick*2, $fn=32);
		translate([arm_w/2-m5_diam/2, arm_mount_margin, 0])
			cube([m5_diam, slot_len, arm_thick*2]);
		translate([arm_w/2, arm_mount_margin+slot_len, 0])
			cylinder(r=m5_diam/2, h=arm_thick*2, $fn=32);
		
			
	}
}

module z_endstop_arm() {
	union() {
		arm();
		translate([(arm_w-nut_block_w)/2, arm_len-nut_block_d, arm_thick])
			nut_block();
	}
}

z_endstop_arm();
// nut_block();