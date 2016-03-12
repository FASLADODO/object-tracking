clear all
close all
clc

% Initialisation des variables
T_e = 1;
T = 100;
sigma_Q = 1;
sigma_px = 30;
sigma_py = 30;
F = [1 T_e 0 0 ; 0 1 0 0 ; 0 0 1 T_e ; 0 0 0 1];
Q = sigma_Q^2 * [T_e^3/3 T_e^2/2 0 0 ; T_e^2/2 T_e 0 0 ; 0 0 T_e^3/3 T_e^2/2 ; 0 0 T_e^2/2 T_e];
H = [1 0 0 0 ; 0 0 1 0];
R = [sigma_px^2 0 ; 0 sigma_py^2];
x_init = [3 ; 20 ; -4 ; 20];
x_kalm = x_init;
P_kalm = eye(4);

% Trajectoires de X et Y
%vecteur_x = creer_trajectoire(F, Q, x_init, T);
load('vecteur_x_avion_voltige.mat')
load('vecteur_y_avion_voltige.mat')
%vecteur_y = creer_observations(H, R, vecteur_x, T);

% Filtre de Kalman
x_est = zeros(4, T);
x_est(:, 1) = x_kalm;
P_kalm_prec = P_kalm;
somme = 0;
for i=2:T
    [x_kalm_k, P_kalm_k] = filtre_de_kalman(F, Q, H, R, vecteur_y(:, i), x_est(:, i-1), P_kalm_prec);
    x_est(:, i) = x_kalm_k;
    P_kalm_prec = P_kalm_k;
    somme = somme + sqrt(err_quadra(vecteur_x(:, i), x_est(:, i)));
end

% Affichage
hold all
plot(vecteur_x(1, :), vecteur_x(3, :), 'r');
plot(vecteur_y(1, :), vecteur_y(2, :), 'g');
plot(x_est(1, :), x_est(3, :), 'b');
title('Avion de voltige');
xlabel('px');
ylabel('py');

%plot(vecteur_x(1, :), '-r');
%plot(vecteur_y(1, :), 'g');
%plot(x_est(1, :), '-b');
%xlabel('Time');
%ylabel('px');


%plot(vecteur_x(3, :), '-r');
%plot(vecteur_y(2, :), 'g');
%plot(x_est(3, :), '-b');
%xlabel('Time');
%ylabel('py');

% Erreur
erreur_moyenne = somme / T