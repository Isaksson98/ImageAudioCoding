function im=ibdwht(t, bsize, imsize)
%ibdwht - inverse block discrete Walsh Hadamard transform of image
%------------------------------------------------------------------------------
%SYNOPSIS	im = ibht(t, [M N], [MM NN])
%		  Perform blockwise inverse Walsh Hadamard transform on the
%                 transform image t, using blocks of size MxN. Each
%                 column in t is considered as a transform block and
%                 the resulting image will have size MMxNN.
%
%
%SEE ALSO	bdwht, bdct, ibdct
%
%------------------------------------------------------------------------------
%Harald Nautsch                        (C) 1998 Image Coding Group. LiU, SWEDEN

%RCSID          $Id: ibdwht.m,v 1.1 2006/02/19 18:03:00 harna Exp $

if (nargin == 0)
  error('No input arguments.')
end

if (nargin < 3)
  error('Wrong number of input arguments.')
end

if (length(bsize) == 1)
  bsize = [bsize bsize];
end

if (length(imsize) == 1)
  imsize = [imsize imsize];
end

if (prod(bsize) ~= size(t, 1))
  error('The blocksize does not fit the transform image.')
end

im=col2im(had2basemx(bsize)'*t, bsize, imsize, 'distinct');

