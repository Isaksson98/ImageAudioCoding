clear;
%% Load data
[y1,Fs1] = audioread('hey04_8bit.wav');
[y2,Fs2] = audioread('nuit04_8bit.wav');
[y3,Fs3] = audioread('speech.wav');

%Scale 
y1=y1*128;
y2=y2*128;
y3=y3*128;

%% Entropy

entropy_y1 = Entropy(y1); %7.1638
entropy_y2 = Entropy(y2); %6.8060
entropy_y3 = Entropy(y3); %5.4340

%% Pair Entropy

pair_entropy_y1 = PairEntropy(y1); %11.4363
pair_entropy_y2 = PairEntropy(y2); %9.5281
pair_entropy_y3 = PairEntropy(y3); %8.7231


%% Conditional Entropy
conditional_entropy_y1 = pair_entropy_y1 - entropy_y1; %4.2725
conditional_entropy_y2 = pair_entropy_y2 - entropy_y2; %2.7221
conditional_entropy_y3 = pair_entropy_y3 - entropy_y3; %3.2891

%% Memoryless Huffman Coding
a1 = hist (y1, unique(y1));
p1 = a1/length(y1);

a2 = hist (y2, unique(y2));
p2 = a2/length(y2);

a3 = hist (y3, unique(y3));
p3 = a3/length(y3);

expected_codeword_length_1 = huffman(p1); %7.1968
expected_codeword_length_2 = huffman(p2); %6.8273
expected_codeword_length_3 = huffman(p3); %5.4512

R1 = expected_codeword_length_1/length(a1); %0.0300
R2 = expected_codeword_length_2/length(a2); %0.0274
R3 = expected_codeword_length_3/length(a3); %0.0235

%% Simple predictive coding

pred1_y1 = predictor1(y1);
pred1_y2 = predictor1(y2);
pred1_y3 = predictor1(y3);
%sound(pred1_y1/128, Fs1)

pred2_y1 = predictor2(y1);
pred2_y2 = predictor2(y2);
pred2_y3 = predictor2(y3);
%sound(pred2_y1/128, Fs1)


%% Memoryless Huffman Coding of prediction error
a1 = hist (pred2_y1, unique(pred2_y1));
p1 = a1/length(pred2_y1);

a2 = hist (pred2_y2, unique(pred2_y2));
p2 = a2/length(pred2_y2);

a3 = hist (pred2_y3, unique(pred2_y3));
p3 = a3/length(pred2_y3);

expected_codeword_length_1 = huffman(p1); 
expected_codeword_length_2 = huffman(p2); 
expected_codeword_length_3 = huffman(p3); 

R1 = expected_codeword_length_1/length(a1);
R2 = expected_codeword_length_2/length(a2);
R3 = expected_codeword_length_3/length(a3);



%% Simple predictive coding - This is probably wrong???

a1 = predictor1_NotSure(y1); %0.9820
a2 = predictor1_NotSure(y2); %0.9981
a3 = predictor1_NotSure(y3); %0.9507


[a1, a2] = predictor2_NotSure(y1); %1.2969, -0.3206
[a1, a2] = predictor2_NotSure(y2); %1.8431, -0.8466
[a1, a2] = predictor2_NotSure(y3); %1.7716, -0.8636



