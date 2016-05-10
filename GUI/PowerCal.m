function PowerCal = PowerCal(input)
thres = input(:,1); 
signal = input(:,2);
PowerCal = [];
jj = 0;
for ii = 1:(length(thres)-1)
    if(thres(ii)==0&&thres(ii+1)>0)
        jj = jj+1;
        sum_signal = 0;
        save(jj) = ii;
        
    elseif(thres(ii)>0&&thres(ii+1)>0)
        sum_signal = sum_signal + signal(ii);
        PowerCal(jj) = sum_signal;
    end
end
for jj = 1:length(PowerCal)
     xt = save(jj);
     yt = max(signal)+5;
     txt = [num2str(PowerCal(jj))];
     text(xt,yt,txt,'HorizontalAlignment','left');
end
PowerCal
mean(PowerCal)
