function pixels = Lvvtilde(inpic, shape)

    dx_mask = [0 0 0 0 0; 0 0 0 0 0; 0 -0.5 0 0.5 0; 0 0 0 0 0; 0 0 0 0 0];
    dy_mask = dx_mask';
    dxx_mask = [0 0 0 0 0; 0 0 0 0 0; 0 1 -2 1 0; 0 0 0 0 0; 0 0 0 0 0];
    dyy_mask = dxx_mask';
    dxy_mask = conv2(dx_mask, dy_mask, 'same');

    Lx = filter2(dx_mask, inpic, shape);
    Ly = filter2(dy_mask, inpic, shape);
    Lxx = filter2(dxx_mask, inpic, shape);
    Lxy = filter2(dxy_mask, inpic, shape);
    Lyy = filter2(dyy_mask, inpic, shape);
    
    pixels = Lx.^2.*Lxx + 2.*Lx.*Ly.*Lxy + Ly.^2.*Lyy;
   
end