WallThickness = 2;
//BallSize = 13; te ruim
//BallSize = 12.7; bijna
//BallSize = 12.4;goed
BallSize = 13;
Airgap = .5;
Mount = 3;
TotalHeight = 19; 		//this includes the ball
MountScrewRad = 1.5;  	//3mm screw
BallProtrude = .30; 	//percentage of ball radius sticking out 
ScrewSpacing = 25;		//spaceing of the mountholes center to center
MountMiddle = true; 	//mount int the center
MountBase = false;		//use mount base 2 holes


cylrad = (BallSize/2) + WallThickness + Airgap;
echo (cylrad);


difference()
{
	union()
	{
		ball_mount ();
		if(MountBase)
		{		
			base();
		}
	}
	if(MountMiddle)
	{
		cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= TotalHeight,center=true, $fn=30);
		translate([0,0,(TotalHeight-BallSize)/2]) 
		{
			cylinder(r1 = MountScrewRad*2, r2 = MountScrewRad*2, h= TotalHeight, $fn=30);
		}
	}
}

module ball_mount ()
{
	difference () 
	{
		cylinder(r1 = cylrad , r2 = cylrad,  TotalHeight - (BallSize*BallProtrude));
	
		translate([0,0,TotalHeight - BallSize/2]) 
		{
			cube(size = [cylrad*2+5, cylrad/2, BallSize*1.25], center = true );
			rotate([0,0,90]) cube(size = [cylrad*2+5, cylrad/2, BallSize*1.25], center = true );
		}
	
		translate([0,0,TotalHeight - (BallSize/2)]) 
		{
			sphere (BallSize/2+Airgap, $fa=5, $fs=0.1);
		}
	}
}
module base()
{
	difference (){
		linear_extrude(height=Mount)
		hull() {
			translate([ScrewSpacing/2,0,0]) {
				circle(  MountScrewRad*3);
			}
			translate([0-ScrewSpacing/2,0,0]) {
				circle( MountScrewRad*3);
			}
			circle( cylrad);
		}
	
		translate([ScrewSpacing/2,0,-1]) {
			#cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= Mount+2,$fn=30);
		}
		translate([0-ScrewSpacing/2,0,-1]) {
			#cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= Mount+2,$fn=30);
			
		}
	}
}
