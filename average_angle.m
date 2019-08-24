function [theta] = average_angle(subspaces,n)
    sum = 0;
    count = 0;
    for i=1:n
        for j=i+1:n
            count = count + 1;
            cur_angle = subspace(subspaces{i},subspaces{j});
            sum = sum + cur_angle;
        end
    end
    theta = sum /count;
    
end