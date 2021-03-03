% Part 2 - Questions 1 to 4

% K = 8;               % number of clusters used
% L = 150;              % number of iterations
% seed = 14;           % seed used for random initialization
% scale_factor = 1.0;  % image downscale factor
% image_sigma = 4.0;   % image preblurring scale
% 
% do_kmeans('tiger3.jpg', K, L, seed, scale_factor, image_sigma)
% 
% function do_kmeans(image, K, L, seed, scale_factor, image_sigma)
%     I = imread(strcat('bildat_lab3/',image));
%     I = imresize(I, scale_factor);
%     Iback = I;
%     d = 2*ceil(image_sigma*2) + 1;
%     h = fspecial('gaussian', [d d], image_sigma);
%     I = imfilter(I, h);
%     
%     tic
%     [ segm, centers ] = kmeans_segm(I, K, L, seed, true);
%     toc
%     Inew = mean_segments(Iback, segm);
%     I = overlay_bounds(Iback, segm);
%     imwrite(Inew,strcat(strcat('bildat_lab3/result/kmeans', image), '1.png'))
%     imwrite(I,strcat(strcat('bildat_lab3/result/kmeans',image), '2.png'))
% end

% =========================================================================
% Part 3 - Questions 5 and 6

% mean_shift('tiger1.jpg')


% =========================================================================
% Part 4 - Questions 7 to 10

% norm_cuts('orange.jpg')

% =========================================================================
% Part 5 - Questions 11 to 14

% graphcuts('tiger1.jpg')





