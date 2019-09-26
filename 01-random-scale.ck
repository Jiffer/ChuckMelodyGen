// random note generator
// randomly picks a pitch from the specified scale

// create a SinOsc object s and wire it to the speakers (dac)
SinOsc s => dac;

// use DO (as in DO a deer) to store the value for the starting pitch
// 60 represents middle C in MIDI
60 => int DO;

// create an array that can hold 8 numbers (integers)
int scale[8];

// fill that array with these values
[0, 2, 4, 5, 7, 9, 11, 12 ] @=> scale;

// loop forever
while(1){

   // give me a random number between 0 and 8 (this will be between 0 and 7.9999999…)
   // the $int tells it to make it an integer (i.e. thow away the fractional part of the number)
   Std.rand2f(0,8)$int => int degree;
   
   // using the degree chosen randomly, find out what interval that is from DO
   scale[degree] + DO $ int=> Std.mtof => s.freq;
   
   // print which scale degree was selected
    <<< "random scale degree: " + (degree+1) >>>; 
    
    // wait for .2 seconds then go back to the top of the loop
    .2::second=> now;    
}



