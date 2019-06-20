function [matrizPosicaoLetraEParametrizada,matrizVelocidadeLetraEParametrizada,matrizAceleracaoLetraEParametrizada,qtdPontos] = selecionaParametrizacao(nome, tempoTotalSegmento, taxaAmostragem, moduloAceleracao)

%Pontos selecionados no referencial da tarefa
A = [0.6 0.7 0.8];
B = [0.6 0.6 0.6];
% C = [0.35 0.35 0.35]*a;
% D = [0.4 0.4 0.4]*a;
% E = [0.45 0.45 0.45]*a;
% F = [0.5 0.5 0.5]*a;
% G = [0.55 0.55 0.55]*a;
% H = [0.6 0.6 0.6]*a;

%selecione a parametrização desejada
switch nome
    case 'cubica'
        %--Parametrização Cúbica--%
        [AB, dAB, ddAB] = parametrizacaoCubica(A,B,tempoTotalSegmento,taxaAmostragem);
%         [BC, dBC, ddBC] = parametrizacaoCubica(B,C,tempoTotalSegmento,taxaAmostragem);
%         [CD, dCD, ddCD] = parametrizacaoCubica(C,D,tempoTotalSegmento,taxaAmostragem);
%         [DE, dDE, ddDE] = parametrizacaoCubica(D,E,tempoTotalSegmento,taxaAmostragem);
%         [EF, dEF, ddEF] = parametrizacaoCubica(E,F,tempoTotalSegmento,taxaAmostragem);
%         [FG, dFG, ddFG] = parametrizacaoCubica(F,G,tempoTotalSegmento,taxaAmostragem);
%         [GH, dGH, ddGH] = parametrizacaoCubica(G,H,tempoTotalSegmento,taxaAmostragem);
%         [HA, dHA, ddHA] = parametrizacaoCubica(H,A,tempoTotalSegmento,taxaAmostragem);
        
    case 'quinta_ordem'
        %--Parametrização de Quinta Ordem--%
        [AB, dAB, ddAB] = parametrizacaoQuinta(A,B,0,0,moduloAceleracao*[1 0 0],-moduloAceleracao*[1 0 0],tempoTotalSegmento,taxaAmostragem);
%         [BC, dBC, ddBC] = parametrizacaoQuinta(B,C,0,0,moduloAceleracao*[0 1 0],-moduloAceleracao*[0 1 0],tempoTotalSegmento,taxaAmostragem);
%         [CD, dCD, ddCD] = parametrizacaoQuinta(C,D,0,0,moduloAceleracao*[0 0 -1],-moduloAceleracao*[0 0 -1],tempoTotalSegmento,taxaAmostragem);
%         [DE, dDE, ddDE] = parametrizacaoQuinta(D,E,0,0,moduloAceleracao*[0 -1 0],-moduloAceleracao*[0 -1 0],tempoTotalSegmento,taxaAmostragem);
%         [EF, dEF, ddEF] = parametrizacaoQuinta(E,F,0,0,moduloAceleracao*[0 0 0],-moduloAceleracao*[0 0 0],tempoTotalSegmento,taxaAmostragem);
%         [FG, dFG, ddFG] = parametrizacaoQuinta(F,G,0,0,moduloAceleracao*[1 0 0],-moduloAceleracao*[1 0 0],tempoTotalSegmento,taxaAmostragem);
%         [GH, dGH, ddGH] = parametrizacaoQuinta(G,H,0,0,moduloAceleracao*[0 1 0],-moduloAceleracao*[0 1 0],tempoTotalSegmento,taxaAmostragem);
%         [HA, dHA, ddHA] = parametrizacaoQuinta(H,A,0,0,moduloAceleracao*[0 0 0],-moduloAceleracao*[0 0 0],tempoTotalSegmento,taxaAmostragem);
        
    case 'reta_parabola'
        %--Parametrização Reta-Parábola--%
        [AB, dAB, ddAB] = parametrizacaoRetaParabola(A,B,tempoTotalSegmento,taxaAmostragem);
%         [BC, dBC, ddBC] = parametrizacaoRetaParabola(B,C,tempoTotalSegmento,taxaAmostragem);
%         [CD, dCD, ddCD] = parametrizacaoRetaParabola(C,D,tempoTotalSegmento,taxaAmostragem);
%         [DE, dDE, ddDE] = parametrizacaoRetaParabola(D,E,tempoTotalSegmento,taxaAmostragem);
%         [EF, dEF, ddEF] = parametrizacaoRetaParabola(E,F,tempoTotalSegmento,taxaAmostragem);
%         [FG, dFG, ddFG] = parametrizacaoRetaParabola(F,G,tempoTotalSegmento,taxaAmostragem);
%         [GH, dGH, ddGH] = parametrizacaoRetaParabola(G,H,tempoTotalSegmento,taxaAmostragem);
%         [HA, dHA, ddHA] = parametrizacaoRetaParabola(H,A,tempoTotalSegmento,taxaAmostragem);
    otherwise
        error("Tipo de parametrização não encontrada. Programa finalizado, ajuste os parâmetros.");
end
qtdPontos = length(AB);
% matrizPosicaoLetraEParametrizada = [AB ones(qtdPontos,1); BC zeros(qtdPontos,1); CD zeros(qtdPontos,1); DE zeros(qtdPontos,1); EF ones(qtdPontos,1); FG ones(qtdPontos,1); GH zeros(qtdPontos,1); HA ones(qtdPontos,1)];
% matrizVelocidadeLetraEParametrizada  = [dAB; dBC; dCD; dDE; dEF; dFG; dGH; dHA];
% matrizAceleracaoLetraEParametrizada  = [ddAB; ddBC; ddCD; ddDE; ddEF; ddFG; ddGH; ddHA];
matrizPosicaoLetraEParametrizada = [AB zeros(qtdPontos,1)];
matrizVelocidadeLetraEParametrizada  = [dAB];
matrizAceleracaoLetraEParametrizada  = [ddAB];

end