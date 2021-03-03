% Part 1 - Question 1

% tools = few256;
% 
% dx_centered = [0 0 0; -0.5 0 0.5; 0 0 0];
% dy_centered = [0 -0.5 0; 0 0 0; 0 0.5 0];
% 
% 
% subplot(1, 3, 1)
% showgrey(tools)
% % size is : 256x256
% title('Original image');
% 
% subplot(1, 3, 2)
% showgrey(conv2(tools, dx_centered, 'valid'))
% % size is : 254x254
% title('Using dx centered');
% 
% subplot(1, 3, 3)
% showgrey(conv2(tools, dy_centered, 'valid'))
% % size is : 254x254
% title('Using dy centered');

% =========================================================================

% Part 2 - Questions 2 and 3 

% tools = few256;
% godthem = godthem256;

% gradmagntools = sqrt(Lv(tools, 'valid'));
% 
% subplot(1, 3, 1);
% histogram(gradmagntools);
% title('Hist');

% ---------------------------------------------------------
% t = [5 10 15 20 25];

% grad_ghem = sqrt(Lv(godthem, 'valid'));
% gauss_grad_ghem = sqrt(Lv(gaussfft(godthem, 1), 'valid'));
% histogram(gauss_grad_ghem);

% plotThreshold(grad_ghem, t);
% plotThreshold(gauss_grad_ghem, t);

% scales = [0.1 0.3 0.5 0.8 1];
% 
% plotScale(godthem, scales);

% --------------------------------------------------------

% function plotThreshold(inpic, t)
%     figure();
%     subplot(2, (length(t)+1)/2, 1)
%     showgrey(inpic)
%     title('No threshold')
%     
%     for i=1:length(t)
%         subplot(2, (length(t)+1)/2, i+1);
%         showgrey((inpic - t(i)) > 0);
%         title(['threshold:' num2str(t(i))]);
%     end    
% end
% 
% function plotScale(inpic, s)
%     figure();
%     subplot(2, 3, 1)
%     showgrey((sqrt(Lv(inpic, 'valid')) - 20) > 0);
%     title('threshold = 30, no smoothing')
%     
%     for i=1:length(s)
%         subplot(2, 3, i+1);
%         pic = sqrt(Lv(gaussfft(inpic, s(i)), 'valid'));
%         showgrey((pic - 20) > 0);
%         title(['threshold = 30, scale = ' num2str(s(i))]);
%     end    
% end

% =========================================================================

% Part 4 - Questions 4 to 6

godthem = godthem256;
scales = [0.0001 1.0 4.0 16.0 32.0 64.0];

% figure();
% for i=1:length(scales)
%     subplot(2, 3, i);
%     contour(Lvvtilde(gaussfft(godthem, scales(i)), 'same'), [0 0])
%     axis('image') 
%     axis('ij')
%     title(['scale = ' num2str(scales(i))]);
% end

% tools = few256;
% 
% figure();
% for i=1:length(scales)
%     subplot(2, 3, i);
%     showgrey(Lvvvtilde(gaussfft(tools, scales(i)), 'same') < 0)
%     title(['scale = ' num2str(scales(i))]);
% end
% 
% figure()
% for i=1:length(scales)
%     subplot(2, 3, i);
%     lvv = Lvvtilde(discgaussfft(godthem, scales(i)), 'same');
%     lvvv = Lvvvtilde(discgaussfft(godthem, scales(i)), 'same');  
%     
%     copie_lvv = lvv;
%     copie_lvv(lvvv>0) = NaN;
%     contour(copie_lvv, [0 0]);
%     axis('image')
%     axis('ij')
%     title(['combined image, scale = ' num2str(scales(i))]);
% end


% =========================================================================

% Part 5 - Question 7

% godthem = godthem256;
% tools = few256;
% 
% scales = [1.0 4.0 8.0 16.0 32.0 64.0];
% thresholds = [3 8 10 12 15 18];

% chooseParams(tools, scales, thresholds, 8.0)
% chooseParams(godthem, scales, thresholds, 4.0)


% Show best results
% figure();
% subplot(1, 2, 1);
% extractedge(few256, 4.0, 8, 'same');
% title('Tools: scale = 4, threshold=8');
% subplot(1, 2, 2);
% extractedge(godthem256, 4.0, 3, 'same');
% title('Home: scale = 4, threshold=3');
% 
% function chooseParams(inpic, scales, thresholds, bestS)
% 
%     figure();
%     for i=1:length(scales)
%         subplot(2, length(scales)/2, i);
%         extractedge(inpic, scales(i), 1, 'same');
%         title(['scale = ' num2str(scales(i))]);
%     end
%     
%     figure();
%     for i=1:length(thresholds)
%         subplot(2, length(thresholds)/2, i);
%         extractedge(inpic, bestS, thresholds(i), 'same');
%         title(['threshold = ' num2str(thresholds(i))]);
%     end
% 
% end

% =========================================================================

% Part 6 - Questions 8 to 10

% Question 8
% testimage1 = triangle128;
% smalltest1 = binsubsample(testimage1);
% 
% testimage2 = houghtest256;
% smalltest2 = binsubsample(testimage2);
% 
% nrho = 200;
% ntheta = 181;
% 
% houghedgeline(testimage1, 6, 1, nrho, ntheta, 3, 2)



% Question 9 
% nrho = 450;
% ntheta = 181;
% 
% subplot(2, 2, 1)
% houghedgeline(houghtest256, 5, 10, nrho, ntheta, 10, 1);
% 
% subplot(2, 2, 2)
% houghedgeline(few256, 8, 8, nrho, ntheta, 15, 1);
% 
% subplot(2, 2, 3)
% houghedgeline(phonecalc256, 3, 18, nrho, ntheta, 10, 1);
% 
% subplot(2, 2, 4)
% houghedgeline(godthem256, 5, 15, nrho, ntheta, 20, 1);

% Question 10 
% nrho = 450;
% ntheta = 181;

% subplot(1, 3, 1)
% houghedgeline(few256, 8, 8, nrho, ntheta, 15, 1);
% title('h(mag) = 1')

% subplot(1, 3, 2)
% houghedgeline(few256, 8, 8, nrho, ntheta, 15, 1);
% title('h(mag) = mag')
% 
% subplot(1, 3, 3)
% houghedgeline(few256, 8, 8, nrho, ntheta, 15, 1);
% title('h(mag) = log(mag)')






