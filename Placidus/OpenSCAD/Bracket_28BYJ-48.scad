// Bracket for  28BYJ-48 stepper motor
// 28BYJ-48 model from RGriffoGoes www.thingiverse.com/thing:204734
// added details by J.Beale 21 July 2014
// Bracket by J.Beale 9 Aug 2014

slop = 0.25;  // printer tolerance
layer = 0.25; // layer height

// =========================================================
// stepper motor body model

MBH = 18.8;   // motor body height
MBD = 28.25+slop;  // motor body OD
SBD = 9.1+slop;    // shaft boss OD
SBH = 1.45;   // shaft boss height above motor body
SBO = 7.875;  // offset of shaft/boss center from motor center
//SHD = 4.93+slop*2;   // motor shaft OD+ countersink for boss
SHD = 11.9+slop;   // motor shaft OD (larger clearance hole)
SHDF = 3.0;   // motor shaft diameter, across flats
SHHF = 6.0;   // motor shaft flats height, or depth in from end
SHHF = 0.0;   // assume round shaft for purposes of bracket
SHH = 9.75;   // height of shaft above motor body 

MBFH = 0.7;   // height of body edge flange protruding above surface
MBFW = 1.0+slop;   // width of edge flange
MBFNW = 8;    // width of notch in edge flange
MBFNW2 = 17.8;  // width of edge flange notch above wiring box

MHCC = 35.0;  // mounting hole center-to-center
MTH  = 0.8;   // mounting tab thickness
MTW  = 7.0;   // mounting tab width
// MTHID = 4.0;  // mounting tab hole inner diameter
MTHID = 3.0;  // mounting tab hole inner diameter
WBH  = 16.7;  // plastic wiring box height
WBW  = 14.6+slop;  // plastic wiring box width
WBD  = 31.3+slop;  // body diameter to outer surface of wiring box

WRD = 1.0;     // diameter of electrical wires
WRL = 30;      // length of electrical wires
WRO = 2.2;		// offset of wires below top motor surface
// =========================================================
// right-angle bracket for motor

MSOD = 5.9 + slop;  // M3 mounting screw head diameter
MSTH = 2.0;  // M3 screw head thickness (for countersink)
//MSTH = 0; // set to zero for no screwhead countersink
MSSD = 3.1 + slop;  // M3 screw diameter clearance hole
Bthick = 4;  // thickness of bracket
Bdia = (MHCC+10);  // diameter of bracket face

// =========================================================
fn = 80;
eps = 0.05;   // small number to avoid coincident faces


module StepMotor28BYJ()
{
  difference(){
    union(){
	   color("gray") translate([0,0,-(MBH+MBFH)/2])
		  difference() {  // flange at top rim
         cylinder(h = MBFH+eps, r = MBD/2, center = true, $fn = 50);
         cylinder(h = MBFH+2*eps, r = (MBD-MBFW)/2, center = true, $fn = 32);
			cube([MBFNW,MHCC,MBFH*2],center=true); // notches in rim
			cube([MBD+2*MBFW,SBD,MBFH*2],center=true);
		   translate([-MBD/2,0,0]) cube([MBD,MBFNW2,MBFH*2],center=true);
        }
		color("gray") // motor body
			cylinder(h = MBH, r = MBD/2, center = true, $fn = 50);
		color("gray") translate([SBO,0,-SBH])	// shaft boss
			cylinder(h = MBH, r = SBD/2, center = true, $fn = 32);

		translate([SBO,0,-SHH])	// motor shaft
        difference() {
			color("gold") cylinder(h = MBH, r = SHD/2, center = true, $fn = 32);
				// shaft flats
		   color("red") translate([(SHD+SHDF)/2,0,-(eps+MBH-SHHF)/2]) 
				cube([SHD,SHD,SHHF], center = true);
		   color("red") translate([-(SHD+SHDF)/2,0,-(eps+MBH-SHHF)/2]) 
				cube([SHD,SHD,SHHF], center = true);
        }


		color("Silver") translate([0,0,-(MBH-MTH-eps)/2]) // mounting tab 
			cube([MTW,MHCC,MTH], center = true);				
		color("Silver") translate([0,MHCC/2,-(MBH-MTH)/2]) // mt.tab rounded end
			cylinder(h = MTH, r = MTW/2, center = true, $fn = 32);
		color("Silver") translate([0,-MHCC/2,-(MBH-MTH)/2]) // mt.tab rounded end
			cylinder(h = MTH, r = MTW/2, center = true, $fn = 32);


		color("blue") translate([-(WBD-MBD),0,eps-(MBH-WBH)/2]) // plastic wire box
			cube([MBD,WBW,WBH], center = true);
	   color("blue") translate([-2,0,0])	
			cube([24.5,16,15], center = true);
		}

				// mounting holes in tabs on side
		color("red") translate([0,MHCC/2,-MBH/2])	
				cylinder(h = 2, r = MTHID/2, center = true, $fn = 32);
		color("red") translate([0,-MHCC/2,-MBH/2])	
				cylinder(h = 2, r = MTHID/2, center = true, $fn = 32);
		}
}

module MOT() {
 translate([0,0,-MBH/2]) 
 rotate([180,0,0]) StepMotor28BYJ();  // motor body (without wires)
}


module bracket() {
difference() {
 union() {
  translate([0,0,-2]) cylinder(h=Bthick, r=Bdia/2, $fn=fn);  // round face
  translate([-eps + MBD/2,-Bdia/2,-16+Bthick/2]) 
		cube([4+eps,Bdia,16]); // flange
  translate([-0,-Bdia/2,-Bthick/2]) 
	cube([Bdia,Bdia,Bthick]); // square edge joining round face to flange
  translate([MBD/2,Bdia/2,-Bthick/2]) rotate([90,0,0]) {
	difference(){cylinder(r=Bthick,h=Bdia,$fn=32); // round fillet at flange
   translate([-Bthick,-Bthick,0])cylinder(r=Bthick,h=Bdia,$fn=32); // round fillet at flange
}
}
 }
 union() {
   translate([4+MBD/2,-MBD,-MBD]) cube([MBD*2,MBD*2,MBD*2]);
   translate([0,MHCC/2,-15-layer])	// motor mounting bolt
				cylinder(h = 30, r = MSSD/2, center = true, $fn = 32);
   translate([0,-MHCC/2,-15-layer])	// motor mounting bole
				cylinder(h = 30, r = MSSD/2, center = true, $fn = 32);
   translate([10,MHCC/2,-10+1]) rotate([0,90,0]) 	// flange mounting bolt
				cylinder(h = 30, r = MSSD/2, center = true, $fn = 32);
   translate([10,-MHCC/2,-10+1]) rotate([0,90,0]) 	// flange mounting bolt
				cylinder(h = 30, r = MSSD/2, center = true, $fn = 32);

   color("white") translate([0,MHCC/2,((Bthick/2) - MSTH + eps)]) 
	 cylinder(r=MSOD/2, h=MSTH, $fn=25); // motor screw countersink
   color("white") translate([0,-MHCC/2,((Bthick/2) - MSTH + eps)])  
	 cylinder(r=MSOD/2, h=MSTH, $fn=25); // motor screw countersink

   translate([0,0,-1.6]) MOT(); // body of motor
   //translate([0,0,-10]) cube([50,50,50]); // DEBUG cutaway view
 }
}
} // end module()

rotate([180,0,0]) bracket();  // show the motor bracket

