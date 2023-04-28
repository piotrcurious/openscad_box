
// Parametric box generator with screw holes and guides
// Define box dimensions
width = 100; // box width in mm
length = 150; // box length in mm
height = 50; // box height in mm
thickness = 2; // wall thickness in mm
clearance = 0.2; // clearance between lid and base in mm

// Define lid parameters
lid_height = 10; // lid height in mm
lid_offset = 5; // lid offset from base in mm
hinge_radius = 5; // hinge radius in mm
hinge_angle = 90; // hinge opening angle in degrees

// Define base parameters
base_height = height - lid_height; // base height in mm
base_offset = lid_offset + clearance; // base offset from lid in mm

// Define screw parameters
screw_size = "M3"; // screw size (e.g. M3, M4, M5)
screw_length = 12; // screw length in mm
screw_margin = 10; // screw margin from corners in mm
screw_clearance = 0.1; // screw clearance for holes and guides in mm

// Include libraries for screws and nuts
include <nutsnbolts/nutsnbolts.scad>;
include <cyl_head_bolt.scad>;

module box() {
    difference() {
        cube([width, length, height]); // outer box shape
        translate([thickness, thickness, thickness]) 
            cube([width - 2 * thickness, length - 2 * thickness, height - thickness]); // inner box shape
    }
}

module lid() {
    translate([0, 0, height - lid_height]) 
        difference() {
            intersection() {
                box(); // cut lid from box
                rotate([0, hinge_angle, 0]) 
                    translate([-hinge_radius, 0, -hinge_radius]) 
                        cylinder(h = height + 2 * hinge_radius, r = hinge_radius, $fn = 32); // hinge cutout
            }
            for (x = [-1, 1]) {
                for (y = [-1, 1]) {
                    translate([x * (width / 2 - screw_margin), y * (length / 2 - screw_margin), -clearance])
                        hole_through(name=screw_size, l=lid_height+clearance*2, cld=screw_clearance); // screw holes
                }
            }
        }
}

module base() {
    difference() {
        intersection() {
            box(); // cut base from box
            translate([0, 0, -clearance]) 
                cube([width, length, height]); // clearance cutout
        }
        translate([width / 2 - hinge_radius, 0, base_height - hinge_radius]) 
            cylinder(h = length, r = hinge_radius, center = true, $fn = 32); // hinge cutout
        for (x = [-1, 1]) {
            for (y = [-1, 1]) {
                translate([x * (width / 2 - screw_margin), y * (length / 2 - screw_margin), base_height])
                    nutcatch_parallel(name=screw_size, clh=screw_clearance); // screw guides
            }
        }
    }
}

// Uncomment one of the following lines to render the lid or the base

//lid();
//base();

//Source: Conversation with Bing, 4/28/2023
//(1) GitHub - JohK/nutsnbolts: A OpenSCAD library that allows for simple .... https://github.com/JohK/nutsnbolts.
//(2) OpenSCAD - Libraries. https://openscad.org/libraries.html.
//(3) openscad/bolts-and-screws.scad at master - Github. https://github.com/jollyrogerlabs/openscad/blob/master/bolts-and-screws.scad.
