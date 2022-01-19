clc;
close all;
%lay tin hieu
%data: bien do lay mau
%fs: tan so lay mau
% [data1,fs1] = audioread('BT nhom/TinHieuHuanLuyen/phone_F1.wav');
% [data2,fs2] = audioread('BT nhom/TinHieuHuanLuyen/phone_M1.wav');
% [data3,fs3] = audioread('BT nhom/TinHieuHuanLuyen/studio_F1.wav');
% [data4,fs4] = audioread('BT nhom/TinHieuHuanLuyen/studio_M1.wav');
% [data5,fs5] = audioread('BT nhom/TinHieuKiemThu/phone_F2.wav');
% [data6,fs6] = audioread('BT nhom/TinHieuKiemThu/phone_M2.wav');
% [data7,fs7] = audioread('BT nhom/TinHieuKiemThu/studio_F2.wav');
% [data8,fs8] = audioread('BT nhom/TinHieuKiemThu/studio_M2.wav');

[data5,fs5] = audioread('BT nhom/01MDA/a.wav');
[data6,fs6] = audioread('BT nhom/01MDA/e.wav');
[data7,fs7] = audioread('BT nhom/01MDA/i.wav');
[data8,fs8] = audioread('BT nhom/01MDA/o.wav');
%[data5,fs5] = audioread('BT nhom/01MDA/u.wav');

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
%TIN HIeU HUAN LUYEN
phoneF1=[0.00, 0.53, 2.75, 3.23];
phoneM1=[0.00, 0.46, 3.52, 4.15];
studioF1=[0.00, 0.68, 2.15, 2.86];
studioM1=[0.00, 0.87, 2.06, 2.73];
%TIN HIEU KIEM THU
phoneF2=[0.00, 1.02, 4.04, 4.8];
phoneM2=[0.00, 0.53, 2.52, 2.8];
studioF2=[0.00, 0.77, 2.37, 3.14];
studioM2=[0.00, 0.45, 1.93, 2.38];

%TIM NGUONG
nguongPhoneF1 = Nguong(phoneF1, ste1);
nguongPhoneM1 = Nguong(phoneM1, ste2);
nguongStudioF1 = Nguong(studioF1, ste3);
nguongStudioM1 = Nguong(studioM1, ste4);
threshold = (nguongPhoneF1 + nguongPhoneM1 + nguongStudioF1 + nguongStudioM1)/4;


%TIN HIEU 1
figure('Name','Phone_F2');
subplot(2,1,1);
plot(t5, data5);title('DATA INPUT');ylabel('Amplitude'); xlabel('Time');
subplot(2,1,2);
plot(t5, data5);title('DATA OUTPUT');hold on
plot(T5, ste_wave5, 'k', 'LineWidth', 1);ylabel('Amplitude'); xlabel('Time');hold on
% for i=1: length(phoneF2) %ke bien chuan
%     plot([1 1]*phoneF2(i), ylim, 'r', 'linewidth',2);
% end
% hold on;
time1=Segmentation(ste5, threshold);
for i=1:length(time1) %ke bien do thuat toan
    plot([1 1]*time1(i), ylim, 'g--', 'linewidth',2);
end
legend('Speech Signal', 'STE (Frame Energy)', 'Bien chuan')


%TIN HIEU 2
figure('Name','Phone_M2');
subplot(2,1,1);
plot(t6, data6);title('DATA INPUT');ylabel('Amplitude'); xlabel('Time');
subplot(2,1,2);
plot(t6, data6);title('DATA OUTPUT');hold on
plot(T6, ste_wave6,'k','LineWidth',1);ylabel('Amplitude'); xlabel('Time');hold on
% for i=1: length(phoneM2) %ke bien chuan
%     plot([1 1]*phoneM2(i), ylim, 'r','linewidth',2);
% end
% hold on;
time2=Segmentation(ste6, threshold);
for i=1:length(time2) 
    plot([1 1]*time2(i), ylim, 'g--', 'linewidth',2);

end
legend('Speech Signal','STE (Frame Energy)', 'Bien chuan');



%TIN HIEU 3
figure('Name','Studio_F2');
subplot(2,1,1);
plot(t7, data7);title('DATA INPUT');ylabel('Amplitude'); xlabel('Time');
subplot(2,1,2);
plot(t7, data7);title('DATA OUTPUT');ylabel('Amplitude'); xlabel('Time');hold on
plot(T7,ste_wave7,'k','LineWidth',1);hold on
% for i=1: length(studioF2) %ke bien chuan
%     plot([1 1]*studioF2(i), ylim, 'r', 'linewidth', 2);
% end
% hold on;
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
% for i=1: length(studioM2) %ke bien chuan
%     plot([1 1]*studioM2(i), ylim, 'r', 'linewidth',2);
% end
% hold on;
time4=Segmentation(ste8, threshold);
for i=1:length(time4)
    plot([1 1]*time4(i), ylim, 'g--', 'linewidth',2);
end
legend('Speech Signal','STE (Frame Energy)', 'Bien chuan');
