// random melody generator
// randomly picks a step from current note
// constrained to 5 octaves

// create a SinOsc object s and wire it to the speakers (dac)
SinOsc s => dac;

// create an array to hold my scale 
// fill that array with these values
[0, 2, 4, 5, 7, 9, 11, 12 ] @=> int scale[];

// create an array to hold my steps I can move by
[0, 0, 0, 0, -1, -1, 1, 1, -2, 2, -3, 3, -4, 4, -5, 5] @=> int steps[]; 

// variable to remember which scale degree I'm playing
0 => int degree;

// use DO (as in DO a deer) to store the value for the starting pitch
// 60 represents middle C in MIDI
60 => int DO;

// keep track of which octave I'm in
0 => int octave;

// loop forever
while(1){
    
   next();
   
   
   scale[degree] + DO + 12 * octave $ int=> Std.mtof => s.freq;
   // what note
    
   .4::second=> now;
}

// this is a function!
// calculate the next step and load the correct value into degree
fun void next(){
    // randomly pick a step from the array
    steps[Std.rand2f(0,steps.size())$int] +=> degree;
    
    // if it exceeded the scale change octaves
    if (degree < 0){
        scale.size()-Std.abs(degree)=>degree;
        octave--;
    }
    else if(degree > 7){
        degree - scale.size() => degree;
        octave ++;
    }
    
    // only go up or down 2 octaves
    if (octave > 2){
        2 => octave;
        (scale.size()-1) => degree;
    }
    else if(octave < -2){
        -2 => octave;
        0 => degree;
    }
    
}
