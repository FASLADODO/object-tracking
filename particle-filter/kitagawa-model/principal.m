clear all
close all
clc

tic

% Initialisation des variables
N = 5000;
Q = 10;
R = 1;
T = 50;
x_init = 1;

% Trajectoire
vecteur_x = creer_trajectoire(T, x_init, Q);
vecteur_y = creer_observations(vecteur_x, R);

% Premiere estimation
x_est = zeros(1, T);
x_est(1, 1) = x_init;
particules_prec = x_est(1, 1)*ones(1, N) + sqrt(0.5)*randn(1, N);
poids_prec = 1/N * ones(1, N);

err_quadra = 0;

% Filtrage particulaire
for t=2:T
    [particules, poids, estimateur] = filtre_particulaire(particules_prec, poids_prec, vecteur_y(1, t), Q, R, t);
    x_est(1, t) = estimateur;
    particules_prec = particules;
    poids_prec = poids;
    err_quadra = err_quadra + (x_est(1, t) - vecteur_x(1, t))^2;
end

toc

err_quadra

hold all
plot(vecteur_x, '-b');
plot(vecteur_y, '-g');
plot(x_est, '-r');
xlabel('Position');
ylabel('X_n , Y_n, X_e_s_t');
title('Trajectoire réelle, observations et estimations, longueur T=50');