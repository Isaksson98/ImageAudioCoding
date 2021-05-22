function [n,x] = ihist(y,m)
%ihist - Integer bin replacement for hist.
%------------------------------------------------------------------------------
%SYNOPSIS       ihist(Y)
%	           Counts the elements of Y into integer bins and plots
%                  a bargraph over the distribution. Each column of Y will
%                  yield a separate histogram.
%
%               [N,X] = ihist(Y)
%                  Returns the number of elements N in each container and
%                  the integer vector X specifying the centers. If Y was a
%                  matrix, N will be a matrix with the same number of columns.
%
%               [N,X] = ihist(Y,[A0 A1])
%                  As above but only counts hits in the integer bins A0:A1.
%
%
%SEE ALSO       hist.
%
%------------------------------------------------------------------------------
%Harald Nautsch                        (C) 2001 Image Coding Group. LiU, SWEDEN


if nargin == 0
  error('Requires one or two input arguments.')
elseif nargin < 2,
  m = floor(min(y(:))):ceil(max(y(:)));
else
  m = round(m(1)):round(m(2));
end

if length(m) == 1
  m = 1;
end

if nargout == 0,
  hist(y,m);
else
  n = hist(y,m);
  if nargout == 2;
    x = m';
  end
end

