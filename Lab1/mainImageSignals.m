clear;
%% Load data
img1 = double( imread('baboon.png') );
img2 = double( imread('boat.png') );
img3 = double( imread('woodgrain.png') );

%% Entropy

entropy_img1 = Entropy2D(img1); %7.4745
entropy_img2 = Entropy2D(img2); %7.1238
entropy_img3 = Entropy2D(img3); %6.3562

%% Pair Entropy

pair_entropy_vert_img1 = PairEntropyVert(img1); %13.9964
pair_entropy_vert_img2 = PairEntropyVert(img2); %11.7924
pair_entropy_vert_img3 = PairEntropyVert(img3); %10.5416

pair_entropy_horiz_img1 = PairEntropyHoriz(img1); %13.7325
pair_entropy_horiz_img2 = PairEntropyHoriz(img2); %12.0285
pair_entropy_horiz_img3 = PairEntropyHoriz(img3); %12.1448


%% Conditional Entropy
conditional_entropy_vert_img1 = pair_entropy_vert_img1 - entropy_img1; %6.5219
conditional_entropy_vert_img2 = pair_entropy_vert_img2 - entropy_img2; %4.6686
conditional_entropy_vert_img3 = pair_entropy_vert_img3 - entropy_img3; %4.1854

conditional_entropy_horiz_img1 = pair_entropy_horiz_img1 - entropy_img1; %6.2580
conditional_entropy_horiz_img2 = pair_entropy_horiz_img2 - entropy_img2; %4.9047
conditional_entropy_horiz_img3 = pair_entropy_horiz_img3 - entropy_img3; %5.7886

%% Memoryless Huffman Coding

x = size(img1,1);
y = size(img1,2);
count1 = zeros(256,1); %0-255
count2 = zeros(256,1); %0-255
count3 = zeros(256,1); %0-255

for i = 1:x
    for j = 1:y
       count1(img1(i,j)+1) = count1(img1(i,j)+1) + 1; %increment
       count2(img2(i,j)+1) = count2(img2(i,j)+1) + 1; %increment
       count3(img3(i,j)+1) = count3(img3(i,j)+1) + 1; %increment
    end
end

p1 = count1./ (x*y);
p2 = count2./ (x*y);
p3 = count3./ (x*y);


expected_codeword_length_1 = huffman(p1); %7.5171
expected_codeword_length_2 = huffman(p2); %7.1468
expected_codeword_length_3 = huffman(p3); %6.3914

R1 = expected_codeword_length_1; %7.5171
R2 = expected_codeword_length_2; %7.1468
R3 = expected_codeword_length_3; %6.3914


%% Simple predictive coding

pred1_img1 = predictor2D_1(img1);
pred1_img2 = predictor2D_1(img2);
pred1_img3 = predictor2D_1(img3);
%figure(1)
%image(pred1_img2);

pred2_img1 = predictor2D_2(img1);
pred2_img2 = predictor2D_2(img2);
pred2_img3 = predictor2D_2(img3);
%figure(2)
%image(pred2_img2);

pred3_img1 = predictor2D_3(img1);
pred3_img2 = predictor2D_3(img2);
pred3_img3 = predictor2D_3(img3);
%figure(3)
%image(pred3_img2);

%% Memoryless Huffman Coding of prediction error, predictor 1

x = size(img1,1);
y = size(img1,2);
count1 = zeros(512,1); %-255 -> +255
count2 = zeros(512,1); %-255 -> +255
count3 = zeros(512,1); %-255 -> +255

err1 = img1 - pred1_img1;
err2 = img2 - pred1_img2;
err3 = img3 - pred1_img3;


for i = 1:x
    for j = 1:y
       count1(err1(i,j)+1+255) = count1(err1(i,j)+1+255) + 1; %increment
       count2(err2(i,j)+1+255) = count2(err2(i,j)+1+255) + 1; %increment
       count3(err3(i,j)+1+255) = count3(err3(i,j)+1+255) + 1; %increment
    end
end

p1 = count1./ (x*y);
p2 = count2./ (x*y);
p3 = count3./ (x*y);


expected_codeword_length_1 = huffman(p1); 
expected_codeword_length_2 = huffman(p2); 
expected_codeword_length_3 = huffman(p3); 

R1 = expected_codeword_length_1 %6.9362
R2 = expected_codeword_length_2 %5.0295
R3 = expected_codeword_length_3 %4.4877

%% Memoryless Huffman Coding of prediction error, predictor 2

x = size(img1,1);
y = size(img1,2);
count1 = zeros(512,1); %-255 -> +255
count2 = zeros(512,1); %-255 -> +255
count3 = zeros(512,1); %-255 -> +255

err1 = img1 - pred2_img1;
err2 = img2 - pred2_img2;
err3 = img3 - pred2_img3;


for i = 1:x
    for j = 1:y
       count1(err1(i,j)+1+255) = count1(err1(i,j)+1+255) + 1; %increment
       count2(err2(i,j)+1+255) = count2(err2(i,j)+1+255) + 1; %increment
       count3(err3(i,j)+1+255) = count3(err3(i,j)+1+255) + 1; %increment
    end
end

p1 = count1./ (x*y);
p2 = count2./ (x*y);
p3 = count3./ (x*y);


expected_codeword_length_1 = huffman(p1); 
expected_codeword_length_2 = huffman(p2); 
expected_codeword_length_3 = huffman(p3); 

R1 = expected_codeword_length_1; %6.5944
R2 = expected_codeword_length_2; %5.2640
R3 = expected_codeword_length_3; %6.4169

%% Memoryless Huffman Coding of prediction error, predictor 3

x = size(img1,1);
y = size(img1,2);
count1 = zeros(512,1); %-255 -> +255
count2 = zeros(512,1); %-255 -> +255
count3 = zeros(512,1); %-255 -> +255

err1 = img1 - pred3_img1;
err2 = img2 - pred3_img2;
err3 = img3 - pred3_img3;


for i = 1:x
    for j = 1:y
       count1(err1(i,j)+1+255) = count1(err1(i,j)+1+255) + 1; %increment
       count2(err2(i,j)+1+255) = count2(err2(i,j)+1+255) + 1; %increment
       count3(err3(i,j)+1+255) = count3(err3(i,j)+1+255) + 1; %increment
    end
end

p1 = count1./ (x*y);
p2 = count2./ (x*y);
p3 = count3./ (x*y);

expected_codeword_length_1 = huffman(p1); 
expected_codeword_length_2 = huffman(p2); 
expected_codeword_length_3 = huffman(p3); 

R1 = expected_codeword_length_1; %6.8858
R2 = expected_codeword_length_2; %4.9300
R3 = expected_codeword_length_3; %4.7097
