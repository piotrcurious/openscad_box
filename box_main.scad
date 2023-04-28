
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

// Save some parameters to a separate file for later use
echo("Saving parameters to box_parameters.scad");
saveParameters();

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
                for (

//Source: Conversation with Bing, 4/29/2023
//(1) Creating a Custom-sized Box for 3D Printing With OpenSCAD. https://www.instructables.com/Creating-a-custom-sized-box-for-3D-printing-with-O/.
//(2) OpenSCAD CheatSheet. https://openscad.org/cheatsheet/.
//(3) r/openscad - Design in BlockSCAD for a box w/ a lid which can be cut .... https://www.reddit.com/r/openscad/comments/ugh383/design_in_blockscad_for_a_box_w_a_lid_which_can/.
//(4) larsch/lasercut-box-openscad - Github. https://github.com/larsch/lasercut-box-openscad.
