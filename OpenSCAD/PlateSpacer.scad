// Protoloura <PlatSpacer.scad>
//
// Copyright (c) 2014 Xoan Sampaiño
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

spanner = 6;
screw = 3;
height = 30;
depth = 8;

module spacer(sp = spanner, sc = screw, h = height, d = depth) {
  difference() {
    cylinder(r = sp/2/sin(60), h = h, $fn = 6, center = true);
    for (i = [1,-1])
      translate([0,0,-i*h/2+i*d/2-i])
        cylinder(r = (sc-0.2)/2, h = d+2, center = true, $fn = 24);
  }
}

rotate([90,0,0]) spacer();