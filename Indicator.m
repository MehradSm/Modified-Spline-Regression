function [ind_data] = Indicator(data,NumInd,eps)

ind_data = zeros(size(data,1),NumInd);
data_prt = linspace(min(data),max(data)+eps,NumInd);

for i=1:NumInd-1
   ind_data(:,i) = [data>=data_prt(i) & data<data_prt(i+1)];   
end


end

