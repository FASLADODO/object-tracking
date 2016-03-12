function [x_kalm_k, P_kalm_k] = filtre_de_kalman(F, Q, H, R, y_k, x_kalm_prec, P_kalm_prec)
    % Prediction
    x_kalm_kk1 = F * x_kalm_prec;
    P_kalm_kk1 = F * P_kalm_prec * transpose(F) + Q;
    
    if isnan(y_k) == 0
        % MAJ
        K = P_kalm_kk1 * transpose(H) * inv(H * P_kalm_kk1 * transpose(H) + R);
        x_kalm_k = x_kalm_kk1 + K * (y_k - H * x_kalm_kk1);
        P_kalm_k = (eye(4) - K * H) * P_kalm_kk1;
    else
        x_kalm_k = x_kalm_kk1;
        P_kalm_k = P_kalm_kk1;
    end
    
end