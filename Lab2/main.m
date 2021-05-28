clear;
[y, fs] = audioread('heyhey.wav');
M = audioinfo('heyhey.wav');
y1 = y(:,1);
y2 = y(:,2);
y = (y1+y2)/2;
y_diff = y1-y2;
samples = M.TotalSamples/2;
%% Parameters
blockSize = 512; %  256-2048 are typical
quantStep = 0.03;
%% Transform

C = DCT(y, blockSize);

%% 
y_DCT = C*reshape(y, blockSize,[]);

%% Quantisation
%Uniform quantization
yQuant = round(y_DCT/quantStep);

%% Re construct
output_quant = quantStep*yQuant;
output = transpose(C)*output_quant;
output = reshape(output,[],1);

%% Memoryless Huffman Coding
a = hist (yQuant(:), unique(yQuant));
p = a/length(yQuant);

L = huffman(p);
R = L;

%% Stats

SNR = snr(y, output);

L = length(a);
SI_len = L * ceil(log2(L));

R_SInf = R + SI_len / length(y);

fprintf('R:           %f\n', R*samples)
fprintf('SNR:           %f\n', SNR)
fprintf('R + sideinfo:    %f\n', R_SInf*samples)
%% Play sound
%sound(output,fs)
audiowrite('ReconstructedSignal.wav', output, fs);