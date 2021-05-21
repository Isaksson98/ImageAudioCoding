function entropy = Entropy2D(img)

    x = size(img,1);
    y = size(img,2);
    count = zeros(256,1); %0-255

    %Looping through all pixels in the given image
    for i = 1:x
        for j = 1:y
            count(img(i,j)+1) = count(img(i,j)+1) + 1; %increment
        end
    end

    p = count./ (x*y);
    entropy = -sum(p .* log2(p), 'omitnan');

end
