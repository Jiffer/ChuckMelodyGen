// create a SinOsc object s and wire it to the speakers (dac)
SinOsc s => ADSR e1 => dac;

// create an array to hold my scale 
// fill that array with these values
[0, 2, 4, 5, 7, 9, 11, 12 ] @=> int scale[];

// melody notes and rhythmic pattern
[[0,4], [2,4], [4,2], [5,2], [7,2], [6,2], [5,2], [2,4]] @=> int melody[][];

// ostinato voice
SinOsc o => ADSR e2 => dac;
// set DO (60 is MIDI for middle C)
60 => int DO;
DO - 12 => Std.mtof => o.freq;

// ostinato pattern
[1, 1, -1, 1, -1, -1, 1, -1] @=> int pattern[];

.2::second => dur quarter;

spork ~ ostinato();

    // for loop
for(0=> int numTimes; numTimes < 4; numTimes++){
    for(0 => int mi; mi < melody.size(); mi++){          
        if(melody[mi][1] > 0){
            scale[melody[mi][0]] + DO=> Std.mtof => s.freq;
            e1.keyOn();
        }
        else if(melody[mi][1] < 0){
            e1.keyOff();
        }
        quarter * Std.abs(melody[mi][1]) => now; // eigth note
    }
 }
 
// turn off the notes before ending
e1.keyOff();
e2.keyOff();
quarter=> now;

fun void ostinato(){
    while(1){
        for(0 => int i; i< pattern.size(); i++){
            if(pattern[i] > 0){
                e2.keyOn();
            }
            else if(pattern[i] < 0){
                e2.keyOff();
            }
            quarter * Std.abs(pattern[i]) => now; // eigth note
        }
    }
}