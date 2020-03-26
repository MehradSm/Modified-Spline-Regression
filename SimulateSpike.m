function [spiketrain,ytrue] = SimulateSpike(splinematrix,theta,lastknot,nsteps)

spiketrain = zeros(nsteps,1);
for i=lastknot+1:nsteps
   lambda(i) = exp(theta*[1; splinematrix'*spiketrain(i-1:-1:i-lastknot)]);
   spiketrain(i) = min(poissrnd(lambda(i)),1);
   
end

ytrue = glmval(theta',splinematrix,'log');

end

