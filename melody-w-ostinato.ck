// create a SinOsc object s and wire it to the speakers (dac)
SinOsc s => ADSR e1 => dac;

// create an array to hold my scale 
// fill that array with these values
[0, 2, 4, 5, 7, 9, 11, 12 ] @=> int scale[];

// melody notes and rhythmic pattern
[0, 2, 4, 5, 7, 6, 5, 2 ] @=> int melody[];
[2, 2, 1, 2, 2, 2, 1, 4 ] @=> int melodyRhythm[];

// ostinato voice
SinOsc o => ADSR e2 => dac;

60 => int DO;
DO - 12 => Std.mtof => o.freq;


// ostinato pattern
[1, 1, -1, 1, -1, -1, 1, -1] @=> int pattern[];

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