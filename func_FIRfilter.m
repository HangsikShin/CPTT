function result=func_FIRfilter(sig,Fs,order,f1,f2,ftype)
if(strcmp(ftype,'high'))
    Wn=[f1/(Fs/2) 1-eps];
    b=fir1(order,Wn);
elseif(strcmp(ftype,'low'))
    Wn=[eps f1/(Fs/2)];
    b=fir1(order,Wn);
elseif(strcmp(ftype,'stop'))
    Wn=[f1/(Fs/2) f2/(Fs/2)];
    b=fir1(order,Wn,'stop');
else
    Wn=[f1/(Fs/2) f2/(Fs/2)];
    b=fir1(order,Wn);   
end 
result=filtfilt(b,1,sig);