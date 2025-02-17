tic
clear;
clc;
close all;
max_accuracy = 0;
accuracy = zeros(3, 5);

for n = 13:13:39 %so chieu
    if(n == 39)
        n = n-1;
    end
    for k = 1:5 %k clusting
        path='D:\BACH KHOA\Nam III_Ki I\XLTHS - Ninh Khanh Duy\practice_final\TH2\TH2\NguyenAmHuanLuyen\';
        files = dir(path);
        
        %21 mfcc vectors of each vowel
        %initiate vector
        a=zeros(21,n-1);
        u=zeros(21,n-1);
        e=zeros(21,n-1);
        ii=zeros(21,n-1);
        o=zeros(21,n-1);
        rnames = {'a','e','i', 'o', 'u'};
        for i=4:24
            p=strcat(path,files(i).name);
            p=strcat(p,'/');
            p1=strcat(p, '/*.wav');
            files1 = dir(p1);
            for j=1:length(files1)
                x = files(i).name + "/" + files1(j).name;
                p2=strcat(p,files1(j).name);
                [data,fs]= audioread(p2);
                index = (i-4)*j + j;
                
                %Trich xuat vecto theo tung nguyen am
                if (j==1)
                    a(i-3,:)=program(data, fs, index, x,n);
                elseif (j==2)
                    e(i-3,:)=program(data, fs, index, x,n);
                elseif (j==3)
                    ii(i-3,:)=program(data, fs, index, x,n);
                elseif (j==4)
                    o(i-3,:)=program(data, fs, index, x,n);
                elseif (j==5)
                    u(i-3,:)=program(data, fs, index, x,n);
                end
            end
        end
        
        %K-mean clustering
        [~,mean_a]=kmeans(a,k);
        [~,mean_e]= kmeans(e,k);
        [~,mean_ii]= kmeans(ii,k);
        [~,mean_o]= kmeans(o,k);
        [~,mean_u]= kmeans(u,k);
        
        
%         %xuat 5 vecto dac trung voi k=1
%         if(k==1) 
%             figure
%             plot(mean_a,'g-o')
%             hold on;
%             plot(mean_e,'b-o')
%             hold on;
%             plot(mean_ii,'r-o')
%             hold on;
%             plot(mean_o, 'c-o')
%             hold on;
%             plot(mean_u, 'k-o')
%             legend('\a\', '\e\', '\i\', '\o\', '\u\')
%         end
        
        %Cau 3 so khop va xuat ket qua
        mang = zeros(5*k,n-1);
        for i =1:5
            for j=1:k
                if i==1
                    mang((i-1)*k+j,:)=mean_a(j,:);
                elseif i==2
                    mang((i-1)*k+j,:)=mean_e(j,:);
                elseif i==3
                    mang((i-1)*k+j,:)=mean_ii(j,:);
                elseif i==4
                    mang((i-1)*k+j,:)=mean_o(j,:);
                elseif i==5
                    mang((i-1)*k+j,:)=mean_u(j,:);
                end
            end
        end
        
        path_kt='D:\BACH KHOA\Nam III_Ki I\XLTHS - Ninh Khanh Duy\practice_final\TH2\TH2\NguyenAmKiemThu\';
        files_kt = dir(path_kt);
        result= zeros(5,5);
        wrong_result = 0;
        for i=4:24
            p=strcat(path,files(i).name);
            p=strcat(p,'/');
            p1=strcat(p, '/*.wav');
            files1 = dir(p1);
            for j=1:length(files1)
                x = files(i).name + "/" + files1(j).name;
                p2=strcat(p,files1(j).name);
                [data,fs]= audioread(p2);
                vecto =program(data, fs, index, x,n);
                index= sokhop(files1(j).name ,vecto,mang,k);
                result(j, index) = result(j, index) + 1;
                nhandang(i-3,j) = rnames(index);
                if(j ~= index) wrong_result = wrong_result + 1;
                end
            end
        end
        dcx = (105 - wrong_result) * 100 / 105;
        accuracy(ceil(n/13), k) = dcx;
        if(dcx > max_accuracy)
            max_N = n;
            max_K = k;
            nhandangFinal = nhandang;
            max_accuracy = dcx ;
            rs_a = result(:,1);
            rs_e =  result(:,2);
            rs_i =  result(:,3);
            rs_o =  result(:,4);
            rs_u =  result(:,5);            
        end
    end
end

%do chinh xac cao nhat

%ma tr?n nh?m l?n cho t? h?p (N,K) t?i ?u nh?t

rs = magic(5);
rs(:,1) =rs_a;
rs(:,2) =rs_e;
rs(:,3) =rs_i;
rs(:,4) =rs_o;
rs(:,5) =rs_u;

f1 = figure('Name', 'Confusion Matrix','Position',[400 400 600 200]);
cnames = {'rs_a','rs_e','rs_i','rs_o', 'rs_u'};
t = uitable('Parent',f1,'Data',rs,'ColumnName',cnames, ...
    'RowName',rnames,'Position',[50 50 450 150]);

% bo sung trung binh

mean_N = mean(transpose(accuracy));
accuracy_mean = zeros(3,6);
accuracy_mean = accuracy;
for i = 1: 3
    accuracy_mean(i,6) = mean_N(i);
end

% l?p b?ng báo cáo k?t qu? ?? chính xác nh?n d?ng t?ng h?p (%) theo s? chi?u c?a
% vector ??c tr?ng N và s? c?m K trong 1 l?n ch?y
f2 = figure('Name', 'Accuracy Table','Position',[400 400 600 200]);
cnames = {'1', '2','3','4','5', 'mean'};
rnames = {'13','26','39'};
t = uitable('Parent',f2,'Data',accuracy_mean,'ColumnName',cnames, ...
    'RowName',rnames,'Position',[50 50 500 150]);

%in ra n,k t?i ?u và dcx cao nh?t
max_N
max_K
max_accuracy


f3 = figure('Name', 'Nhan dang','Position',[200 200 460 500]);
cnames = {'a','e','i','o', 'u'};
nameFile = {'23MTL   ','24FTL   ','25MLM','27MCM','28MVN ','29MHN','30FTN   ','32MTP ','33MHP','34MQP','35MMQ','36MAQ','37MDS','38MDS','39MTS','40MHS','41MVS','42FQT','43MNT','44MTT','45MDV'};
for iidx=1: length(nameFile) 
    nameFile1(iidx,1) = nameFile(1,iidx); 
end
rnames = {'13','26','39'};
t = uitable('Parent',f3,'Data',nhandangFinal,'ColumnName',cnames, ...
    'RowName',nameFile1,'Position',[20 20 420 461]);

toc