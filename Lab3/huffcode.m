function [l, ml] = huffcode(p)
%huffcode - Huffman coding
%------------------------------------------------------------------------------
%SYNOPSIS       [L R] = huffcode(N)
%                 N should be a vector describing relative frequencies of
%                 the symbols of a source. The function calculates the 
%                 codeword lengths, L, of the huffman codes and the expected
%                 rate R resulting from a huffman encoding of the source.
%
%NOTE             As opposed to the 'huffman' function, this function only
%                 operates on a single vector.
%
%SEE ALSO       huffman, entropy, ihist.
%------------------------------------------------------------------------------
%Harald Nautsch                        (C) 1998 Image Coding Group. LiU, SWEDEN

%RCSID          $Id: huffcode.m,v 1.2 1998/12/07 16:17:52 harna Exp $

p=p(:);
ml=0;

others=zeros(length(p),1);
l=zeros(length(p),1);

nnz = length(find(p))-1;

if nnz>0
  for k=1:nnz
    [vals I]=sort(p);
    nonzero = find(vals);
    v1=I(nonzero(1));
    v2=I(nonzero(2));
    p(v1) = p(v1) + p(v2);
    p(v2) = 0;
    ml = ml + p(v1);
    dummy = v1;
    while dummy    % So why is there no do-while construction in MatLab??
      v1 = dummy;
      l(v1) = l(v1) + 1;
      dummy = others(v1);
    end
    others(v1) = v2;
    dummy = v2;
    while dummy
      v2 = dummy;
      l(v2) = l(v2) + 1;
      dummy = others(v2);
    end
  end
end  
