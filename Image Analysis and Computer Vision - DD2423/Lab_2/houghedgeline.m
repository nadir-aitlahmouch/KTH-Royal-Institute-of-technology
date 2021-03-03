function [linepar acc] = ...
    houghedgeline(pic, scale, gradmagnthreshold, nrho, ntheta, nlines, verbose)
    
    curves = extractedge(pic, scale, gradmagnthreshold, 'same');
    magnitude = sqrt(Lv(pic, 'same'));
    [linepar, acc] = houghline(curves, magnitude, nrho, ntheta, gradmagnthreshold, nlines, verbose);
    if verbose >= 1
        plotlines(linepar, pic);
    end
end