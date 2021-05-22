function t=bdwht(im, M)
%bdwht - block discrete Walsh Hadamard transform of image
%------------------------------------------------------------------------------
%SYNOPSIS	t = bdwht(im, [M N])
%		  Perform blockwise Walsh Hadamard transform on image im,
%                 using blocks of size MxN. The resulting transformed
%                 image t consists of one column per block.
%
%       	t = bdwht(im, M)
%                 As above, but with blocks of size MxM
%
%
%SEE ALSO	ibdwht, bdct, ibdct
%
%------------------------------------------------------------------------------
%Harald Nautsch                        (C) 1998 Image Coding Group. LiU, SWEDEN

%RCSID          $Id: bdwht.m,v 1.1 2006/02/19 18:02:54 harna Exp $

if (nargin == 0)
  error('No input arguments.')
end

if (nargin == 1)
  error('No blocksize given.')
end

if (length(M) == 1)
  M = [M M];
end

t=had2basemx(M)*im2col(im, M, 'distinct');

