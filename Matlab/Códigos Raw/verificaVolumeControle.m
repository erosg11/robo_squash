function resultado = verificaVolumeControle(qRange,q)
%Função que verifica o volume de controle
    resultado = 0;
    for i = 1:length(q)
       if q(i) < qRange(i,1) || q(i) > qRange (i,2)
           resultado = 1;
       end
    end
end

