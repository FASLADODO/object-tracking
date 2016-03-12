function [particules, poids, estimateur] = filtre_particulaire(particules_prec, poids_prec, y_k, Q, R, t)
    N = length(particules_prec);
    % Allouer la mémoire
    particules = zeros(1, N);
    poids = zeros(1, N);
    for i=1:N
        % Tirer les particules suivant f_n/n-1
        particules(1, i) = 1/2*particules_prec(1, i) + 25*particules_prec(1, i)/(1+particules_prec(1, i)^2) + 8*cos(1.2*t) + sqrt(Q)*randn;
        % Nouveaux poids
        poids(1, i) = poids_prec(1, i) * normpdf(y_k, particules(1, i)^2/20, R);    
    end
    % Normalisation
    poids = poids / sum(poids);
    % Estimateur
    estimateur = sum(poids .* particules);
    % Reechantillonnage
    [particules, poids] = reechantillonage(particules, poids);
end