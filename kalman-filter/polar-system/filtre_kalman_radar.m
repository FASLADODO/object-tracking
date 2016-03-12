function [x_kalm_k, P_kalm_k] = filtre_kalman_radar(F, Q, R, y_k, x_kalm_prec, P_kalm_prec)

%prédiction
x_kalm_n_n1 = F*(x_kalm_prec) ;
P_kalm_n_n1 = F*P_kalm_prec *transpose(F) + Q ;

if isnan(y_k) == 0
    %mise à jour
    H=[x_kalm_n_n1(1)/(sqrt(x_kalm_n_n1(1)^2+x_kalm_n_n1(3)^2)) 0 x_kalm_n_n1(3)/(sqrt(x_kalm_n_n1(1)^2+x_kalm_n_n1(3)^2)) 0 ; -x_kalm_n_n1(3)/(x_kalm_n_n1(1)^2+x_kalm_n_n1(3)^2) 0 1/(x_kalm_n_n1(1)+(x_kalm_n_n1(3)^2)/x_kalm_n_n1(1)) 0];
    K = P_kalm_n_n1 * transpose(H)* inv(H*P_kalm_n_n1*transpose(H)+R);
    x_kalm_k = x_kalm_n_n1 + K*(y_k- [sqrt(x_kalm_n_n1(1)^2+x_kalm_n_n1(3)^2) ; atan2(x_kalm_n_n1(3), x_kalm_n_n1(1))]);
    P_kalm_k = (eye(4)-K*H)*P_kalm_n_n1;
else
    x_kalm_k=x_kalm_n_n1;
    P_kalm_k=P_kalm_n_n1;
end
end