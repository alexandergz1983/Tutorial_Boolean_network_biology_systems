# Boolean_network
System Biology
## Modelo de una red para el ensamblaje de comunidades de plantas y polinizadores ##

**Reference:** Campbell, C., Yang, S., Albert, R., & Shea, K. (2011). A network model for plant-pollinator community assembly. Proceedings of the National Academy of Sciences of the United States of America, 108(1), 197–202. https://doi.org/10.1073/pnas.1008204108

A continuación se muestra un script “completo” en Python en el que tomando como base la **Figura 1 (red de 3 plantas y 2 polinizadores)** se define una “semilla” para generar el modelo de forma automática para las Figuras 3 a 7, siguiendo estrictamente los Materials and Methods del artículo. **En este modelo se utiliza un esquema Booleano–ponderado (con umbral T = 1) en el que las interacciones positivas tienen un peso variable (PEW = 1, 2, 3 o 4) y las interacciones negativas siempre tienen peso –1.**

El script simula, para cada tamaño de red (definido como el número total de especies; en cada red se usan igual número de plantas y polinizadores) y para cada valor de PEW, un ensamble de 1000 redes generadas aleatoriamente (siguiendo la metodología del artículo: asignación de grados a partir de una ley de potencia con corte, asignación de valores de rasgo a partir de una skew normal y clasificación de las interacciones en función del “match” de rasgos). Luego, para cada red se estudia la dinámica (usando actualización síncrona, con la regla
  estado_i(t+1) = 1 si (∑_j [estado_j(t)·E(j,i)] ≥ 1, 0 en otro caso), con E(j,i) asignado según el criterio descrito) mediante un muestreo Monte Carlo (simulando 1000 estados iniciales aleatorios). Se extraen las siguientes métricas:


• Número único de atractores (la Figura 3 muestra el “número promedio de atractores” en cada ensamble; se separa en “A–D” según PEW).
• La fracción (basin) de estados iniciales que convergen a estados estables (SS) o a ciclos límite (LC) (Figura 4).
• El número promedio de pasos necesarios para alcanzar un atractor (Figura 5).
• El “acuerdo normalizado” promedio en LC, calculado como el promedio de las similitudes (por pares) entre los estados que conforman el ciclo (Figura 6).
• La fracción de especies presentes en el atractor, separada en SS (superior) y LC (inferior) (Figura 7).

En las Figuras 3 a 7 se generan las curvas en función del tamaño del “pool” de especies (con redes que varían, por ejemplo, de 10 a 100 nodos) y se distinguen los resultados para cada PEW (1–4).

**IMPORTANTE:**

**–** Para efectos de demostración se usan números modestos (por ejemplo, tamaños de red entre 10 y 50, 1000 redes por tamaño y 1000 trayectorias por red). Para replicar el estudio original se deben usar los valores exactos.

**–** El script a continuación incorpora la generación aleatoria de redes según los Materials and Methods, **la simulación de la dinámica mediante un muestreo Monte Carlo** y la generación de las figuras con leyendas similares a las del artículo.
