function pairEntropy = PairEntropy(x)

    pair_counting_matrix = zeros(2*128);

    for i = 1:length(x)-1
        %Use + 128 in order to get an index for neg values
        num1 = x(i)+128;
        num2 = x(i + 1)+128;
        pair_counting_matrix(num1, num2) = pair_counting_matrix(num1, num2)+1;
    end
    prob_pair = pair_counting_matrix./length(x);
    %heatmap(prob_pair);
    pairEntropy = -sum(prob_pair(:) .* log2(prob_pair(:)), 'omitnan');

end
