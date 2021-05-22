function tq=bquant(t, qmtx)
%bquant - Do block quantization of a transformed image
%------------------------------------------------------------------------------
%SYNOPSIS	tq = bquant(t, qmtx)
%		   where
%
%		     t    : image to quantize
%		     qmtx : Either a scalar, or a column vector of
%                           quantization values of the same length
%                           as the number rows in t, i.e. one quantizer
%                           for each transform component.
%                           Each value is the step length for a uniform
%                           quantizer.
%                           
%
%
%SEE ALSO	brec
%
%RCSID          $Id: bquant.m,v 1.2 1998/11/22 14:15:34 harna Exp $
%------------------------------------------------------------------------------
%Harald Nautsch                        (C) 1998 Image Coding Group. LiU, SWEDEN

if (nargin ~= 2)
  error('Wrong number of input arguments.')
end

qmtx = qmtx(:);  % Just for convenience

if length(qmtx)>1 & size(t,1) ~= length(qmtx)
  error('Wrong number of quantization values.')
end

if length(qmtx) == 1
  tq=round(t/qmtx);   % Only one quantization value
else
  tq=round(t./(qmtx*ones(1, size(t,2))));
end


