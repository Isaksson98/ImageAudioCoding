function a=predictor1_NotSure(y)

    acf = zeros(5,1);
    for lag = 0:4
        acf(lag+1) = corr(y(1:end - lag), y(lag + 1:end));
    end
    a = acf(2)/acf(1);
    
end