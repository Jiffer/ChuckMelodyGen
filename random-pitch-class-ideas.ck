// random pitch generator

// create a SinOsc object called s and wire it to the speakers (dac)
SinOsc s => dac;
SinOsc s2 => dac;

// loop forever
while(1){ 
    // give me a random number between 400 and 800

    // Std.rand2f(300, 340) $ int => int frequency;
    
    //990 => int frequency;
    
    Std.rand2f(100, 800) $ int => int frequency;
    
    // assign that random frequency to SinOsc s
    frequency => s.freq;
    
    // wait for .2 seconds then go back to the top of the loop
    1::second=> now; // storm
    
    // for the next voice!    
    Std.rand2f(100, 800) $ int => frequency;
    
    // assign that random frequency to SinOsc s
    frequency => s2.freq;
    
    // wait for .2 seconds then go back to the top of the loop
    .5::second=> now; // storm

}



