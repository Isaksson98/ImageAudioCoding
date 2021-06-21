function [bits, bpp, psnr]=transcoder(img, blckSize, qStepLuminance, qStepChrominance, transform, ...
    srcCode, subsamplingFactor)

% This is a very simple transform coder and decoder. Copy it to your directory
% and edit it to suit your needs.
% You probably want to supply the image and coding parameters as
% arguments to the function instead of having them hardcoded.


% Read an image
im=double(imread(img))/255;
x = size(im,1);
y = size(im,2);
% What blocksize do we want?
blocksize = [blckSize blckSize];

% Quantization steps for luminance and chrominance
qy = qStepLuminance;
qc = qStepChrominance;

% Change colourspace 
imy=rgb2ycbcr(im);

bits=0;


% Somewhere to put the decoded image
imyr=zeros(size(im));


% First we code the luminance component
% Here comes the coding part
if transform == 1
    tmp = bdct(imy(:,:,1), blocksize); % DCT
elseif transform == 2
    tmp = bdwht(imy(:,:,1), blocksize); % DWHT
end

tmp = bquant(tmp, qy);             % Simple quantization
p = ihist(tmp(:));                 % Only one huffman code
bits = bits + huffman(p);          % Add the contribution from
                                   % each component
			
% Here comes the decoding part
tmp = brec(tmp, qy);               % Reconstruction
if transform == 1
    imyr(:,:,1) = ibdct(tmp, blocksize, [x y]);  % Inverse DCT
elseif transform == 2
    imyr(:,:,1) = ibdwht(tmp, blocksize, [x y]);  % Inverse DWHT
end

% Next we code the chrominance components
for c=2:3                          % Loop over the two chrominance components
  % Here comes the coding part

  tmp = imy(:,:,c);

  % If you're using chrominance subsampling, it should be done
  % here, before the transform.
  tmp = imresize(tmp, 1/subsamplingFactor);
  x = size(tmp,1);
  y = size(tmp,2);

  tmp = bdct(tmp, blocksize);      % DCT
  tmp = bquant(tmp, qc);           % Simple quantization
  p = ihist(tmp(:));               % Only one huffman code
  
  if srcCode == 1
    bits = bits + huffman(p);  % Add the contribution from each component      
  elseif srcCode == 2
      bits = bits + sum(jpgrate(tmp, blocksize));
  end
  % Here comes the decoding part
  tmp = brec(tmp, qc);            % Reconstruction
  tmp = ibdct(tmp, blocksize, [x y]);  % Inverse DCT

  % If you're using chrominance subsampling, this is where the
  % signal should be upsampled, after the inverse transform.
  tmp = imresize(tmp, subsamplingFactor);
  imyr(:,:,c) = tmp;
  
end

% Display total number of bits and bits per pixel
bits;
bpp = bits/(size(im,1)*size(im,2));

% Revert to RGB colour space again.
imr=ycbcr2rgb(imyr);

% Measure distortion and PSNR
dist = mean((im(:)-imr(:)).^2);
psnr = 10*log10(1/dist);

% Display the original image
%figure, imshow(im)
%title('Original image')

%Display the coded and decoded image
%figure, imshow(imr);
%title(sprintf('Decoded image, %5.2f bits/pixel, PSNR %5.2f dB', bpp, psnr))

