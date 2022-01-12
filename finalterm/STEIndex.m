function rs = STEIndex(data, n, samplePerFrame)
    rs = 0;
    for sampleIndex = 0 : samplePerFrame - 1
        rs = rs + data(n - sampleIndex).^2;
    end
    
    