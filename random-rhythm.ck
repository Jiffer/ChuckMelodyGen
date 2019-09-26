

SinOsc s => ADSR e => dac;

e.keyOn();

int note[8];
[0, 2, 4, 5, 7, 9, 11, 12 ] @=> note;
[0, 0, -1, 1] @=> int nextStep[]; // statistics
// rhythm
[[2, 1, 2, 1],[2,1,1,1],[2,1,0,0]] @=> int r[][];

0 => int beat;
0 => int measure;
0.1 => float quarter;

int deg;


while(1){
   rhythm();
}


fun void next(){
    Std.rand2f(0,nextStep.size())$int => int step;
    nextStep[step] +=> deg;
    if (deg < 0)
        0=>deg;
    else if(deg > 7)
        7=>deg;
 
    note[deg] + 60 $ int=> Std.mtof => s.freq;
 
 <<< deg , " ", nextStep[step]>>>;   
}

fun void rhythm(){
    if (r[measure][beat] > 0)
    {
        if(e.state() == 2)
        {}
        else{
            next();
            e.keyOn();
        }
            
        if(r[measure][beat] ==1){
            
            (quarter-.1*quarter)::second => now;
            //0 => g.gain;
            e.keyOff();
            (.1*quarter)::second => now;
        }
        else
            quarter::second => now;
    }
    else{
        //0 => g.gain;
        e.keyOff();
        quarter::second => now;
    }
    
    // go to the next beat
    beat++;
    if(beat == 4){
        0 => beat;
        measure++;
        measure % r.size() => measure;
        <<< measure>>>;
    }
    beat % 4 => beat;
}
