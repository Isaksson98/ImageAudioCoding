function t=brec(tq, qmtx)
%brec - Do block inverse quantization of a transformed image
%------------------------------------------------------------------------------
%SYNOPSIS	t = brec(tq, qmtx)
%		   where
%
%		     tq   : quantized image to reconstruct
%		     qmtx : Either a scalar or a column vector of
%                           quantization values. Each value is the
%                           step length of a uniform quantizer.
%
%
%SEE ALSO	bquant
%
%RCSID          $Id: brec.m,v 1.1 1998/11/22 11:32:13 harna Exp $
%------------------------------------------------------------------------------
%Harald Nautsch                        (C) 1998 Image Coding Group. LiU, SWEDEN

if (nargin ~= 2)
  error('Wrong number of input arguments.')
end

qmtx = qmtx(:);  % Just for convenience

if length(qmtx)>1 & size(tq,1) ~= length(qmtx)
  error('Wrong number of quantization values.')
end

if length(qmtx) == 1
  t=tq*qmtx;   % Only one quantization value
else
  t=tq.*(qmtx*ones(1, size(tq,2)));
end


