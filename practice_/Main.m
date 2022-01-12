clear;
clc;
close all;
path='D:\BACH KHOA\Nam III_Ki I\XLTHS - Ninh Khanh Duy\practice_\NguyenAmHuanLuyen-16k\';
files = dir('D:\BACH KHOA\Nam III_Ki I\XLTHS - Ninh Khanh Duy\practice_\NguyenAmHuanLuyen-16k\');
for i=7:10
    %random file
    p=strcat(path,files(i).name);
    p=strcat(p,'\');
    %'D:\BACH KHOA\Nam III_Ki I\XLTHS - Ninh Khanh Duy\practice_\NguyenAmHuanLuyen-16k\01MDA';
    p1=strcat(p, '\*.wav');
    %'D:\BACH KHOA\Nam III_Ki I\XLTHS - Ninh Khanh Duy\practice_\NguyenAmHuanLuyen-16k\01MDA\*.wav';
    files1 = dir(p1);
    for j=1:length(files1)
        x = files(i).name + "\" + files1(j).name;
        figure('Name', x); 
        p2=strcat(p,files1(j).name);
        [data,fs]= audioread(p2);
        data=data./max(data);
        t = 0:1/fs:length(data)/fs - 1/fs;
        %window length of 5 msec and step of 3 msec
        subplot(211); 
        plot(t, data); xlabel('Time (s)'); 
        subplot(212);
        %wideband 5ms
        spectrogram(data, 5*10^(-3)*fs, 2*10^(-3)*fs, 1024, fs, 'yaxis');
    end
end

            
