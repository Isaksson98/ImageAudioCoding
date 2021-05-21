function entropy = Entropy(x)

    a = hist (x, unique(x));
    p = a/length(x);
    entropy = -sum(p.*log2(p));

end
