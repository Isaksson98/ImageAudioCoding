function pairEntropy = PairEntropyHoriz(img)

    x = size(img,1);
    y = size(img,2);
    
    pair_counting_matrix = zeros(256);

    for i = 1:x
        for j = 1:y-1
            %Use + 128 in order to get an index for neg values
            num1 = img(i,j)+1;
            num2 = img(i,j+1)+1;
            pair_counting_matrix(num1, num2) = pair_counting_matrix(num1, num2)+1;
        end
    end
    prob_pair = pair_counting_matrix./(x*y);
    pairEntropy = -sum(prob_pair(:) .* log2(prob_pair(:)), 'omitnan');

end
