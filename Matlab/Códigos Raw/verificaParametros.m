function verificaParametros(x_raquete, y_raquete, raio_maximo_menor, raio_maximo_maior)
if x_raquete^2/raio_maximo_menor^2 + y_raquete^2/raio_maximo_maior^2 > 1
    error("Par�metros dos raios inv�lidos. Programa finalizado, ajuste os par�metros.")
end

