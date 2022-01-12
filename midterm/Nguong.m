function rs = Nguong(phoneF1, ste)
%phoneF1=[0.00, 0.53, 2.75, 3.23];
i1 = 1;
i2 = 1;
sil = zeros();
stdsil = zeros();
spe = zeros();
stdspe = zeros();
for i = 1 : length(phoneF1)-1
    t1 = round(phoneF1(i)/0.025);
    t2 = round(phoneF1(i+1)/0.025);
    if(t1 == 0)
        t1 =t1 +1;
    end 
    stePerSeg = ste(t1 : t2);
    if (i==1 || i==length(phoneF1)-1)
        sil(i1) = mean(stePerSeg);
        stdsil(i1) = std(stePerSeg);
        i1=i1+1;
    else
        spe(i2) = mean(stePerSeg);
        stdspe(i2) = std(stePerSeg);
        i2=i2+1;
    end
end
meanSil = sum(sil)/length(sil);
stdSil = sum(stdsil)/length(stdsil);
meanSpe = sum(spe)/length(spe);
stdSpe = sum(stdspe)/length(stdspe);
if(meanSil < meanSpe)
    meanSil = meanSil + stdSil;
    meanSpe = meanSpe - stdSpe;
else
    meanSil = meanSil - stdSil;
    meanSpe = meanSpe + stdSpe;
end
if((meanSil+meanSpe)/2 < 0)
    rs = meanSil;
else
    rs = (meanSil+meanSpe)/2;
end