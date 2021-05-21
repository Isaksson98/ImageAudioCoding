function prediction=predictor2(y)
    %2*xi-1 - xi-2
    prediction = zeros(size(y, 1),1);
    for i = 3:size(prediction, 1)
        prediction(i) = 2*y(i-1)-y(i-2);
    end
end