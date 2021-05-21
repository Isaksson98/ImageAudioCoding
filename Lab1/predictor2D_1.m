function prediction=predictor2D_1(y)

    % pi,j = xi-1,j
    prediction = zeros(size(y, 1), size(y, 2));
    for i = 2:size(prediction, 1)
        prediction(i,1) = 128;
        for j = 2:size(prediction, 2)
            prediction(i,j) = y(i-1,j);
        end
    end
    
end