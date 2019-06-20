function qs = calculateBaskSolution(A,B,C)
    q_1 = acos(((-B*C)+((B*C)^2-(A^2+B^2)*(C^2-A^2))^0.5)/(A^2+B^2));
    q_2 = acos(((-B*C)-((B*C)^2-(A^2+B^2)*(C^2-A^2))^0.5)/(A^2+B^2));
    qs = [q_1, -q_1, q_2, -q_2];
end

