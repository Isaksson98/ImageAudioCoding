function t = had2basemx(m, n)
%had2basemx - Make a 2D Hadamard transform matrix
%------------------------------------------------------------------------------
%SYNOPSIS       T = had2basemx(M, N)
%                 T will be the MN-by-MN orthogonal 2-dimensional hadamard base
%                 matrix suitable for transforming M-by-N blocks represented
%                 as columnvectors. 
%                 
%
%               T = had2basemx(B)
%                 As above with B=[M N].
%
%COMMENT        The baseblocks are not ordered in zig-zag, but rather in
%               a top-down left-right order as given by operations such as
%               im2block.
%
%SEE ALSO       dct2basemx, im2block, block2im, zigzag.
%
%------------------------------------------------------------------------------
%Harald Nautsch                        (C) 1998 Image Coding Group. LiU, SWEDEN

%RCSID          $Id: had2basemx.m,v 1.2 2006/02/19 17:58:41 harna Exp $

if nargin == 1
  n = m(2);
  m = m(1);
end

T1=hadamard(m);
T2=hadamard(n);

% Sort the transform matrixes in 'frequency' order

[tmp1 tmp2]=sort(sum(abs([zeros(1,m); diff(T1)])));
T1=T1(:,tmp2)/sqrt(m);

[tmp1 tmp2]=sort(sum(abs([zeros(1,n); diff(T2)])));
T2=T2(:,tmp2)/sqrt(n);


% Ok, now for a loop solution. Slighthly ugly, but m and n are small anyway.

t=zeros(m*n);
tmp1=zeros(m,n);

for k=1:m
  for l=1:n
    tmp2=T1(:,k)*T2(l,:);
    t((l-1)*m+k,:)=tmp2(:)';
  end
end
