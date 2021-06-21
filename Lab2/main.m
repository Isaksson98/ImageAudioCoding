clear;
[y, fs] = audioread('heyhey.wav');
M = audioinfo('heyhey.wav');
y1 = y(:,1);
y2 = y(:,2);
%y1 = (y1+y2)/2;
%y_diff = y1-y2;
%samples = M.TotalSamples/2;
%% Parameters
blockSize = 512; % 256-2048 are typical
quantStep = 0.018;
%% Transform

C1 = DCT(y1, blockSize);
C2 = DCT(y2, blockSize);

%% 
y1_DCT = C1*reshape(y1, blockSize,[]);
y2_DCT = C2*reshape(y2, blockSize,[]);

%% Quantisation
%Uniform quantization
y1Quant = round(y1_DCT/quantStep);
y2Quant = round(y2_DCT/quantStep);

%% Re construct
output_quant1 = quantStep*y1Quant;
output1 = transpose(C1)*output_quant1;
output1 = reshape(output1,[],1);

%Difference
output_quant2 = quantStep*y2Quant;
output2 = transpose(C2)*output_quant2;
output2 = reshape(output2,[],1);

%% Memoryless Huffman Coding
a = hist (y1Quant(:), unique(y1Quant));
p = a/sum(a);

L1 = huffman(p);
R1 = L1;


a = hist (y2Quant(:), unique(y2Quant));
p = a/sum(a);

L2 = huffman(p);
R2 = L2;

%% Stats
SNR = snr_stereo(y1, output1, y2, output2);

L = length(a);
SI_len = L * ceil(log2(L));
side_info = SI_len / length(y1);

R_stereo = R1+R2;
R_SInf = R_stereo + side_info;

fprintf('\nOUTPUT:\n')
fprintf('R_stereo:       %f\n', R_stereo*fs/1000)
fprintf('SNR:            %f\n', SNR)
fprintf('R + sideinfo:   %f\n', R_SInf*fs/1000)
%% Play sound
%sound(output,fs)
%audiowrite('ReconstructedSignal.wav', output1, fs);