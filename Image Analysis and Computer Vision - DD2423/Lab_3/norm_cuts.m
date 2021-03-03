function norm_cuts(image)
    colour_bandwidth = 20.0; % color bandwidth
    radius = 3;              % maximum neighbourhood distance
    ncuts_thresh = 0.4;      % cutting threshold
    min_area = 50;          % minimum area of segment
    max_depth = 8;           % maximum splitting depth
    scale_factor = 0.4;      % image downscale factor
    image_sigma = 2.0;       % image preblurring scale
    
    I = imread(image);
    I = imresize(I, scale_factor);
    Iback = I;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I = imfilter(I, h);
    
    segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);
    imwrite(Inew,'bildat_lab3/result/normcuts1.png')
    imwrite(I,'bildat_lab3/result/normcuts2.png')
    
%     subplot(1,2,1); imshow(Inew); title("ncuts-thresh=" + num2str(ncuts_thresh) + ", min-area=" + num2str(min_area) + ", max-depth=" + num2str(max_depth));
%     subplot(1,2,2); imshow(I); title("ncuts-thresh=" + num2str(ncuts_thresh) + ", min-area=" + num2str(min_area) + ", max-depth=" + num2str(max_depth));

    subplot(1,2,1); imshow(Inew); title("radius=" + num2str(radius));
    subplot(1,2,2); imshow(I); title("radius=" + num2str(radius));
end