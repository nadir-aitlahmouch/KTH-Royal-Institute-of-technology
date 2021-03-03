function pixels = Lvvvtilde(inpic, shape)

    dx_mask = [0 0 0 0 0; 0 0 0 0 0; 0 -0.5 0 0.5 0; 0 0 0 0 0; 0 0 0 0 0];
    dy_mask = dx_mask';
    dxx_mask = [0 0 0 0 0; 0 0 0 0 0; 0 1 -2 1 0; 0 0 0 0 0; 0 0 0 0 0];
    dyy_mask = dxx_mask';
    dxxx_mask = conv2(dx_mask, dxx_mask, 'same');
    dxxy_mask = conv2(dxx_mask, dy_mask, 'same');
    dxyy_mask = conv2(dx_mask, dyy_mask, 'same');
    dyyy_mask = conv2(dy_mask, dyy_mask, 'same');

    Lx = filter2(dx_mask, inpic, shape);
    Ly = filter2(dy_mask, inpic, shape);
    Lxxx = filter2(dxxx_mask, inpic, shape);
    Lxxy = filter2(dxxy_mask, inpic, shape);
    Lxyy = filter2(dxyy_mask, inpic, shape);
    Lyyy = filter2(dyyy_mask, inpic, shape);
    
    pixels = Lx.^3.*Lxxx + 3*Lx.^2.*Ly.*Lxxy + 3*Lx.*Ly.^2.*Lxyy + Ly.^3.*Lyyy;

end