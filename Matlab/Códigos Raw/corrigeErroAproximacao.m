function vetor = corrigeErroAproximacao(vetor, fatorDePrecisao)
    for i = 1:length(vetor)
        if imag(vetor(i)) <= fatorDePrecisao
            vetor(i) = real(vetor(i));
        end
    end
end

