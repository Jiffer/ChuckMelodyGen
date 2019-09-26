// random pitch generator

// create a SinOsc object called s and wire it to the speakers (dac)
SinOsc s => dac;

// loop forever
while(1){ 
    // give me a random number between 400 and 800
    Std.rand2f(200, 1000) $ int => int frequency;
    
    // assign that random frequency to SinOsc s
    frequency => s.freq;
    
    // wait for .2 seconds then go back to the top of the loop
    .2::second=> now;
}



