function graphcuts(image)
    scale_factor = 0.5;          % image downscale factor
    area1 = [ 80, 110, 570, 300 ]; % image region to train foreground with (area region for each tiger pic)
    area2 = [ 90, 100, 300, 250 ];
    area3 = [ 80, 110, 500, 300 ];  
    K = 2;                      % number of mixture components
    alpha = 8.0;                 % maximum edge cost
    sigma = 15.0;                % edge cost decay factor
    
    I = imread(image);
    I = imresize(I, scale_factor);
    Iback = I;
    area1 = int16(area1*scale_factor);
    [ segm, prior ] = graphcut_segm(I, area1, K, alpha, sigma);
    
    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);
    imwrite(Inew,'bildat_lab3/result/graphcut1.png')
    imwrite(I,'bildat_lab3/result/graphcut2.png')
    imwrite(prior,'bildat_lab3/result/graphcut3.png')
    subplot(1,3,1); imshow(Inew);
%     subplot(1,3,2); imshow(I); title("alpha=" + num2str(alpha) + ", sigma=" + num2str(sigma))
    subplot(1,3,2); imshow(I); title("K=" + num2str(K))
    subplot(1,3,3); imshow(prior);
end
