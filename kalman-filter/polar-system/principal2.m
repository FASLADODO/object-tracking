clear all
close all
clc

% Initialisation des variables
T_e = 1;
T = 100;
sigma_Q = 1;
sigma_distance = 100;
sigma_angle = 10*pi/180;
F = [1 T_e 0 0 ; 0 1 0 0 ; 0 0 1 T_e ; 0 0 0 1];
Q = sigma_Q^2 * [T_e^3/3 T_e^2/2 0 0 ; T_e^2/2 T_e 0 0 ; 0 0 T_e^3/3 T_e^2/2 ; 0 0 T_e^2/2 T_e];
H = [1 0 0 0 ; 0 0 1 0];
R = [sigma_distance^2 0 ; 0 sigma_angle^2];
x_init = [3 ; 20 ; -4 ; 20];
x_kalm = x_init;
P_kalm = eye(4);

% Trajectoires de X et Y
vecteur_x = creer_trajectoire(F, Q, x_init, T);
vecteur_y = creer_observations_radar(R, vecteur_x, T);

% Filtre de Kalman
x_est = zeros(4, T);
x_est(:, 1) = x_kalm;
P_kalm_prec = P_kalm;
somme = 0;
for i=2:T
    [x_kalm_k, P_kalm_k] = filtre_kalman_radar(F, Q, R, vecteur_y(:, i), x_est(:, i-1), P_kalm_prec);
    x_est(:, i) = x_kalm_k;
    P_kalm_prec = P_kalm_k;
    somme = somme + sqrt(err_quadra(vecteur_x(:, i), x_est(:, i)));
end

% Affichage
hold all
plot(vecteur_x(1, :), vecteur_x(3, :), 'r');
plot(vecteur_y(1, :).*cos(vecteur_y(2, :)), vecteur_y(1, :).*sin(vecteur_y(2, :)), 'g');
plot(x_est(1, :), x_est(3, :), 'b');
title('Extended Kalman Filter');
xlabel('px');
ylabel('py');

% Erreur
erreur_moyenne = somme / T