function [Histr] = Hist(lag,spike)


Histr = zeros(length(spike)-lag,lag);
for i=1:lag
   Histr(:,i) = spike(lag-i+1:end-i);
end

end

