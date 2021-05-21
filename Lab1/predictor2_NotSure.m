function [a1, a2]=predictor2_NotSure(y)

    acf = zeros(5,1);
    for lag = 0:4
        acf(lag+1) = corr(y(1:end - lag), y(lag + 1:end));
    end
    a1 = (acf(2)*acf(1)-acf(3)*acf(2)) / (acf(1)*acf(1)-acf(2)*acf(2));
    a2 = (acf(3)-a1*acf(2))/acf(1);
    %a2 = (acf(1)*acf(3)-acf(2)*acf(2)) / (acf(1)*acf(1)-acf(2)*acf(2));
   
end