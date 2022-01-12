function [t,T,ste_wave] = DrawInTime(data, ste, fs)
    secondPerFrame = 0.025; % do dai khung (theo s)
    samplePerFrame = fs * secondPerFrame; % do dai khung tinh theo mau
    samplePerFrame = floor(samplePerFrame);
    %convert to ste_wave[] for plotting
    ste_wave = 0;
    for j = 1 : length(ste)
        len = length(ste_wave);
        ste_wave(len : (len + samplePerFrame)) = ste(j);
        % time in sec
        t = 0 : 1/fs : length(data)/fs;         
        t = t(1:end - 1);
        T = 0 : 1/fs : length(ste_wave)/fs;
        T = T(1:end - 1);
    end
   