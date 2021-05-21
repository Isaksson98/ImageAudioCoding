function prediction=predictor1(y)
    % pi = xi-1
    prediction = zeros(size(y, 1),1);
    for i = 2:size(prediction, 1)
        prediction(i) = y(i-1);
    end
end