function rs = Nguong(data, ste)
i1 = 1;
i2 = 1;
sil = zeros();
stdsil = zeros();
spe = zeros();
stdspe = zeros();
for i = 1 : length(data)-1
    t1 = round(data(i)/0.025);
    t2 = round(data(i+1)/0.025);
    if(t1 == 0)
        t1 =t1 +1;
    end 
    stePerSeg = ste(t1 : t2);
    if (mod(i,2) == 0)
        spe(i2) = mean(stePerSeg);
        stdspe(i2) = std(stePerSeg);
        i2=i2+1;
    else
        sil(i1) = mean(stePerSeg);
        stdsil(i1) = std(stePerSeg);
        i1=i1+1;
    end
end
meanSil = sum(sil)/length(sil);
stdSil = sum(stdsil)/length(stdsil);
meanSpe = sum(spe)/length(spe);
stdSpe = sum(stdspe)/length(stdspe);

meanSil = abs(meanSil + stdSil);
meanSpe = abs(meanSpe - stdSpe);
rs = (meanSpe-meanSil)/2;
% if((meanSil+meanSpe)/2 < 0)
%     rs = meanSil;
% else
%     rs = abs((meanSpe-meanSil)/2);
