function [HistSpl] = CardinalSpline(lag,c_pt,s)

HistSpl = zeros(lag,length(c_pt));

%for each 1 ms timepoint, calculate the corresponding row of the glm input matrix
for i=1:lag
    nearest_c_pt_index = max(find(c_pt<i));
    nearest_c_pt_time = c_pt(nearest_c_pt_index);
    next_c_pt_time = c_pt(nearest_c_pt_index+1);
    u = (i-nearest_c_pt_time)./(next_c_pt_time-nearest_c_pt_time);
    p=[u^3 u^2 u 1]*[-s 2-s s-2 s;2*s s-3 3-2*s -s;-s 0 s 0;0 1 0 0];
    HistSpl(i,nearest_c_pt_index-1:nearest_c_pt_index+2) = p;
end

end
