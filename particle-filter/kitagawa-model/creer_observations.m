function vecteur_y = creer_observations(vecteur_x, R)
    T = length(vecteur_x);
    vecteur_y = vecteur_x.^2 / 20 + sqrt(R)*randn(1, T);
end