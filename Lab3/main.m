
img1 = 'image1.png';
img2 = 'image2.png';
img3 = 'image3.png';
img4 = 'image4.png';
img5 = 'image5.png';
img6 = 'image6.png';

blockSize = 8;
qLuminance = 0.1;
qChrominance = 0.1;
transform = 1; %DCT: 1, DWHT: 2

%% What source coding method gives the smallest rates?

[bits1, bpp1, psnr1] = transcoder(img1, blockSize, qLuminance, qChrominance, 1, 1, 1);
[bits2, bpp2, psnr2] = transcoder(img1, blockSize, qLuminance, qChrominance, 1, 2, 1);

bits1>bits2

%% What choice of transform (DCT or DWHT) gives the best results?

[bits1, bpp1, psnr1] = transcoder(img1, blockSize, qLuminance, qChrominance, 1, 1, 1);
[bits2, bpp2, psnr2] = transcoder(img1, blockSize, qLuminance, qChrominance, 2, 1, 1);

%% What choice of block size gives the best results?
block_list = [2 4 8 16 32 64];
n = length(block_list);
j = 0;
bits = zeros(n,1);
bpp = zeros(n,1);
psnr = zeros(n,1);

for i =1:n
    j = j+1;
    [bits(j), bpp(j), psnr(j)] = transcoder(img1,  block_list(i), qLuminance, qChrominance, 1, 1, 1);
end

plot(block_list, psnr,'-o')
ylabel('psnr')
xlabel('block size')

%% What quantization method gives the best results, using the same stepsize for all transform components or using different stepsizes for different transform components?
 
QL=repmat(1:blockSize, blockSize, 1); QL=(QL+QL'-9)/blockSize;
%A quantization matrix can then be constructed in the following way.
k1=0.1; k2=0.3;
Q2=k1*(1+k2*QL);

[bits, bpp, psnr1] = transcoder(img1, blockSize, qLuminance, qChrominance, 1, 1, 1);
[bits, bpp, psnr2] = transcoder(img1, blockSize, Q2, Q2, 1, 1, 1);

%% How does chrominance subsampling affect the results?
[bits1, bpp1, psnr1] = transcoder(img1, blockSize, qLuminance, qChrominance, 1, 1, 0.5); %35.0402, 35.7342

%% What is the lowest rate (in bits per pixel) that gives coded images that are indistinguishable from the original image at normal viewing distance?
blockSize = 16;
qLuminance = 0.13;
qChrominance = 0.13;
[bits1, bpp1, psnr1] = transcoder(img1, blockSize, qLuminance, qChrominance, 1, 1, 1);

bpp1

%% What is the lowest rate that gives an acceptable image quality?

blockSize = 16;
qLuminance = 0.33;
qChrominance = 0.33;
[bits1, bpp1, psnr1] = transcoder(img1, blockSize, qLuminance, qChrominance, 1, 1, 1);

bpp1

