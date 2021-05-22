function a = zigzag(m,n)
%zigzag - Generate a zig-zag matrix
%------------------------------------------------------------------------------
%SYNOPSIS       A = zigzag(M,N)
%                  Generate a N x M matrix A containing all integers 1..M*N
%                  in a zig-zag scan pattern.
%
%               A = zigzag([M,N])
%                  As above.
%
%EXAMPLES	>> zigzag(4,4)
%
%               ans = 
%                    1     2     6     7
%                    3     5     8    13
%                    4     9    12    14
%                   10    11    15    16
%
%               To get an index vector P suitable for permuting the result of
%               a columnbased m x n DCT transform (see dct2basemx) one can do
%               the following:
%
%               >> [dummy, P] = sort(reshape(zigzag(m,n),m*n,1))
%
%               and to reorder the columns of the DCT:
%
%               >> t = dct2basemx(m,n);
%               >> t = t(P,:);
%               
%
%IMPLEMENTATION Slow m-file implementation...
%
%SEE ALSO       dct2basemx, runlength.
%
%------------------------------------------------------------------------------
%Jonas Svanberg                        (C) 1998 Image Coding Group. LiU, SWEDEN

%RCSID          $Id: zigzag.m,v 1.4 2006/02/19 18:06:53 harna Exp $

if nargin == 1
  n = m(2);
  m = m(1);
end

s = 0; % 0 -> right, 1 -> left
r = 1; % row
c = 1; % col
a = zeros(m,n);

for i=1:n*m,
  a(r,c) = i;
  if s==0,
    if c==n,
      r = r+1;
      s = 1;
    elseif r==1,
      c = c+1;
      s = 1;
    else
      c = c+1;
      r = r-1;
    end
  else
    if r==m,
      c = c+1;
      s = 0;
    elseif c==1,
      r = r+1;
      s = 0;
    else
      c = c-1;
      r = r+1;
    end
  end
end
