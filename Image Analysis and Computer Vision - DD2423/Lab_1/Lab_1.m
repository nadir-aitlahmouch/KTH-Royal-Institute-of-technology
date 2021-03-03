% Basis function - Question 1 to 6

% sz = 128;

% (5,9)
% fftwavetemplate(5,9,sz);
% 
% % (9,5)
% fftwavetemplate(9,5,sz);
% 
% % (17,9)
% fftwavetemplate(17,9,sz);
% 
% % (17,121)
% fftwavetemplate(17,121,sz);
% 
% % (5,1)
% fftwavetemplate(5,1,sz);
% 
% % (125,1)
% fftwavetemplate(125,1,sz);

% % (64,65)
% fftwavetemplate(64,70,sz);


%==========================================================================

% Linearity - Question 7 to 9

% F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
% G = F';
% H = F + 2 * G;
% 
% subplot(3,3,1)
% showgrey(F)
% title('F')
% 
% subplot(3,3,2)
% showgrey(G)
% title('G')
% 
% subplot(3,3,3)
% showgrey(H)
% title('H')
% 
% Fhat = fft2(F);
% Ghat = fft2(G);
% Hhat = fft2(H); 
% 
% subplot(3,3,4)
% showgrey(log(1 + abs(Fhat)));
% title('Log Fhat')
% 
% subplot(3,3,5)
% showgrey(log(1 + abs(Ghat)));
% title('Log Ghat')
% 
% subplot(3,3,6)
% showgrey(log(1 + abs(Hhat)));
% title('Log Hhat')
% 
% subplot(3,3,7)
% showfs(Fhat)
% title('Shifted Log Fhat')
% 
% subplot(3,3,8)
% showfs(Ghat)
% title('Shifted Log Ghat')
% 
% subplot(3,3,9)
% showfs(Hhat)
% title('Shifted Log Hhat')

%==========================================================================

% Multiplication - Question 10

% F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
% G = F';
% 
% subplot(1,3,1)
% showgrey(F .* G);
% title('FxG')
% 
% subplot(1,3,2)
% showfs(fft2(F .* G));
% title('FxG hat')
% 
% subplot(1,3,3)
% Fhat = fft2(F);
% Ghat = fft2(G);
% 
% showfs(fftshift(conv2(fftshift(Fhat)/128,fftshift(Ghat)/128, 'same')));
% title('Fhat*Ghat (convolution)')

%==========================================================================

% Scaling - Question 11

% S = [zeros(128, 48) ones(128, 32) zeros(128, 48)];
% G = [zeros(60, 128); ones(8, 128); zeros(60, 128)];
% F = G.*S;
% 
% H = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
% H = H.*H';
% 
% subplot(2,2,1)
% showgrey(F);
% title('F')
% 
% subplot(2,2,3)
% showfs(fft2(F));
% title('Fhat')
% 
% subplot(2,2,2)
% showgrey(H);
% title('H')
% 
% subplot(2,2,4)
% showfs(fft2(H));
% title('Hhat')

%==========================================================================

% Rotation - Question 12

% S = [zeros(128, 48) ones(128, 32) zeros(128, 48)];
% G = [zeros(60, 128); ones(8, 128); zeros(60, 128)];
% F = G.*S;
% 
% 
% fourier_rotate(F, 30)
% fourier_rotate(F, 45)
% fourier_rotate(F, 60)
% fourier_rotate(F, 90)
% 
% 
% function fourier_rotate(F, alpha)
%      figure()
%      subplot(3, 2, 1)
%      showgrey(F)
%      title("F")
% 
%      subplot(3, 2, 3)
%      Fhat = fft2(F);
%      showfs(Fhat);
%      title("Fhat");
% 
%      G = rot(F, alpha);
%      subplot(3, 2, 2);
%      showgrey(G);
%      title(strcat("G - ", int2str(alpha), "°"));
%      axis on;
%      
%      Ghat = fft2(G);
%      subplot(3, 2, 4);
%      showfs(Ghat);
%      title("Ghat");
%      
%      Hhat = rot(fftshift(Ghat), -alpha);
%      subplot(3, 2, 6);
%      showgrey(log(1 + abs(Hhat)))
%     title("Hhat");    
% 
% end

%==========================================================================

% Phase and Magnitude - Question 13

% a = 10^(-10);
% 
% myfunction(phonecalc128, a)
% myfunction(nallo128, a)
% myfunction(few128, a)
% 
% function myfunction(img, e)
%     figure()
%     subplot(1,3,1)
%     showgrey(img);
%     title("Original");
%     subplot(1,3,2)
%     showgrey(pow2image(img, e));
%     title("With only phase");
%     subplot(1,3,3)
%     showgrey(randphaseimage(img));
%     title("With only magnitude");
% end

%==========================================================================

% Filtering Procedure - Questions 14 to 16

% t = [0.1 0.3 1.0 10.0 100.0];
% t = [1.0 4.0 16.0 64.0 256.0];
 
% var_1 = applyGauss(deltafcn(128,128), t);
% var_2 = applyGauss(genevepark128, t);
% var_3 = applyGauss(kaffe128, t);
% 
% function var_vector = applyGauss(pic, t)
%     var_vector = zeros(2,2);
%     figure()
%     subplot(2, 3, 1);
%     showgrey(pic);
%     title("Original pic");
%     
%     for i=1:length(t)
%         psf = gaussfft(pic, t(i));
%         subplot(2, 3, 1+i);
%         showgrey(psf);
%         title("t=" + num2str(t(i)));
%         
%         var_vector(:,:,i+1) = variance(psf);
%     end
% end

%==========================================================================

% Smoothing of noisy data - Questions 17 and 18

% t = [0.5 1.5 2 2.5];
% win = [2 3 4 5];
% cutoff = [0.1 0.2 0.3 0.4];
% 
% reduce_noise(office256, "Gaussian", t, win, cutoff)
% reduce_noise(office256, "SP", t, win, cutoff)
% 
% function reduce_noise(pic, noise, t, win, cutoff)
%     if strcmp("Gaussian", noise)
%          noise_pic = gaussnoise(pic, 16);
%     else
%          noise_pic = sapnoise(pic, 0.1, 255);
%     end
% 
%     figure()
%     subplot(1,2,1)
%     showgrey(pic)
%     title("Original")
% 
%     subplot(1,2,2)
%     showgrey(noise_pic)
%     title(noise+" noise")
% 
%     
%     figure()
%     for i=1:length(t)
%          subplot(3, 4, i);
%          showgrey(gaussfft(noise_pic, t(i)));
%          title(strcat("Gauss, t=", num2str(t(i))));
%     end
%     
%     for i=1:length(win)
%          subplot(3, 4, 4+i);
%          showgrey(medfilt(noise_pic, win(i), win(i)));
%          title(strcat("Median, window=", num2str(win(i))));
%     end
%     
%     for i=1:length(cutoff)
%          subplot(3, 4, 8+i);
%          showgrey(ideal(noise_pic, cutoff(i)));
%          title(strcat("Ideal, cutoff=", num2str(cutoff(i))));
%     end
%             
% end

%==========================================================================

% Smoothing and subsampling - Questions 19 and 20

% img = phonecalc256;
% gauss = img;
% id = img;
% N=5;
%  
% t=1.0;
% cutoff=0.2;
%  
% for i=1:N
%      if i>1 
%          img = rawsubsample(img);
%          id = ideal(id, cutoff);
%          id = rawsubsample(id);
%          gauss = gaussfft(gauss, t);
%          gauss = rawsubsample(gauss);
%      end
%      subplot(3, N, i)
%      showgrey(img)
%      title("Subsampling " + num2str(i));
%      subplot(3, N, i+N)
%      showgrey(gauss)
%      title("Gaussian, t=" + num2str(t));
%      subplot(3, N, 2*N+i)
%      showgrey(id)
%      title("Ideal, cutoff="+ num2str(cutoff));
% end
