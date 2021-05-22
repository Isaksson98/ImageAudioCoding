function r = jpgrate(Y, M)
%jpgrate - Estimate bitcost using JPEG-style entropy coding
%------------------------------------------------------------------------------
%SYNOPSIS       R = jpgrate(Y, [M N])
%		   Y should contain quantized transform data (integers) and
%                  be organized such that image blocks correspond to columns.
%                  The order of the transform components is supposed to be
%                  corresponding to the dct2basemx() operation. [M N] is
%                  the blocksize ([8 8] for a 'real' JPEG coder.)
%                  The returned value R is a row vector containing the number
%                  of bits needed to code each transform block.
%
%IMPLEMENTATION jpgrate uses the zigzag() function to reorganize transform
%               components in a way suitable for runlength(). The DC component
%               is however separately coded using a differential scheme.
%
%SEE ALSO       dct2basemx, runlength, jpgdcrate
%
%REFERENCES     [1] JPEG - Still Image Data Copression Standard
%                   William B. Pennebaker, Joan L. Mitchell
%                   ISBN 0-442-01272-1
%
%------------------------------------------------------------------------------
%Jonas Svanberg, Harald Nautsch        (C) 1998 Image Coding Group. LiU, SWEDEN

%RCSID          $Id: jpgrate.m,v 1.4 2006/02/19 18:06:58 harna Exp $

% Missing: Sanity check on M

[dummy, P] = sort(reshape(zigzag(M),prod(M),1));
Y = Y(P, :);

r = jpgdcrate([Y(1,1) diff(Y(1,:))]) + runlength(Y(2:end,:), 0);
