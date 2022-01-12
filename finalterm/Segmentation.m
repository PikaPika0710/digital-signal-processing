function rs = Segmentation(ste, threshold)
%testSilence = 0;
testSpeech = 0;
time = zeros();
rs = zeros();
rs(1) = 0;
index=2;
%Check if silence seg > 300ms
for i= 1: length(ste)
    if ste(i) > threshold
        if testSpeech~=1
                time(index)=(i-1)*0.025;
                testSpeech=1;
                index=index+1;            
        end
    else
        if testSpeech==1
            if (ste(i) < threshold)
                time(index)=(i-1)*0.025;
                testSpeech=0;
                index=index+1;
            end
        end
    end
    if i==length(ste)
        time(index)=i*0.025;
    end
end
j = 1;
i = 1;
for k= 1: length(time)/2
   if (time(i+1)-time(i) > 0.3)
       rs(j) = time(i);
       j = j+1;
       rs(j) = time(i+1);
       j = j+1;
   end
       i = i + 2;
end