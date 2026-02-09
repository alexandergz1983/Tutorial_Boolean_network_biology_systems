# estos son comentarios

# siempre comentar cada linea de codigo lo mas detalladamente

# saber donde estamos para cargar nuestros ficheros

# getwd("Documents/biologia_de_sistemas_posgrado/material_redes_booleanas/")

# windows
# setwd("C:/Users/") 

# cargar libreria boolnet
# podemos instalarla desde linea de comandos de R linea de comando install.packages("boolnet")
# o desde Rstudio (packages, install, nombre del paquete "boolnet")

# install.packages("BoolNet")

# cargamos libreria

setwd(getwd())

library(BoolNet)

# boolnet, tiene una seria de funciones escritas para llevar a cabo
# analisis de redes booleanas.

# cargaremos nuestra red de juguete que no es más que un archivo
# de texto plano, con extensión ".txt"

net <- loadNetwork("red_ejemplo.txt")
net

# net, nos permitira ver las caracteristcas del fichero
# el interprete de R nos muestra el archivo
# la primera linea tiene que decir: targets, factor
# targets: son las variables independientes
# cuidado: no dejar espacios en blanco al final de cada linea.

# si quisieramos ver la red, el dibujo del cual partimos (la abstracción del sistema)

plotNetworkWiring(net)

# podeis observar que, el input se ve como un auto-loop
# para decirnos que, "a" al tiempo (t) más 1, es igual "a" al tiempo (t)

# para ver la configuración de todos los atractores, utilizamos:

# NOTA ATRACTORES:

# SIMPLES:
# Los atractores simples se dan en redes booleanas síncronas y temporales 
# y consisten en un conjunto de estados cuyas transiciones síncronas forman un ciclo.

# COMPLEJOS:
# Los atractores complejos o laxos son la contrapartida de los atractores simples en las redes asíncronas. 

# Como suele haber más de una transición posible para cada estado en una red asíncrona, 
# un atractor complejo está formado por dos o más bucles superpuestos. Precisamente, un atractor complejo 
# es un conjunto de estados en el que todas las transiciones de estado asíncronas conducen a otro estado del conjunto, 
# y se puede llegar a un estado del conjunto desde todos los demás estados del conjunto.

# Los atractores de estado estable son atractores que constan de un solo estado. 

# Todas las transiciones desde este estado conducen al propio estado. 

# Estos atractores son los mismos tanto para la actualización sincrónica como asincrónica de una red. 

# Los estados estacionarios son un caso especial tanto de los atractores simples como de los atractores complejos

# La "función getAttractors()" incorpora varios métodos para la identificación de atractores en redes síncronas y asíncronas. 
# Presentamos estos métodos utilizando como ejemplo la red del ciclo celular mam- maliano incluida. 

attr <- getAttractors(net)
attr

# nos describe las caracteristicas de cada atractor.
# por ej: el atractor 1 (000) es de punto fijo, es decir:
# que consiste de un solo estado.


# verlo de esta forma, no es muy intuitivo
# para ello, entonces utilizamos el sgte comando:
  
plotAttractors(attr)

# nos resume graficamente todos los posibles estados
# nos muestra todos los posibles atractores del sistema (en este caso 4)
# rojo (apagado), verde (encendido)
# cada renglon representaria el estado de los genes
# cada columna representa un atractor
# ejm: para el actractor #1 los genes a,b,c (0,0,0) estan apagados
# ejm: para el atractor #2 el gen a y b están encendidos y c esta apagado = (1,1,0)
# deberian versen unas lineas que muestran el tamaño de la basjia de atracción (en el mio no se ve)
# 27.5 estados pertencen  a la basija del atractor 1


# otra  alternativa es imprimir sólo los nombres de los genes activos 
# (es decir, los genes que se establecen en 1) en lugar del vector completo llamando al método print()

print(attr, activeOnly=TRUE)

# La función getAttractorSequence() puede utilizarse para obtener la secuencia de estados que constituyen 
# un atractor síncrono específico en forma de tabla

getAttractorSequence(attr, 2)

# si quisieramos ver un subset de nuestros atractores usamos: "subset= #"

plotAttractors(attr, subset=2)

# búsqueda exhaustiva, aparte de los propios atractores,
# se calcula la tabla de transición completa

tt <- getTransitionTable(attr)
tt

# En la tabla impresa, la primera columna indica el estado inicial, 
# la segunda columna contiene el estado después de la transición, 
# la primera columna contiene el número del atractor al que se llega finalmente desde este estado 
# y la cuarta columna enumera el número de transiciones de estado necesarias para alcanzar este atractor.

# Una tabla con la misma estructura es devuelta por

getBasinOfAttraction(attr, 1)

# que extrae todos los estados de la tabla de transición que pertenecen a la cuenca de atracción del atractor uno 
# (es decir, cuyo número de atractor en la columna 3 es 1).
# Si le interesa obtener información sobre un solo estado (en este caso, el estado en el que todos los genes están establecidos en 1), 
# puede escribir:

getStateSummary(attr, c(1,1,1))

# La función de visualización getStateGraph() también utiliza la tabla de transición: 
# traza un gráfico de transición en el que las cuencas de atracción se dibujan en diferentes colores 
# y los atractores se resaltan. El resultado de:

plotStateGraph(attr)

# La llamada anterior no garantiza que las cuencas de atracción estén claramente separadas en el gráfico. 
# Si se desea, se puede optar por utilizar un diseño por partes, lo que significa que la función de diseño 
# se aplica por separado a cada cuenca de atracción y las cuencas se dibujan una al lado de la otra. El resultado de

plotStateGraph(attr, piecewise=TRUE)

# Cada nodo representa un estado de la red, y cada flecha es una transición de estado. 
# Los colores marcan diferentes cuencas de atracción. 
# Los atractores se resaltan con líneas en negrita.


### PERTURBAR EL SISTEMA ####

# ya podemos simular mutantes
# es decir, perturbaciones de la red
# asumiendo que los c-genes esta siempre off
# es decir, vamos a mutar los nodos de la red, para ver su comportamiento
# por ej: cuales son los atractores de la red, si asumimos que el tercer nodo (gen)
# este siempre encendido

mut= getAttractors(net, genesOFF=c(0,0,1))
mut

# resultado: obtenemos solo dos atractores y se pierden otros dos, luego de la perturbación
# de los nodos (genes) del sistema

# podemos visualizarlo de nuevo, para comprobar que es verdad.

plotAttractors(mut)

# si regresarmos a nuestra red silvestre, sin mutaciones,
# podemos preguntarnos, ¿a que atractor converjo cuando inicio en la
# condición inicial (1,0,0)

getPathToAttractor(net, c(1,0,0))

# nota: el tipo de reglas logicas utilizadas en nuestro ejemplo, es decir,
# la forma de actualizar nuestro sistema es forma sincrona (todos los nodos
# se actualizan al mismo tiempo). los nodos al tiempo (t) y al tiempo (t+1)
# responden al mismo tiempo.

# en getPathToAttractor(net, c(1,0,0)): 1 corresponde a (t)
# 2 corresponde a (t+1)
#   a b c
# 1 1 0 0
# 2 1 1 0

# podriamos entonces, implementar metodos asincronos, es decir,
# pedir que las actualizacion se ejecuten de manera asincronica
# primero una regla y luego otra y así...
# actualizar un nodo y ver que ocurre.
# con boolnet, tambien lo podemos hacer para ver la robustez del sistema
# con ello, podriamos establecer si los actractores del sistemas son artefactos del metodo computacional.
# es decir, nos quedariamos con los actractores que son asincronos.
# esto es una forma de evaluar la robustez del sistema

# podemos ejecutar entonces la sgte función en boolnet:

att_asymchrom=getAttractors(net, type="asynchronous")

# y luego:

plotAttractors(att_asymchrom)

# para ver la configuración de los atractores

# podeis observar que, todo lo explicado manualmente en la clase anterior lo podemos
# analizar rapidamente en "R", tambien podemos canalizar redes mucho mas grandes,
# podemos simular perturbaciones, ver que pasa cuando cambiamos las reglas lógicas
# por ej: cambiar en esta red, el "and" por un "or" y ver que pasa.
# ver que tanto cambian los actractores, ver que tanto cambia el porcentaje de condiciones
# inicicales que convergen a un atractor "x"

# ahora vosotros manipular el sistema y observad que pasa


# AHORA VOSOTROS MODIFICAR LAS REGLAS LOGICAS, POR EJEMPLO EL "AND" POR EL "OR"
# DISCUTIR QUE PASA



# AHORA PUEDES SEGUIR LOS PASOS ANTERIORES USANDO ESTE EJEMPLO DISPONIBLE DIRECTAMENTE
# DESDE BOOLNET:

setwd(getwd())

net <- loadNetwork("cellcycle.txt")
net
plotNetworkWiring(net)

attr <- getAttractors(net)
attr

plotAttractors(attr)

print(attr, activeOnly=TRUE)

getAttractorSequence(attr, 2)

plotAttractors(attr, subset=2)

tt <- getTransitionTable(attr)
tt

getBasinOfAttraction(attr, 1)

getStateSummary(attr, c(1,1,1,1,1,1,1,1,1,1))

plotStateGraph(attr)

plotStateGraph(attr, piecewise=TRUE)

mut= getAttractors(net, genesOFF=c(0,0,1,1,1,0,1,1,1,1)) 
mut

plotAttractors(mut)

getPathToAttractor(net, c(1,1,1,1,1,1,1,1,1,1))

att_asymchrom=getAttractors(net, type="asynchronous")

plotAttractors(att_asymchrom)

# https://sysbio.uni-ulm.de/?Software:ViSiBooL
# https://booleangenenetworks.math.iastate.edu/
