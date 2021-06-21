
img1 = 'image1.png';
img2 = 'image2.png';
img3 = 'image3.png';
img4 = 'image4.png';
img5 = 'image5.png';
img6 = 'image6.png';
img = img1;

blockSize = 8;
qLuminance = 0.1;
qChrominance = 0.1;
q_list = [0.01 0.015 0.02 0.1 0.25 0.3 0.35 0.4];
transform = 1; %DCT: 1, DWHT: 2

%% What source coding method gives the smallest rates?

n = length(q_list);

bits1 = zeros(n,1);
bpp1 = zeros(n,1);
psnr1 = zeros(n,1);

bits2 = zeros(n,1);
bpp2 = zeros(n,1);
psnr2 = zeros(n,1);

for i =1:n
    [bits1(i), bpp1(i), psnr1(i)] = transcoder(img, blockSize, q_list(i), q_list(i), 1, 1, 1);
    [bits2(i), bpp2(i), psnr2(i)] = transcoder(img, blockSize, q_list(i), q_list(i), 1, 2, 1);
end
figure(1)
plot(bpp1, psnr1,'-o')
hold on 
plot(bpp2, psnr2,'-o')
hold off
ylabel('PSNR [dB]')
xlabel('Datatakt [bitar/pixel]')
legend('huffman', 'jpgrate')

%bits1>bits2

%% What choice of transform (DCT or DWHT) gives the best results?

n = length(q_list);

bits1 = zeros(n,1);
bpp1 = zeros(n,1);
psnr1 = zeros(n,1);

bits2 = zeros(n,1);
bpp2 = zeros(n,1);
psnr2 = zeros(n,1);

for i =1:n
    [bits1(i), bpp1(i), psnr1(i)] = transcoder(img, blockSize, q_list(i), q_list(i), 1, 1, 1);
    [bits2(i), bpp2(i), psnr2(i)] = transcoder(img, blockSize, q_list(i), q_list(i), 2, 1, 1);
end

figure(2)
plot(bpp1, psnr1,'-o')
hold on 
plot(bpp2, psnr2,'-o')
hold off
ylabel('PSNR [dB]')
xlabel('Datatakt [bitar/pixel]')
legend('DCT', 'DWHT')
%% What choice of block size gives the best results?
block_list = [2 4 8 16 32 64];
n = length(block_list);

m = length(q_list);

bits = zeros(n);
bpp = zeros(n);
psnr = zeros(n);

figure(3)
for i =1:n
    for j =1:m
        [bits(i,j), bpp(i,j), psnr(i,j)] = transcoder(img, block_list(i), q_list(j), q_list(j), 1, 1, 1);
    end
    
    plot(bpp(i,:), psnr(i,:),'-x')
    hold on 
end

ylabel('PSNR [dB]')
xlabel('Datatakt [bitar/pixel]')
legend('2','4','8','16','32','64')


%% What quantization method gives the best results, using the same stepsize for all transform components or using different stepsizes for different transform components?

block_list = [2 4 8 16 32 64];
n = length(block_list);

bits1 = zeros(n,1);
bpp1 = zeros(n,1);
psnr1 = zeros(n,1);

bits2 = zeros(n,1);
bpp2 = zeros(n,1);
psnr2 = zeros(n,1);
k1_list = [0.01 0.015 0.02 0.03 0.05 0.27 0.3];
k2_list = 3*k1_list;

for i =1:n

    QL=repmat(1:blockSize, blockSize, 1);
    QL=(QL+QL'-blockSize-1)/blockSize;
    %A quantization matrix can then be constructed in the following way.
    k1=k1_list(i); k2=k2_list(i);
    Q2=k1*(1+k2*QL);

    [bits1(i), bpp1(i), psnr1(i)] = transcoder(img, blockSize, q_list(i), q_list(i), 1, 2, 1);
    [bits2(i), bpp2(i), psnr2(i)] = transcoder(img, blockSize, Q2, Q2, 1, 2, 1);
end
bpp1
plot(bpp1, psnr1,'-o')
hold on 
plot(bpp2, psnr2,'-o')
hold off
ylabel('PSNR [dB]')
xlabel('Datatakt [bitar/pixel]')
legend('Same', 'Different')
%% How does chrominance subsampling affect the results?
subsamplingFactors = [0.1 0.2 0.4 0.5 0.8 1];
n = length(subsamplingFactors);
bits = zeros(n,1);
bpp = zeros(n,1);
psnr = zeros(n,1);

for i =1:n
    [bits(i), bpp(i), psnr(i)] = transcoder(img, blockSize, qLuminance, qChrominance, 1, 1, subsamplingFactors(i)); %35.0402, 35.7342
end
figure(1)
plot(bpp, psnr)
ylabel('PSNR [dB]')
xlabel('Datatakt [bitar/pixel]')
figure(2)
plot(subsamplingFactors, psnr)
ylabel('PSNR [dB]')
xlabel('subsamplingFactors')

%% What is the lowest rate (in bits per pixel) that gives coded images that are indistinguishable from the original image at normal viewing distance?
blockSize = 16;
qLuminance = 0.13;
qChrominance = 0.13;
[bits1, bpp1, psnr1] = transcoder(img, blockSize, qLuminance, qChrominance, 1, 2, 1);

bpp1

%% What is the lowest rate that gives an acceptable image quality?

blockSize = 16;
qLuminance = 0.33;
qChrominance = 0.33;
[bits1, bpp1, psnr1] = transcoder(img, blockSize, qLuminance, qChrominance, 1, 2, 1);

bpp1

