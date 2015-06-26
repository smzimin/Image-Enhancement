function image_enhancement
clear;
close all;

image = 4096 - dicomread('Large_Skull');
l = 5;
O = ones(2);
s(1,:) = 2^l*floor(size(image)/2^l);

[ D1, T1 ] = decomposition( image(1:s(1),1:s(2)));
[ D2, T2 ] = decomposition( T1 );
[ D3, T3 ] = decomposition( T2 );
[ D4, T4 ] = decomposition( T3 );
[ D5, T5 ] = decomposition( T4 );

alpha = [1 7 1 1 1.1];
temp = kron(T5,O) + alpha(5)*D5;
temp = kron(temp,O) + alpha(4)*D4;
temp = kron(temp,O) + alpha(3)*D3;
temp = kron(temp,O) + alpha(2)*D2;
temp = kron(temp,O) + alpha(1)*D1;

%h = figure('visible','off');
imshow(temp, [500,4000]);
%saveas(h, sprintf('image%g_%g_%g_%g_%g.tif', alpha(1),alpha(2),alpha(3),alpha(4),alpha(5)));
end

function [ D, T ] = decomposition( im )
s = size(im);
D = zeros(s);
T = zeros(s/2);

for u = 2:2:s(1)
    for v = 2:2:s(2)
        T(u/2,v/2) = (im(u-1,v-1) + im(u-1,v) + im(u,v-1) + im(u,v)) / 4;
        D(u-1:u,v-1:v) = im(u-1:u,v-1:v) - T(u/2,v/2);
    end
end

end
