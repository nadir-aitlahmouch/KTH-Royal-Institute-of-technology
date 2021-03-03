function [linepar, acc] = ...
    houghline(curves, magnitude, nrho, ntheta, threshold, nlines, verbose)

    assert(nrho > 0 && ntheta > 0 && nlines > 0);

    acc = zeros(nrho, ntheta);
    
    D = sqrt(size(magnitude,1)^2+size(magnitude,2)^2);
    thetas = linspace(-pi/2, pi/2, ntheta);
    rhos = linspace(-D, D, nrho);
    
    insize = size(curves, 2);
    trypointer = 1;
    numcurves = 0;
    
    while trypointer <= insize
        polylength = curves(2, trypointer);
        numcurves = numcurves + 1;
        trypointer = trypointer + 1;
        for polyidx = 1:polylength
            x = curves(2, trypointer);
            y = curves(1, trypointer);
            trypointer = trypointer + 1;
            mag_xy = magnitude(round(x), round(y));
            delta_S = 1;
%             delta_S = mag_xy;
%             delta_S = log(mag_xy);
            if mag_xy >= threshold
                for i = 1:ntheta
                    % Compute rho for each theta value
                    rho = x*cos(thetas(i)) + y*sin(thetas(i));
                    % Compute index values in the accumulator space
                    j = find(rhos < rho, 1, 'last');
                    % Update the accumulator
                    acc(j, i) = acc(j, i) + delta_S;
                end
            end
        end
    end
    
    if verbose >= 2
        figure();
        showgrey(acc);
    end
    
    [pos, value] = locmax8(acc);
    [~, indexvector] = sort(value);
    nmaxima = size(value, 1);
    
    if nmaxima < nlines
        nlines = nmaxima;
    end
    
    linepar = zeros(nlines, 2);
    for idx = 1:nlines
        rhoidxacc = pos(indexvector(nmaxima - idx + 1), 1);
        thetaidxacc = pos(indexvector(nmaxima - idx + 1), 2);
        linepar(idx, :) = [thetas(thetaidxacc) rhos(rhoidxacc)];
    end
    if verbose >= 2
        plotlines(linepar, magnitude);
    end
end