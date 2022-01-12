function [f0mean,f0std]    = meanAndStd(f0, N_frame)
            a=0;
            b=0;
            sum1=0;
            sum2=0;
            for i=1:N_frame
                if f0(i)==0
                 continue;
                else
                    a=a+1;
                    arr(a)=f0(i);
                   sum1=sum1+f0(i);     
                end
            end
            %f0mean=sum1/a;
            f0mean=mean(arr);
             f0std=std(arr);  
            for i=1:N_frame
                 if f0(i)==0
                 continue;
                 else
                    b=b+1;
                    sum2=sum2+(f0(i)-f0mean)*(f0(i)-f0mean);
                 end
            end
            %f0std=sqrt((sum2)/(b));  
            