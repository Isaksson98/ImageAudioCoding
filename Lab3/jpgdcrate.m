function r = jpgdcrate(Y, C)
%jpgdcrate - Estimate DC coefficient bitcost using JPEG-style entropy coding
%------------------------------------------------------------------------------
%SYNOPSIS       R = jpgdcrate(Y, C)
%                  Y is a vector of quantized transform DC values (integers).
%                  C is vector of codeword lengths for different magnitudes.
%                  The return value is a vector of codeword lengths.
%
%               R = jpgdcrate(Y, 0)
%                  The huffman code for the magnitudes is optimized for the
%                  the data in Y.
%
%               R = jpgdcrate(Y)
%                  In this case C defaults to the codeword-lengths of 
%                  table K.3 from the JPEG standard document.
%
%SEE ALSO       runlength, jpgrate
%
%
%------------------------------------------------------------------------------
%Harald Nautsch                        (C) 1998 Image Coding Group. LiU, SWEDEN

%RCSID          $Id: jpgdcrate.m,v 1.5 2005/03/08 09:51:10 harna Exp $

if nargin<2
  C=[2 3 3 3 3 3 4 5 6 7 8 9];
end

magn=ceil(log2(abs(Y)+1));

if C==0
  C=huffcode(hist(magn,0:max(magn)))';
end

r=C(magn+1)+magn;
