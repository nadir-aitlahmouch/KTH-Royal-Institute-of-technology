function plotlines(linepar, pic)
    D = sqrt(size(pic, 1)^2 + size(pic, 2)^2);
    nlines = size(linepar, 1);
    outcurves = zeros(2, 4*nlines);

    for idx = 1:nlines
        theta = linepar(idx, 1);
        if theta == 0
            theta = 1e-5;
        end
        rho = linepar(idx, 2);

        x0 = 0;
        y0 = (-cos(theta)/sin(theta)) * x0 + (rho/sin(theta));
        dx = D^2;
        dy = (-cos(theta)/sin(theta)) * dx + (rho/sin(theta));
        outcurves(1, 4*(idx-1) + 1) = 0; % level, not significant
        outcurves(2, 4*(idx-1) + 1) = 3; % number of points in the curve
        outcurves(2, 4*(idx-1) + 2) = x0-dx;
        outcurves(1, 4*(idx-1) + 2) = y0-dy;
        outcurves(2, 4*(idx-1) + 3) = x0;
        outcurves(1, 4*(idx-1) + 3) = y0;
        outcurves(2, 4*(idx-1) + 4) = x0+dx;
        outcurves(1, 4*(idx-1) + 4) = y0+dy;
    end

    overlaycurves(pic, outcurves);
    axis([1 size(pic, 2) 1 size(pic, 1)]);
end