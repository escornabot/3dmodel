// Protoloura <Wheel.scad>
//
// Copyright (c) 2014 Tucho Méndez, Xoan Sampaiño
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

radius = 36;
thickness = 6;
oring = 3;

module wheel(r = radius, t = thickness, o = oring) {
  difference() {
    cylinder(r = r,h = t, $fn = 96, center = true);

    //axis
    translate([0,0,5/2-1-t/2]) intersection() {
      cylinder(r = 5/2, h = 5, $fn = 24, center = true);
      cube([3,6,5], center = true);
    }

    //cutout
    difference() {
      cylinder(r1 = sqrt(2)*r/2+r/8, r2 = r, h = t, $fn = 96);
      cylinder(r1 = r/2+2-r/3, r2 = (r/2+2-r/3)-(r-(sqrt(2)*r/2+r/8)), h = t, $fn = 48);
    }
    translate([0,0,t/3]) cylinder(r=r/2, h = t/2);

    //oring
    %color("black") rotate_extrude($fn = 96)
      translate([r,0,0])
        circle(r = o/2, $fn = 24);
    //groove
    rotate_extrude($fn = 96)
      translate([r,0,0])
        circle(r = o/2*sqrt(2), $fn = 4);

    //holes
    for (i = [0:90:270]) rotate([0,0,i]) {
      translate([(r/2+2),0,0])
        cylinder(r = r/3, h = t+2, $fn = 48, center = true);
      translate([r/2,r/2,0])
        cylinder(r = r/8, h = t+2, $fn = 48, center = true);
    }
  }
}

wheel();

