function output = gaussfft(pic,t)
    [width, height] = size(pic);
    [x, y] =  meshgrid(-width/2:(width/2)-1, -height/2:(height/2)-1);
    g = fftshift((1/(2*pi*t)) * exp(-(x.^2+y.^2)/(2*t)));
    
    output = ifft2(fft2(pic).*fft2(g));
end