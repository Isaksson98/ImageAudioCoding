function C = DCT(y,blockSize)
%DCT Does DCT transformation
%   Returns transform matrix

%% Autocorrelation function (acf)
    acf = zeros(blockSize,1);

    for lag = 0:blockSize-1
        acf(lag+1) = corr(y(1:end - lag), y(lag + 1:end));
    end
    acf2 = autocorr(y);
%% N point DCT
    N = blockSize;
    C = zeros(N);
    R_x = zeros(N);
    for i =1:N
        for j = 1:N
            C(i,j) = sqrt(2/N)*cos( (2*(j-1)+1)*(i-1)*pi/(2*N) );
            R_x(i,j) = acf(abs(i-j)+1);
        end
    end
    C(1,:)=1/sqrt(N);

end

