function prediction=predictor2D_2(y)

    % pi,j = xi,j-1
    prediction = zeros(size(y, 1), size(y, 2));
    for i = 2:size(prediction, 1)
        prediction(i,1) = 128;
        for j = 2:size(prediction, 2)
           prediction(i,j) = y(i,j-1); 
        end
    end 
end