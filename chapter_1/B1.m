[x,Fs] = audioread('16hz.wav');
mulFs = Fs*2;
divFs = Fs/2;
sampleLength = length(x);
secondLength = (sampleLength-1)/Fs;
plot(x);
sound(x,Fs);
sound(x,mulFs);
sound(x,divFs)  ;