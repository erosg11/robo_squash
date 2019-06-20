function verificaParametros(x_raquete, y_raquete, raio_maximo_menor, raio_maximo_maior)
if x_raquete^2/raio_maximo_menor^2 + y_raquete^2/raio_maximo_maior^2 > 1
    error("Parâmetros dos raios inválidos. Programa finalizado, ajuste os parâmetros.")
end

