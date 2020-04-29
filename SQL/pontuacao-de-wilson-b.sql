SELECT P.id_filme
     , P.titulo
     , P.estrelas
     , P.votos
     , IF ((P.positivo + P.negativo) > 0, ((P.positivo + 1.9208) / (P.positivo + P.negativo) - 1.96 * SQRT((P.positivo * P.negativo) / (P.positivo + P.negativo) + 0.9604) / (P.positivo + P.negativo)) / (1 + 3.8416 / (P.positivo + P.negativo)), 0) AS escore
FROM (
    SELECT S.id_filme
         , S.titulo
         , IF ((S.vcinco + S.vquatro + S.vtres + S.vdois + S.vum) > 0, ((S.vcinco*5 + S.vquatro*4 + S.vtres*3 + S.vdois*2 + S.vum*1) / (S.vcinco + S.vquatro + S.vtres + S.vdois + S.vum)), 0) AS estrelas
         , (S.vcinco + S.vquatro + S.vtres + S.vdois + S.vum) AS votos
         , (S.vcinco + S.vquatro*0.75 + S.vtres*0.5 + S.vdois*0.25) AS positivo
         , (S.vquatro*0.25 + S.vtres*0.5 + S.vdois*0.75 + S.vum) AS negativo
    FROM (
        SELECT F.id_filme
             , F.titulo
             , SUM(IF (V.voto = 5, 1, 0)) AS vcinco
             , SUM(IF (V.voto = 4, 1, 0)) AS vquatro
             , SUM(IF (V.voto = 3, 1, 0)) AS vtres
             , SUM(IF (V.voto = 2, 1, 0)) AS vdois
             , SUM(IF (V.voto = 1, 1, 0)) AS vum
        FROM filmes F
        LEFT JOIN votacao V
        ON F.id_filme = V.id_filme
        GROUP BY F.id_filme
    ) S
) P
ORDER BY escore DESC;
