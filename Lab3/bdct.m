function t=bdct(im, M)
%bdct - block dct of image
%------------------------------------------------------------------------------
%SYNOPSIS	t = bdct(im, [M N])
%		  Perform blockwise dct on image im (a matrix),
%                 using blocks of size MxN. The resulting transformed
%                 image t consists of one column per block.
%
%       	t = bdct(im, M)
%                 As above, but with blocks of size MxM
%
%
%SEE ALSO	ibdct
%
%------------------------------------------------------------------------------
%Harald Nautsch                        (C) 1998 Image Coding Group. LiU, SWEDEN

%RCSID          $Id: bdct.m,v 1.2 2006/02/20 07:18:13 harna Exp $

if (nargin == 0)
  error('No input arguments.')
end

if (nargin == 1)
  error('No blocksize given.')
end

if (length(M) == 1)
  M = [M M];
end

t=dct2basemx(M)*im2col(im, M, 'distinct');

