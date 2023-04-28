
// cutout_front.scad
// Example cutout file for the front wall of the box

module cutout() {
    // Import some parameters from the main file
    include <box_parameters.scad>;
    
    // Define some local variables for convenience
    inner_width = width - 2 * thickness;
    inner_length = length - 2 * thickness;
    inner_height = height - 2 * thickness;
    
    // Create a cutout shape using basic shapes and transformations
    difference() {
        // Start with a rectangle that covers the whole front wall
        square([inner_width, inner_height], center = true);
        
        // Subtract a circle in the center
        circle(d = 20);
        
        // Subtract two smaller circles near the top corners
        for (x = [-1, 1]) {
            translate([x * (inner_width / 2 - 10), inner_height / 2 - 10])
                circle(d = 10);
        }
        
        // Subtract a rounded rectangle near the bottom edge
        translate([0, -inner_height / 2 + 10])
            minkowski() {
                square([40, 10], center = true);
                circle(r = 2);
            }
    }
}
