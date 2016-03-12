function tau = err_quadra(A, B)
    tau = transpose(A-B) * (A-B);
end