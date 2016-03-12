function d = distance(A, B)
    d = 1 - sum(sqrt(A.*B));
end