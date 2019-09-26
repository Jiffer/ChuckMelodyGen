// create a SinOsc object s and wire it to the speakers (dac)
SinOsc s => ADSR e1 => dac;

// create an array to hold my scale 
// fill that array with these values
[0, 2, 4, 5, 7, 9, 11, 12 ] @=> int scale[];

// set DO
60 => int DO;
DO => Std.mtof => o.freq;


// ostinato pattern
// positive numbers are played, negative are rests
[1, 1, -1, 1, -1, -1, 1, -1] @=> int pattern[];

// how long is an eight note?
.2::second => dur eighth;

spork ~ ostinato();

while(1){
// for loop
for(0=> int numTimes; numTimes < 20; numTimes++){

    for(0 => int mi; mi < melody.size(); mi++){

        if(melodyRhythm[mi] > 0){
            scale[melody[mi]] + DO=> Std.mtof => s.freq;
            e1.keyOn();
        }
        else if(melodyRhythm[mi] < 0){
            e1.keyOff();
        }
        eighth * Std.abs(melodyRhythm[mi]) => now; // eigth note
    }
}
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