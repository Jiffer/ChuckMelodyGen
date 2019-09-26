// random melody generator
// randomly picks the same pitch, a step up or down from current scale degree

// create a SinOsc object s and wire it to the speakers (dac)
SinOsc s => dac;

// use DO (as in DO a deer) to store the value for the starting pitch
// 60 represents middle C in MIDI
60 => int DO;

// keep track of which octave I'm in
0 => int octave;

// create an array to hold my scale 
// fill that array with these values
[0, 2, 4, 5, 7, 9, 11, 12 ] @=> int scale[];

// create an array to hold my steps I can move by
[0, 0, -1, 1] @=> int steps[]; 

// variable to remember which scale degree I'm playing
0 => int degree;

// loop forever
while(1){
    
    // calculate the next note to play
    next();
    
    // load the note into the frequency parameter of the SinOsc object
    scale[degree] + DO + octave * 12 $ int=> Std.mtof => s.freq;

    // let time pass
    .2::second=> now;
}

// this is a function!
// calculate the next step and load the correct value into degree
fun void next(){
    
    // randomly pick a step from the array
    steps[Std.rand2f(0,steps.size())$int] +=> degree;
    
    // if it went outside of the scale, change octaves
    if (degree >= scale.size()){
        octave++;
        0 => degree;
        <<< "octave up", octave>>>;
    }
    else if (degree < 0){
        octave--;
        (scale.size() -1) => degree;
        <<< "octave down", octave>>>;
    }
 
  // only go up or down 2 octaves
  if (octave > 2)
      2 => octave;
  else if (octave < -2)
      -2 => octave;

}
