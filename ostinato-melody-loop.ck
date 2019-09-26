// create a SinOsc object o and wire it to the speakers (dac)
SinOsc o => ADSR e2 => dac;

// set DO
60 => int DO;
DO => Std.mtof => o.freq;

// ostinato pattern
// positive numbers are played, negative are rests
[1, 1, -3] @=> int pattern[];

// how long is an eight note?
.2::second => dur eighth;

spork ~ ostinato();
SinOsc s => dac;

while(1){
DO => Std.mtof => s.freq;
// for loop
eighth => now;

DO + 2 => Std.mtof => s.freq;
// for loop
eighth => now;

DO + 4 => Std.mtof => s.freq;
// for loop
eighth => now;

DO + 5=> Std.mtof => s.freq;
// for loop
eighth * 2 => now;

DO + 5=> Std.mtof => s.freq;
// for loop
eighth => now;

DO + 4=> Std.mtof => s.freq;
// for loop
eighth => now;
DO + 2=> Std.mtof => s.freq;
// for loop
eighth => now;

DO => Std.mtof => s.freq;
// for loop
eighth => now;



}




fun void ostinato(){
    while(1){
        for(0 => int i; i< pattern.size(); i++){
            if(pattern[i] > 0){
                e2.keyOn();
            }
            else if(pattern[i] < 0){
                e2.keyOff();
            }
            eighth * Std.abs(pattern[i]) => now; // eigth note
        }
    }
}