function SNR = snr_stereo(y1, y_hat1, y2, y_hat2)
    
    Err1 = y1 - y_hat1;
    Err2 = y2 - y_hat2;
    
    D1 = mean(Err1 .^ 2);
    D2 = mean(Err2 .^ 2);
    
    V1 = var(y1);
    V2 = var(y2);
    
    D = (D1+D2)/2;
    V = (V1+V2)/2;
    
    SNR = 10*log10( V / D);

end