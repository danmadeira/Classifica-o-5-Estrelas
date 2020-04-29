SELECT P.id_filme
     , P.titulo
     , P.estrelas
     , P.votos
     , IF (P.votos > 0, (1 * (P.vum + 1) / (P.votos + 5) + 2 * (P.vdois + 1) / (P.votos + 5) + 3 * (P.vtres + 1) / (P.votos + 5) + 4 * (P.vquatro + 1) / (P.votos + 5) + 5 * (P.vcinco + 1) / (P.votos + 5)) - 1.96 * SQRT(((POWER(1, 2) * (P.vum + 1) / (P.votos + 5) + POWER(2, 2) * (P.vdois + 1) / (P.votos + 5) + POWER(3, 2) * (P.vtres + 1) / (P.votos + 5) + POWER(4, 2) * (P.vquatro + 1) / (P.votos + 5) + POWER(5, 2) * (P.vcinco + 1) / (P.votos + 5)) - POWER((1 * (P.vum + 1) / (P.votos + 5) + 2 * (P.vdois + 1) / (P.votos + 5) + 3 * (P.vtres + 1) / (P.votos + 5) + 4 * (P.vquatro + 1) / (P.votos + 5) + 5 * (P.vcinco + 1) / (P.votos + 5)), 2)) / (P.votos + 5 + 1)), 0) AS escore
FROM (
    SELECT S.id_filme
         , S.titulo
         , S.vcinco
         , S.vquatro
         , S.vtres
         , S.vdois
         , S.vum
         , IF ((S.vcinco + S.vquatro + S.vtres + S.vdois + S.vum) > 0, ((S.vcinco*5 + S.vquatro*4 + S.vtres*3 + S.vdois*2 + S.vum*1) / (S.vcinco + S.vquatro + S.vtres + S.vdois + S.vum)), 0) AS estrelas
         , (S.vcinco + S.vquatro + S.vtres + S.vdois + S.vum) AS votos
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
