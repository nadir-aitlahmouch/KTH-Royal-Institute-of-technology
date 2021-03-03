function probas = mixture_prob(image, K, L, mask)
    % Store all pixels for which mask=1 in a Nx3 matrix
    [height, width, ~] = size(image);
    I = im2double(reshape(image, width*height, 3));
    Mvec = reshape(mask, width*height, 1);
    Ivec = I(Mvec==1, :);
    
    % Intialize the K components using the Kmeans
    seed = 14;
    rand("seed", seed);
    % Init means
    [segmentation, means] = kmeans_segm(Ivec, K, 100, seed, false);
    
    % Init covariance matrix
    cov = cell(K, 1);
    cov(:) = {rand * eye(3)};
    
    % Init weights
    w = zeros(1, K);
    for i = 1 : K
        w(i) = sum(segmentation == i) / size(segmentation, 1);
    end
    
    % Iterations L times
    g = zeros(size(Ivec, 1), K);
    for i = 1:L
        % Expectation
        for k = 1:K
            dif = bsxfun(@minus, Ivec, means(k, :));
            g(:, k) = 1/sqrt((2 * pi)^3*det(cov{k})) * exp(-0.5*sum((dif*inv(cov{k}).*dif), 2));
        end
        P = bsxfun(@times, w, g);
        P = bsxfun(@rdivide, P, sum(P, 2));
        
        % Maximization
        w = sum(P, 1)/size(P, 1);
        for k = 1:K
            means(k, :) = P(:, k)'*Ivec / sum(P(:, k), 1);
            dif = bsxfun(@minus, Ivec, means(k, :));
            cov{k} = (bsxfun(@times, P(:, k), dif)'*dif) / sum(P(:, k), 1);
        end
    end
    
    % Compute the probabilities in eq 3 for all the pixels.
    g = zeros(size(I, 1), K);
    for k = 1:K
        dif = bsxfun(@minus, I, means(k, :));
        g(:, k) = 1/sqrt((2*pi)^3*det(cov{k})) * exp(-0.5*sum((dif*inv(cov{k}).*dif), 2));
    end
    probas = sum(bsxfun(@times, w, g), 2);
    probas = reshape(probas, height, width, 1);   
end