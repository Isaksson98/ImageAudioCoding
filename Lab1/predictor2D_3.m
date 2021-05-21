function prediction=predictor2D_3(y)

    % pi,j = xi-1,j + xi,j-1 - xi-1,j-1
    prediction = zeros(size(y, 1), size(y, 2));
    for i = 2:size(prediction, 1)
        for j = 2:size(prediction, 2)
            prediction(1,j) = 128;
            prediction(i,j) = y(i-1,j) + y(i,j-1) - y(i-1,j-1); 
        end
    end
    
end