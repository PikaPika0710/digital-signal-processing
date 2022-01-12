clc;
close all;
%lay tin hieu
%data: bien do lay mau
%fs: tan so lay mau
[data1,fs1] = audioread('TinHieuHuanLuyen/01MDA.wav');
[data2,fs2] = audioread('TinHieuHuanLuyen/02FVA.wav');
[data3,fs3] = audioread('TinHieuHuanLuyen/03MAB.wav');
[data4,fs4] = audioread('TinHieuHuanLuyen/06FTB.wav');
[data5,fs5] = audioread('TinHieuKiemThu/30FTN.wav');
[data6,fs6] = audioread('TinHieuKiemThu/42FQT.wav');
[data7,fs7] = audioread('TinHieuKiemThu/44MTT.wav');
[data8,fs8] = audioread('TinHieuKiemThu/45MDV.wav');

%chuan hoa 
%x = A./B divides each element of A by the corresponding element of B.
data1 = data1./max(data1);
data2 = data2./max(data2);
data3 = data3./max(data3);
data4 = data4./max(data4);
data5 = data5./max(data5);
data6 = data6./max(data6);
data7 = data7./max(data7);
data8 = data8./max(data8);

%SHORT-TIME ENERGY
ste1 = STE(data1, fs1);
ste2 = STE(data2, fs2);
ste3 = STE(data3, fs3);
ste4 = STE(data4, fs4);
ste5 = STE(data5, fs5);
ste6 = STE(data6, fs6);
ste7 = STE(data7, fs7);
ste8 = STE(data8, fs8);

% chuan hoa 
ste1 = ste1./max(ste1);
ste2 = ste2./max(ste2);
ste3 = ste3./max(ste3);
ste4 = ste4./max(ste4);
ste5 = ste5./max(ste5);
ste6 = ste6./max(ste6);
ste7 = ste7./max(ste7);
ste8 = ste8./max(ste8);

%Convert to time
[t1,T1,ste_wave1] = DrawInTime(data1, ste1, fs1);
[t2,T2,ste_wave2] = DrawInTime(data2, ste2, fs2);
[t3,T3,ste_wave3] = DrawInTime(data3, ste3, fs3);
[t4,T4,ste_wave4] = DrawInTime(data4, ste4, fs4);
[t5,T5,ste_wave5] = DrawInTime(data5, ste5, fs5);
[t6,T6,ste_wave6] = DrawInTime(data6, ste6, fs6);
[t7,T7,ste_wave7] = DrawInTime(data7, ste7, fs7);
[t8,T8,ste_wave8] = DrawInTime(data8, ste8, fs8);

%Data from lab

%TIN HIEU HUAN LUYEN
MDA =[0.00, 0.45, 0.81, 1.53, 1.85, 2.69, 2.86, 3.78, 4.15,4.84, 5.14, 5.58];
FVA=[0.00, 0.83, 1.37, 2.09, 2.60, 3.57, 4.00, 4.76, 5.33,6.18, 6.68, 7.18];
MAB=[0.00, 1.03, 1.42, 2.46, 2.80, 4.21, 4.52, 6.81, 7.14,8.22, 8.50, 9.37];
FTB=[0.00, 1.52, 1.92, 3.91, 4.35, 6.18, 6.60, 8.67, 9.14, 10.94, 11.33, 12.75];

%TIN HIEU KIEM THU
FTN =[0.00, 0.59, 0.97, 1.76, 2.11, 3.44, 3.77, 4.70, 5.13, 5.96, 6.28, 6.78];
FQT =[0.00, 0.46, 0.99, 1.56, 2.13, 2.51, 2.93, 3.79, 4.38, 4.77,5.22, 5.79];
MTT =[0.00, 0.93, 1.42, 2.59, 3.00, 4.71, 5.11, 6.26, 6.66,8.04, 8.39 9.27];
MDV =[0.00, 0.88, 1.34, 2.35, 2.82, 3.76, 4.13,5.04,5.50, 6.41, 6.79, 7.42];

%TIM NGUONG
nguongMDA = Nguong(MDA, ste1);
nguongFVA = Nguong(FVA, ste2);
nguongMAB = Nguong(MAB, ste3);
nguongFTB = Nguong(FTB, ste4);
threshold = (nguongMDA + nguongFVA + nguongMAB + nguongFTB)/4;


%TIN HIEU 1
figure('Name','FTN');
subplot(2,1,1);
plot(t5, data5);title('VOWEL/SILENCE');hold on
plot(T5, ste_wave5, 'k', 'LineWidth', 1);ylabel('Amplitude'); xlabel('Time');hold on
for i=1: length(phoneF2) %ke bien chuan
    plot([1 1]*phoneF2(i), ylim, 'r', 'linewidth',2);
end
hold on;
time1=Segmentation(ste5,threshold);
for i=1:length(time1) %ke bien do thuat toan
    plot([1 1]*time1(i), ylim, 'g--', 'linewidth',2);
end
legend('Speech Signal', 'STE (Frame Energy)', 'Bien chuan')


%TIN HIEU 2
figure('Name','Phone_M2');
subplot(2,1,1);
plot(t6, data6);title('VOWEL/SILENCE');hold on
plot(T6, ste_wave6,'k','LineWidth',1);ylabel('Amplitude'); xlabel('Time');hold on
for i=1: length(phoneM2) %ke bien chuan
    plot([1 1]*phoneM2(i), ylim, 'r','linewidth',2);
end
hold on;
time2=Segmentation(ste6, threshold);
for i=1:length(time2) 
    plot([1 1]*time2(i), ylim, 'g--', 'linewidth',2);

end
legend('Speech Signal','STE (Frame Energy)', 'Bien chuan');



%TIN HIEU 3
figure('Name','44MTT');
subplot(2,1,1);
plot(t7, data7);title('VOWEL/SILENCE');ylabel('Amplitude'); xlabel('Time');hold on
plot(T7,ste_wave7,'k','LineWidth',1);hold on
for i=1: length(studioF2) %ke bien chuan
    plot([1 1]*studioF2(i), ylim, 'r', 'linewidth', 2);
end
hold on;
time3=Segmentation(ste7, threshold);
for i=1:length(time3)
    plot([1 1]*time3(i), ylim, 'g--', 'linewidth', 2);

end
legend('Speech Signal','STE (Frame Energy)', 'Bien chuan');



%TIN HIEU 4
figure('Name','Studio_M2');
subplot(2,1,1);
plot(t8, data8);title('DATA INPUT');ylabel('Amplitude'); xlabel('Time');
subplot(2,1,2);
plot(t8, data8);title('DATA OUTPUT');ylabel('Amplitude'); xlabel('Time');hold on
plot(T8,ste_wave8,'k','LineWidth',1);hold on
for i=1: length(studioM2) %ke bien chuan
    plot([1 1]*studioM2(i), ylim, 'r', 'linewidth',2);
end
hold on;
time4=Segmentation(ste8, threshold);
for i=1:length(time4)
    plot([1 1]*time4(i), ylim, 'g--', 'linewidth',2);
end
legend('Speech Signal','STE (Frame Energy)', 'Bien chuan');
