% Cho he thong TTBB co PTSP: y(n) - 4y[n-1] = 3x(n) + 10x(n-1) - 2x(n-2)
% a. Tim DUXDV h[n] cua he
clf;
N = 100;
num = [3 10 -2];            % numerator vector = {bj} = cac hs lien quan den x[n]
den = [1 -4];                  % denominator vector = {ai} = cac hs lien quan den y[n] (a0=1)
h = impz(num,den,N);    % N: so luong mau cua h[n] (h[n] co the dai vo han)
figure(1)
stem(h, 'fill');
title('h[n]');

% b. Tim y[n] cua he khi dc kich thich boi 1 x[n] nao do
L = 150;
x = randn(1,L);              % sinh tin hieu ngau nhien theo phan bo chuan co do dai L mau
y1 = conv(x,h);               % tinh convolution, L(y1) = L(x) + L(h) -1
y2 = filter(num,den,x);    % dung ham filter(), L(y2) = L(x)
figure(2)
hold on
subplot(411),stem(x,'fill');title('x[n]');
subplot(412),stem(y1(1:L),'fill');title('y1[n]=conv(x,h)');
subplot(413),stem(y2(1:L),'fill');title('y2[n]=filter(num,den,x)');
subplot(414),stem(log10(abs(y1(1:L)-y2(1:L))),'fill');title('log10(|y1[n]-y2[n]|)');

