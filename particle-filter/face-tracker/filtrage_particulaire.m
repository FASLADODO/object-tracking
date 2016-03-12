function [particules, poids, estimateur, n_eff] = filtrage_particulaire(particules_prec, poids_prec, S_q, lambda, histo_ref, Cmap_ref, im, longueur, largeur)
    N = length(poids_prec);
    Nb = length(histo_ref);
    
    particules = particules_prec + sqrtm(S_q)*randn(2, N);
    poids = zeros(1, N);
    histo = zeros(Nb, N);
    
    for i=1:N
        zone = [particules(1, i) particules(2, i) longueur largeur];
        [littleim,Cmap,histo(:, i)]=calcul_histogramme(im, zone, Cmap_ref);
        poids(1, i) = poids_prec(1, i) * exp(-lambda*distance(histo(:, i), histo_ref));
    end
    poids = poids/sum(poids);
    n_eff = 1/sum(poids.^2);
    estimateur = sum(ones(2, 1)*poids .* particules, 2);
    [particules, poids] = reechantillonage(particules, poids);
end