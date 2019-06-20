% %-- Calculando os parametros cinemáticos e dinâmicos --%
dq = sym('dq',[1 6])';

JL10 = jacobian(Pg10(1:3),q);
JA10 = [T10(1:3,3), zeros(3,5)];
dPg10 = [JL10;JA10]*dq;

Pg20 = T10*Pg21;
JL20 = jacobian(Pg20(1:3),q);
JA20 = [T10(1:3,3), T20(1:3,2), zeros(3,4)];
dPg20 = [JL20;JA20]*dq;
II20 = T20(1:3,1:3)*(T21(1:3,1:3)\II21/(T21(1:3,1:3)'))*(T20(1:3,1:3)');

Pg30 = T20*Pg32;
JL30 = jacobian(Pg30(1:3),q);
JA30 = [T10(1:3,3), T20(1:3,2), T30(1:3,2), zeros(3,3)];
dPg30 = [JL30;JA30]*dq;
II30 = T30(1:3,1:3)*(T32(1:3,1:3)\II32/(T32(1:3,1:3)'))*(T30(1:3,1:3)');

Pg40 = T30*Pg43;
JL40 = jacobian(Pg40(1:3),q);
JA40 = [T10(1:3,3), T20(1:3,2), T30(1:3,2), T40(1:3,1), zeros(3,2)];
dPg40 = [JL40;JA40]*dq;
II40 = T40(1:3,1:3)*(T43(1:3,1:3)\II43/(T43(1:3,1:3)'))*(T40(1:3,1:3)');

Pg50 = T40*Pg54;
JL50 = jacobian(Pg50(1:3),q);
JA50 = [T10(1:3,3), T20(1:3,2), T30(1:3,2), T40(1:3,1), T50(1:3,2), zeros(3,1)];
dPg50 = [JL50;JA50]*dq;
II50 = T50(1:3,1:3)*(T54(1:3,1:3)\II54/(T54(1:3,1:3)'))*(T50(1:3,1:3)');

Pg60 = T50*Pg65;
JL60 = jacobian(Pg60(1:3),q);
JA60 = [T10(1:3,3), T20(1:3,2), T30(1:3,2), T40(1:3,1), T50(1:3,2), T60(1:3,1)];
dPg60 = [JL60;JA60]*dq;
II60 = T60(1:3,1:3)*(T65(1:3,1:3)\II65/(T65(1:3,1:3)'))*(T60(1:3,1:3)');

Pg70 = T60*Pg76;
JL70 = jacobian(Pg70(1:3),q);
dPg70 = [JL70;JA60]*dq;
II70 = T70(1:3,1:3)*(T76(1:3,1:3)\II76/(T76(1:3,1:3)'))*(T70(1:3,1:3)');

% Para analise cinemática
JLR0 = jacobian(T70(1:3,4),q);

% Jacobianos para analise Dinâmica do problema
JLAd = [JL70;JA60];
dJL70d = [jacobian(JL70(1:3,1),q)*dq, jacobian(JL70(1:3,2),q)*dq, jacobian(JL70(1:3,3),q)*dq, jacobian(JL70(1:3,4),q)*dq, jacobian(JL70(1:3,5),q)*dq, jacobian(JL70(1:3,6),q)*dq];
dJA60 = [jacobian(JA60(1:3,1),q)*dq, jacobian(JA60(1:3,2),q)*dq, jacobian(JA60(1:3,3),q)*dq, jacobian(JA60(1:3,4),q)*dq, jacobian(JA60(1:3,5),q)*dq, jacobian(JA60(1:3,6),q)*dq];
dJLAd = [dJL70d; dJA60];

% Jacobianos para analise Cinemática do problema
% Jacobianos para analise Dinâmica do problema
JLAc = [JLR0;JA60];
dJL70c = [jacobian(JLR0(1:3,1),q)*dq, jacobian(JLR0(1:3,2),q)*dq, jacobian(JLR0(1:3,3),q)*dq, jacobian(JLR0(1:3,4),q)*dq, jacobian(JLR0(1:3,5),q)*dq, jacobian(JLR0(1:3,6),q)*dq];
dJLAc = [dJL70c; dJA60];

% Calculando Energia Do Sistema
Pg = [Pg10 Pg20 Pg30 Pg40 Pg50 Pg60 Pg70];
dPg = [dPg10 dPg20 dPg30 dPg40 dPg50 dPg60 dPg70];
L = 0;
for i = 1:7
    L = L + calculaEnergia(matrizMassaBracos(i), dPg(:,i), eval(II(i)), Pg(:,i), g0);
end

dLdqp = gradSym(L,dq');
dLdq = gradSym(L,q);
dEddqp = mi*dq;

syms q1(t) q2(t) q3(t) q4(t) q5(t) q6(t)
q_L = [q1(t) q2(t) q3(t) q4(t) q5(t) q6(t)]';
dq_L = diff(q_L,t);
ddq_L = diff(dq_L,t);

ddLdqpdt = diff(subs(dLdqp,[q dq'],[q_L' dq_L']),t);