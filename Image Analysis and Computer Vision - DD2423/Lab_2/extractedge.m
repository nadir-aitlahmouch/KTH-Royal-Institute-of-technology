function edgecurves = extractedge(inpic, scale, threshold, shape)

    smoothed_pic = gaussfft(inpic, scale);
    L_v = Lv(smoothed_pic, shape);
    Lvv = Lvvtilde(smoothed_pic, shape);
    Lvvv = Lvvvtilde(smoothed_pic, shape);
    
    A = (Lvvv < 0) - 0.5;
    
    edgecurves = zerocrosscurves(Lvv, A);
    
    B = (L_v > threshold) - 0.5;
    
    edgecurves = thresholdcurves(edgecurves, B);
   
    overlaycurves(inpic, edgecurves)

end