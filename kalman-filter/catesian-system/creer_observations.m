function vecteur_y = creer_observations(H, R, vecteur_x, T)
    vecteur_y = zeros(2, T);
    for i=1:T
        V = sqrt(R) * randn(2, 1);
        vecteur_y(:, i) = H * vecteur_x(:, i) + V;
    end
end