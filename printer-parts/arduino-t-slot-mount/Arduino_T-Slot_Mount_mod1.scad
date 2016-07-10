holes_size = 1.75; // Radius
holes_size_outter = 3.75; // Radius
holes_support = 11;
$fn=100;

difference() {
	union() {
		translate([70.5,0,0]) {
			translate([0,-17,0]) {
				translate([17,0,0])rotate([0,0,180])t_slot();
				cube([10,62,1.3]);
			}
			translate([6.8,-18,0])rotate([0,0,3.5])cube([3,63,holes_support*.65]);
		}

		translate([-3,0,0]) {
			translate([0,-17,0]) {
				translate([-3,0,0])t_slot();
				cube([10,62,1.3]);
			}
			translate([6.8,-18,0])rotate([0,0,3.5])cube([3,63,holes_support*.65]);
		}

		translate([3,-19,0])cube([75,4,12]);

		#translate([-3,-19,0])cube([7.5,18,7.15]);
		#translate([77,-19,0])cube([7.5,18,7.15]);

		arduino_holes();

		linear_extrude(height=1.3)barbell([75,48],[0,0],6,6,230,230);
		linear_extrude(height=1.3)barbell([81.5,0],[1,48],6,6,240,240);
	}
	union() {
		// Holes
		//RB
			cylinder(r=holes_size,h=holes_support, $fn=20);
		//LB
			translate([1,48,0])cylinder(r=holes_size,h=holes_support, $fn=20);
		//RT
			translate([81.5,0,0])cylinder(r=holes_size,h=holes_support, $fn=20);
		//LT
			translate([75,48,0])cylinder(r=holes_size,h=holes_support, $fn=20);
	}
}




module arduino_holes() {
difference() {

union() {
// Outter
//RB
	cylinder(r=holes_size_outter,h=holes_support, $fn=20);
//LB
	translate([1,48,0])cylinder(r=holes_size_outter,h=holes_support, $fn=20);
//RT
	translate([81.5,0,0])cylinder(r=holes_size_outter,h=holes_support, $fn=20);
//LT
	translate([75,48,0])cylinder(r=holes_size_outter,h=holes_support, $fn=20);
}
// Holes
//RB
	cylinder(r=holes_size,h=holes_support, $fn=20);
//LB
	translate([1,48,0])cylinder(r=holes_size,h=holes_support, $fn=20);
//RT
	translate([81.5,0,0])cylinder(r=holes_size,h=holes_support, $fn=20);
//LT
	translate([75,48,0])cylinder(r=holes_size,h=holes_support, $fn=20);
}

}

module t_slot() {

	difference() {
		translate([0,0,6])cube([20,4,12],true);
		translate([-4,3,6])rotate([90,0,0])cylinder(r=3, h=10);
	}

}


module barbell (x1,x2,r1,r2,r3,r4) 
{
	x3=triangulate (x1,x2,r1+r3,r2+r3);
	x4=triangulate (x2,x1,r2+r4,r1+r4);
	render()
	difference ()
	{
		union()
		{
			translate(x1)
			circle (r=r1);
			translate(x2)
			circle(r=r2);
			polygon (points=[x1,x3,x2,x4]);
		}
		translate(x3)
		circle(r=r3,$fa=5);
		translate(x4)
		circle(r=r4,$fa=5);
	}
}

function triangulate (point1, point2, length1, length2) = 
point1 + 
length1*rotated(
atan2(point2[1]-point1[1],point2[0]-point1[0])+
angle(distance(point1,point2),length1,length2));

function distance(point1,point2)=
sqrt((point1[0]-point2[0])*(point1[0]-point2[0])+
(point1[1]-point2[1])*(point1[1]-point2[1]));

function angle(a,b,c) = acos((a*a+b*b-c*c)/(2*a*b)); 

function rotated(a)=[cos(a),sin(a),0];
