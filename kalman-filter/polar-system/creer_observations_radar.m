function vecteur_y = creer_observations_radar(R, vecteur_x, T)
    vecteur_y = zeros(2, T);
    for i=1:T
        V = sqrt(R) * randn(2, 1);
        vecteur_y(:, i) = [ sqrt(vecteur_x(1, i)^2+vecteur_x(3, i)^2) ; atan2(vecteur_x(3, i), vecteur_x(1, i)) ] + V;
    end
end