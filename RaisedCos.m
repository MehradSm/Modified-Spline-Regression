function [bases,phi] = RaisedCos(t,a,b,nbases,cntrspace)


input_cos = a*log(t + b);
phi_srt = min(input_cos);
phi_end = max(input_cos);
phi = phi_srt:cntrspace:phi_end;

bases = zeros(length(t),nbases);
for i = 1:nbases
  bases(:,i) = ( cos( ...
    max(-pi, min(pi,(input_cos - phi(i)) )) ) ...
    + 1) / 2;
end

end

