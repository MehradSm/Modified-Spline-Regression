function [HistSpl] = ModifiedCardinalSpline(lag,c_pt,s)

HistSpl = zeros(lag,length(c_pt));
%for each 1 ms timepoint, calculate the corresponding row of the glm input matrix
for i=1:lag
    nearest_c_pt_index = max(find(c_pt<i));
    nearest_c_pt_time = c_pt(nearest_c_pt_index);
    next_c_pt_time = c_pt(nearest_c_pt_index+1);
    % Compute the fractional distance between timepoint i and the nearest knot
    u = (i-nearest_c_pt_time)./(next_c_pt_time-nearest_c_pt_time);
    lb = (c_pt(3) - c_pt(1))/(c_pt(2)-c_pt(1));
    le = (c_pt(end) - c_pt(end-2))/(c_pt(end) - c_pt(end-1));
    % Beginning knot 
    if nearest_c_pt_time==c_pt(1) 
           p=[u^3 u^2 u 1]*[2-(s/lb) -2 s/lb;(s/lb)-3 3 -s/lb;0 0 0;1 0 0];
           HistSpl(i,nearest_c_pt_index:nearest_c_pt_index+2) = p; 
    % End knot
    elseif nearest_c_pt_time==c_pt(end-1) 
           p=[u^3 u^2 u 1]*[-s/le 2 -2+(s/le);2*s/le -3 3-(2*s/le);-s/le 0 s/le;0 1 0];
           HistSpl(i,nearest_c_pt_index-1:nearest_c_pt_index+1) = p;  
    % Interior knots
    else
           privious_c_pt = c_pt(nearest_c_pt_index-1);
           next2 = c_pt(nearest_c_pt_index+2);
           l1 = next_c_pt_time - privious_c_pt;
           l2 = next2 - nearest_c_pt_time;
           p=[u^3 u^2 u 1]*[-s/l1 2-(s/l2) (s/l1)-2 s/l2;2*s/l1 (s/l2)-3 3-2*(s/l1) -s/l2;-s/l1 0 s/l1 0;0 1 0 0];
           HistSpl(i,nearest_c_pt_index-1:nearest_c_pt_index+2) = p; 
    end
end

end


