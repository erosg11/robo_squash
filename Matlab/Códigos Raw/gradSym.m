function gradient = gradSym(equacao,vetor)
    sizeVector = length(vetor);
    gradient = sym(zeros(sizeVector,1));
    for i = 1:sizeVector
        gradient(i) = diff(equacao, vetor(i));
    end
end

