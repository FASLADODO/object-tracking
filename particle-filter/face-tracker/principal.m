clear all
close all
clc

% Initialisation des variables
C1 = 300;
C2 = 300;
N = 50;
Nb = 10;
lambda = 2000;
S_q = [C1 0 ; 0 C2];

% Image de reference, zone de reference et histogramme de reference
[im_ref, filenames, T, SEQUENCE] = lecture_image;
zone_ref = selectionner_zone;
longueur = zone_ref(1, 3);
largeur = zone_ref(1, 4);
[littleim,Cmap_ref,histo_ref] = calcul_histogramme(im_ref, zone_ref, Nb);

% Initialisation des particules et des poids
particules_0 = [zone_ref(1, 1) ; zone_ref(1, 2)]*ones(1, N) + sqrt(300)*randn(2, N);
poids_0 = 1/N * ones(1, N);

% Initialisation du filtrage
particules_prec = particules_0;
poids_prec = poids_0;
x_est = zeros(2, T);
x_est(:, 1) = [zone_ref(1, 1) ; zone_ref(1, 2)];
n_eff = zeros(1, T);

% Filtrage
for t=1:T
    im = imread([SEQUENCE filenames(t).name]);
    [particules, poids, x_est(:, t), n_eff(1, t)] = filtrage_particulaire(particules_prec, poids_prec, S_q, lambda, histo_ref, Cmap_ref, im, longueur, largeur);
    particules_prec = particules;
    poids_prec = poids;
    %figure;
    %imagesc(im);
    %rect_x = [x_est(1, t)  x_est(1, t)+longueur x_est(1, t)+longueur x_est(1, t) x_est(1, t)];
    %rect_y = [x_est(2, t) x_est(2, t) x_est(2, t)+largeur x_est(2, t)+largeur x_est(2, t)];
    %hold on
    %plot(rect_x, rect_y, '-r');
    %plot(particules(1, :), particules(2, :), 'xr');
end

close
plot(n_eff, '-r');