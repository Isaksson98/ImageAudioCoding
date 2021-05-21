function SNR = snr(y, y_hat)

    Err = y - y_hat;
    D = mean(Err .^ 2);
    SNR = 10*log10( var(y) / D);

end