function vecteur_x = creer_trajectoire(T, x_init, Q)
    vecteur_x = zeros(1, T);
    vecteur_x(1, 1) = x_init;
    for i=2:T
        vecteur_x(1, i) = 1/2*vecteur_x(1, i-1) + 25*vecteur_x(1, i-1)/(1+vecteur_x(1, i-1)^2) + 8*cos(1.2*i) + sqrt(Q)*randn;
    end
end