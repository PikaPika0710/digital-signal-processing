function rs = STE(data, fs)
    secondPerFrame = 0.025; % do dai khung (theo s)
    samplePerFrame = fs * secondPerFrame;% do dai khung tinh theo mau
    samplePerFrame = floor(samplePerFrame); 
    % 1s -> 16000 mau
    % 0.025s -> 400 mau

    numberOfFrames = length(data) / samplePerFrame; % so luong khung
    numberOfFrames = floor(numberOfFrames);
    rs(numberOfFrames) = zeros();
    temp = 1;
    for i = 1 : numberOfFrames
       n = samplePerFrame * temp;
       rs(temp) = STEIndex(data, n, samplePerFrame);
       temp = temp + 1;
    end
    