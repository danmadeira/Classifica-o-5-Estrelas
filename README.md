## Consultas em SQL para classificação de 5 estrelas

Existem diversos algoritmos de ordenação dos itens pela quantidade de estrelas recebidas por votos. Alguns retornam dados um tanto imperfeitos e outros são mais eficientes e fidedignos. Dois bons algoritmos, que se baseiam em inferência estatística, são a pontuação de Wilson e a aproximação Bayesiana. É possível implementar estes algoritmos diretamente na consulta (query) ao banco de dados, em linguagem SQL.

As estrelas são frequentemente usadas como símbolos para classificação. Elas são usadas pelos críticos para classificar itens como filmes, restaurantes e hotéis. A ordenação pela classificação de 5 estrelas requer atenção pois não basta ordenar apenas pelo número de estrelas, pela média, é preciso ponderar pela quantidade de votos.

A inferência estatística é a ciência de tirar conclusões sobre uma população a partir de uma amostra de itens retirados desta população. As duas principais escolas de inferência são a inferência frequentista e a inferência bayesiana. A pontuação de Wilson pertence à inferência frequentista, se baseia no limite inferior do intervalo de confiança. A aproximação Bayesiana pertence à inferência bayesiana, se baseia no limite inferior do intervalo de credibilidade. Seus nomes, aqui adotados, não são oficiais, são apenas para fins de identificação.

Servindo de cenário para as consultas, considere as duas tabelas:
```
+----------+--------------------------------+------+---------------------------------+--------------+
| id_filme | titulo                         | ano  | diretor                         | genero       |
+----------+--------------------------------+------+---------------------------------+--------------+
|        1 | Limite                         | 1931 | Mário Peixoto                   | Drama        |
|        2 | Deus e o Diabo na Terra do Sol | 1964 | Glauber Rocha                   | Drama        |
|        3 | Vidas Secas                    | 1963 | Nelson Pereira dos Santos       | Drama        |
|        4 | Cabra Marcado para Morrer      | 1984 | Eduardo Coutinho                | Documentário |
|        5 | Terra em Transe                | 1967 | Glauber Rocha                   | Drama        |
|        6 | O Bandido da Luz Vermelha      | 1968 | Rogério Sganzerla               | Policial     |
|        7 | São Paulo, Sociedade Anônima   | 1965 | Luís Sérgio Person              | Drama        |
|        8 | Cidade de Deus                 | 2002 | Fernando Meirelles e Kátia Lund | Drama, Ação  |
|        9 | O Pagador de Promessas         | 1962 | Anselmo Duarte                  | Drama        |
|       10 | Macunaíma                      | 1969 | Joaquim Pedro de Andrade        | Comédia      |
|       11 | Central do Brasil              | 1998 | Walter Salles                   | Drama        |
|       12 | Pixote, a Lei do Mais Fraco    | 1981 | Hector Babenco                  | Drama        |
+----------+--------------------------------+------+---------------------------------+--------------+

+---------+------------+----------+------+
| id_voto | id_usuario | id_filme | voto |
+---------+------------+----------+------+
|       1 |         31 |        2 |    4 |
|       2 |        123 |        8 |    5 |
|       3 |         78 |        5 |    3 |
|       4 |         31 |       11 |    5 |
|       5 |         31 |        7 |    4 |
|       6 |         59 |        8 |    5 |
|       7 |        123 |        6 |    2 |
|       8 |         86 |        2 |    5 |
|       9 |        144 |        7 |    1 |
+---------+------------+----------+------+
```

Para ilustrar o retorno das consultas, desta base de dados, as tabelas abaixo mostram os resultados do algoritmo da pontuação de Wilson e da aproximação Bayesiana. A coluna estrelas é meramente ilustrativa, para ser usada na exibição do item, junto com o título etc.

Algoritmos da pontuação de Wilson:
```
+----------+--------------------------------+----------+-------+----------------------+
| id_filme | titulo                         | estrelas | votos | escore               |
+----------+--------------------------------+----------+-------+----------------------+
|        8 | Cidade de Deus                 |   5.0000 |     2 |   0.3423719528896193 |
|        2 | Deus e o Diabo na Terra do Sol |   4.5000 |     2 |  0.26404786368925837 |
|       11 | Central do Brasil              |   5.0000 |     1 |  0.20654329147389294 |
|        7 | São Paulo, Sociedade Anônima   |   2.5000 |     2 |  0.05609380777379933 |
|        5 | Terra em Transe                |   3.0000 |     1 |   0.0546190651458835 |
|        6 | O Bandido da Luz Vermelha      |   2.0000 |     1 | 0.014634446057309567 |
|        1 | Limite                         |   0.0000 |     0 |                    0 |
|        4 | Cabra Marcado para Morrer      |   0.0000 |     0 |                    0 |
|       10 | Macunaíma                      |   0.0000 |     0 |                    0 |
|        3 | Vidas Secas                    |   0.0000 |     0 |                    0 |
|        9 | O Pagador de Promessas         |   0.0000 |     0 |                    0 |
|       12 | Pixote, a Lei do Mais Fraco    |   0.0000 |     0 |                    0 |
+----------+--------------------------------+----------+-------+----------------------+
```

Algoritmo da aproximação Bayesiana:
```
+----------+--------------------------------+----------+-------+--------------------+
| id_filme | titulo                         | estrelas | votos | escore             |
+----------+--------------------------------+----------+-------+--------------------+
|        8 | Cidade de Deus                 |   5.0000 |     2 |  2.533160774143328 |
|        2 | Deus e o Diabo na Terra do Sol |   4.5000 |     2 | 2.4586229666992505 |
|       11 | Central do Brasil              |   5.0000 |     1 |  2.228998434289566 |
|        5 | Terra em Transe                |   3.0000 |     1 | 2.0436179230674614 |
|        7 | São Paulo, Sociedade Anônima   |   2.5000 |     2 | 1.8475884925988924 |
|        6 | O Bandido da Luz Vermelha      |   2.0000 |     1 | 1.8378993069957752 |
|        9 | O Pagador de Promessas         |   0.0000 |     0 |                  0 |
|       12 | Pixote, a Lei do Mais Fraco    |   0.0000 |     0 |                  0 |
|        1 | Limite                         |   0.0000 |     0 |                  0 |
|        4 | Cabra Marcado para Morrer      |   0.0000 |     0 |                  0 |
|       10 | Macunaíma                      |   0.0000 |     0 |                  0 |
|        3 | Vidas Secas                    |   0.0000 |     0 |                  0 |
+----------+--------------------------------+----------+-------+--------------------+
```

### Referências:

- Agresti, A.; Coull, B.A. Approximate is Better than "Exact" for Interval Estimation of Binomial Proportions. The American Statistician, Vol. 52, No. 2, pp. 119-126, May 1998.

- Bourdeau, J. 5 Star Rating - Lower bound of Wilson score confidence interval for a Bernoulli parameter. May 5, 2017. Disponível em: <https://gist.github.com/julienbourdeau/77eaca0fd1e4af3fde9fe018fdf13d7d>

- Kumar, A. Wilson Lower bound Score and Bayesian Approximation for K star scale rating to Rate products. tech-that-works, January 8, 2020. Disponível em: <https://medium.com/tech-that-works/wilson-lower-bound-score-and-bayesian-approximation-for-k-star-scale-rating-to-rate-products-c67ec6e30060>

- MariaDB Server Documentation. April, 2020. Disponível em: <https://mariadb.com/kb/en/documentation/>

- McGlohon, M.; Glance, N.; Reiter, Z. Star Quality: Aggregating Reviews to Rank Products and Merchants. Proceedings of the Fourth International Conference on Weblogs and Social Media, pp. 114-121, The AAAI Press, 2010.

- Miller, E. Bayesian Average Ratings. November 6, 2012. Disponível em: <https://www.evanmiller.org/bayesian-average-ratings.html>

- Miller, E. How Not To Sort By Average Rating. February 6, 2009. Disponível em: <https://www.evanmiller.org/how-not-to-sort-by-average-rating.html>

- Miller, E. Ranking Items With Star Ratings. September 16, 2014. Disponível em: <https://www.evanmiller.org/ranking-items-with-star-ratings.html>

- Sauro, J.; Lewis J.R. Estimating Completion Rates from Small Samples Using Binomial Confidence Intervals: Comparisons and Recommendations. Proceedings of the Human Factors and Ergonomics Society Annual Meeting, Volume 49, Issue 24, pp. 2100-2104, September 1, 2005.

- Wallis, S. Binomial Confidence Intervals and Contingency Tests: Mathematical Fundamentals and the Evaluation of Alternative Methods. Journal of Quantitative Linguistics, Volume 20, Issue 3, pp. 178-208, 2013.

- Wilson, E.B. Probable Inference, the Law of Succession, and Statistical Inference. Journal of the American Statistical Association, Vol. 22, No. 158, pp. 209-212, June 1927.

- Zhang, D.; Mao, R.; Li, H; Mao, J. How to Count Thumb-Ups and Thumb-Downs: User-Rating Based Ranking of Items from an Axiomatic Perspective. Advances in Information Retrieval Theory, ICTIR 2011, Lecture Notes in Computer Science, Volume 6931, pp 238-249, Springer, 2011.
