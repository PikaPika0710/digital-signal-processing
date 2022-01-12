[v,fs]=audioread('./16hz.wav'); %doc file audio vao vecto
r = 0;
for i=1:length(v)
    r = r + v(i)^2;
end
% e = sum(abs(v).^2); %nang luong
% Use POWER (.^) for elementwise power.
% nang luong cua tin hieu bang tong binh phuong cua cac bien tu am -> duong
% vo cung
x = length(v);
% lay do dai
p = e/length(v);
% cong suat cua tin hieu bang nang luong/thoi luong
% -L->L = 2L+1

 
