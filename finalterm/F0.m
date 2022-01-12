function [ff, dfty, dfty1, w, numberOfFrame] = F0(data, ste, fs, threshold)

secondPerFrame = 0.025; % do dai khung (theo s)
samplePerFrame = fs * secondPerFrame;
samplePerFrame = ceil(samplePerFrame); % do dai khung tinh theo mau
numberOfFrame = length(data)/samplePerFrame;
numberOfFrame = floor(numberOfFrame);
ff = zeros(1,numberOfFrame);

for i=1: numberOfFrame
    if(ste(i) >= threshold)
        y = data((samplePerFrame*(i-1)+1) : (samplePerFrame*i)); % lay data khung
        y = y/max(abs(y)); % chuan hoa du lieu
        N_FFT = 2048; % so diem lay mau tren mien tan so
        C = fs/N_FFT; % do lech tan so
        dfty = abs(fft(y, N_FFT));  % pho cua 1 khung
        dfty=dfty(1:(length(dfty)/2));
        %khoang cach giua cac hai lien tiep nhau (hai tuong ung voi vach pho)
        k=1:N_FFT; % chi so tan so roi rac
        w=k*fs/N_FFT; % truc tan so w
        dfty_log = 10*log10(dfty); %log pho bien do (db)
        %bo sung dinh dau tien
        %fsecond = C/2;
        [d,index]=findpeaks(dfty_log(1:length(dfty_log)),'SortStr','descend');  %tim va sap xep theo chieu giam dan gia tri cuc dai va vi tri cuc dai
        x = 1;
        qr1 = zeros();
        for j = 1: length(index)
                %f = C*(index(j)-1) + fsecond;
                f = C*index(j);
                if(f<1000 && abs(f - mean(qr1)) > 100)
                    qr1(x) = f;
                    x=x+1;  
                end  
                if(x == 5) 
                    break;
                end
        end
         F = sort(qr1,'ascend');
         hz =zeros();
         for e=1:length(F)-1
                hz(e)=F(e+1)-F(e);
         end
         meanF = mean(hz);
         if(meanF < 70 || meanF > 400) 
             ff(i) = 0;
         else
             ff(i) = meanF;
         end
     end
end

y1=data(samplePerFrame*(1-1)+1 : samplePerFrame*1);
max_value1=max(abs(y1));
y1=y1/max_value1;
dfty1=abs(fft(y1, N_FFT));