function pixels = Lv(inpic, shape)
    if (nargin < 2)
        shape = 'same';
    end
    
    dxmask = [0 0 0; -0.5 0 0.5; 0 0 0];
    dymask = [0 -0.5 0; 0 0 0; 0 0.5 0];
    
    Lx = filter2(dxmask, inpic, shape);
    Ly = filter2(dymask, inpic, shape);
    
    pixels = Lx.^2 + Ly.^2;
end