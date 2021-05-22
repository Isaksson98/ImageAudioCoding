function r = runlength(a, c)
%runlength - Estimate bitcost using JPEG-style run-length encoding.
%------------------------------------------------------------------------------
%SYNOPSIS       R = runlength(A, C)
%                  Runlength encodes each column of A and returns a row-vector
%                  R containing the number of bits used per column.
%                  A should contain integers (negative values allowed). The
%                  m x n matrix C represents the codeword lengths for
%                  (runlength, magnitude) pairs:
%
%                  C(i,j) = codeword length for a run of (i-1) zeroes followed
%                           by an integer with an absolute value in the
%                           range (2^(j-1), 2^j-1).
%                  where
%
%                  C(1,1) = bitcost for the end-of-block marker (EOB)
%
%                  and
%
%                  C(m,1) = bitcost for a m-zero-only run (ZRL)
%
%               R = runlength(A)
%                  In this case C defaults to the codeword-lengths of 
%                  table K.5 in appendix A. in [1]. These lengths are
%                  "optimized" for the statistics of the AC-coefficients
%                  of zig-zag ordered 8x8 DCT transformed natural images.
%
%               Only real parts of input arguments are considered.
%                   
%DISCUSSION     Codeword lengths should fulfill the Kraft-Macmillan unequality.
%               I.e.,
%                       sum(2.^-C(find(C>0)))     <=    1
%
%               The cost for coding a (run,mag) pair (not EOB or ZRL) is
%               actually,
%
%                       C(run+1,mag+1) + mag
%
%               since mag additional bits for the sign and value are needed.
%
%               Note that to calculate coding cost of an 8x8 DCT transformed
%               image in a JPEG-style the DC-coefficients have to be
%               treated differently. I.e., using differential encoding and
%               a special tree-code. (Maybe hist() and entropy() could
%               be an alternative here.)
%
%IMPLEMENTATION If the block ends with a zero-run of length r larger than m
%               it will be coded as a EOB. If equal to m a ZRL might be
%               used if cheaper. If shorter than m the cost C(r,2) might
%               be used if cheaper.
%
%SEE ALSO       hist, entropy.
%
%REFERENCES     [1] JPEG - Still Image Data Copression Standard
%                   William B. Pennebaker, Joan L. Mitchell
%                   ISBN 0-442-01272-1
%
%------------------------------------------------------------------------------
%Harald Nautsch                        (C) 1998 Image Coding Group. LiU, SWEDEN



if nargin < 1
  error('To few arguments');
end

oflag = 0;

if nargin<2
  c=[4  999999  999999  999999  999999  999999  999999  999999  999999  999999  999999  999999  999999  999999  999999 11
     2  4  5  6  6  7  7  8  9  9  9 10 10 11 16 16 
     2  5  8  9 10 11 12 12 15 16 16 16 16 16 16 16 
     3  7 10 12 16 16 16 16 16 16 16 16 16 16 16 16 
     4  9 12 16 16 16 16 16 16 16 16 16 16 16 16 16 
     5 11 16 16 16 16 16 16 16 16 16 16 16 16 16 16 
     7 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 
     8 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 
    10 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 
    16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 
    16 16 16 16 16 16 16 16 16 16 16 16 16 16 16 16]';
elseif c==0
  c = zeros(16, 11);
  pp = zeros(16, 11);
  oflag = 1;
end
c_m = size(c, 1);
c_n = size(c, 2);

    
a_m = size(a, 1);
a_n = size(a, 2);

if a_m == 1
  a=a';
  a_m = a_n;
  a_n = 1;
end

r = zeros(1, a_n);

% Iterate over columns in a

for k=1:a_n
  cost = 0;

  p0 = a_m;
  while (p0>1) & (a(p0, k) == 0)
      p0 = p0-1;
  end
  
  rcount = 0;
  for p=1:p0
    d = a(p, k);
    if (d ~= 0) | (rcount >= c_m-1) % End of a run of length rcount
      magn=ceil(log2(abs(d)+1));
      if oflag==1
        pp(rcount+1, magn+1) = pp(rcount+1, magn+1) + 1;
      else
        cost = cost + c(rcount+1, magn+1) + magn;
      end
      rcount = 0;
    else
      rcount = rcount+1;
    end
  end

  lr = a_m - p0;
  if lr ~= 0
    if oflag==1
      pp(1,1) = pp(1,1) + 1;
    else
      if lr > c_m     % The run was very long. Use EOB...
        cost = cost + c(1,1);
      elseif lr == c_m
        if c(1) < c(c_m,1)
          cost = cost + c(1,1);
        else
          cost = cost + c(c_m,1);
        end
      else
        if c(1,1) < c(lr, 1)
          cost = cost + c(1,1);
        else
          cost = cost + c(lr, 1);
        end
      end
    end
  end

  if oflag == 0
    r(k) = cost;
  end
end

if oflag==1
  c = reshape(huffcode(pp), size(pp));

  for k=1:a_n
    cost = 0;
    
    p0 = a_m;
    if c(1,1) > 0
      
      % We have a codeword for EOB -> derive startposition
      % for last run of zeroes */
      
      while (p0>1) & (a(p0, k) == 0)
        p0 = p0-1;
      end
    end
    
    rcount = 0;
    for p=1:p0
      d = a(p, k);
      if (d ~= 0) | (rcount >= c_m-1) % End of a run of length rcount
        magn=ceil(log2(abs(d)+1));
        c(rcount+1, magn+1);
        cost = cost + c(rcount+1, magn+1) + magn;
        rcount = 0;
      else
        rcount = rcount+1;
      end
    end
    
    lr = a_m - p0;
    if lr ~= 0
      if lr > c_m     % The run was very long. Use EOB...
        cost = cost + c(1,1);
      elseif lr == c_m
        if c(1) < c(c_m,1)
          cost = cost + c(1,1);
        else
          cost = cost + c(c_m,1);
        end
      else
        if c(1,1) < c(lr, 1)
          cost = cost + c(1,1);
        else
          cost = cost + c(lr, 1);
        end
      end
    end
    
    r(k) = cost;
  end
end
