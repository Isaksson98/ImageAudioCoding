function l=huffman(r)
%huffman - Huffman codeword mean-length.
%------------------------------------------------------------------------------
%SYNOPSIS       L = huffman(N)
%                 N should be a vector describing relative frequencies of
%                 the symbols of a source. The function calculates the 
%                 expected codeword length resulting from an Huffman encoding 
%                 of the source.
%
%                 This operation can operate on a matrix where the columns
%                 are considered to be data of different sources and the
%                 result will be a row vector of expected codeword lengths
%                 for the separately optimized Huffman codes.
%
%                 This is true: huffman(s*N) == s*huffman(N) where s is a
%                 scalar.
%
%SEE ALSO       entropy, ihist.
%------------------------------------------------------------------------------
%Jonas Svanberg                        (C) 1995 Image Coding Group. LiU, SWEDEN

%RCSID          $Id: huffman.m,v 1.4 1998/12/03 12:03:04 svan Exp $

if nargin < 1
  error('Demands mandatory argument N describing relative frequencies.');
end

if size(r,1) == 1
  r = r';
end

d = size(r,1);
n = size(r,2);
if d < 2
  l = zeros(1,d);
  return;
end

l = zeros(1,n);

for i=2:d,
  r = sort(r);
  s = r(1,:) + r(2,:);
  l = l + s .* ( (r(1,:).*r(2,:)) ~= 0);
  r = [s;r(3:size(r,1),:)];
end


  
  
