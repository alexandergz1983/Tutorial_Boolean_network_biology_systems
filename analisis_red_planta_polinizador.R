# Titulo: Comunidades ecologicas con redes booleanas

# Nombre: Biología de sistemas

# Fecha: 2024
#######################################################################################

# cargar librerias
library(BoolNet)

# establecer directorio de trabajo
# setwd()
# cargar red
net <- loadNetwork("/Volumes/KINGSTON/redes_booleanas_clase2025-2/comunidades_ecologicas_planta_polinizador/red_planta_polinizador.txt")
net

# mostrar la red
plotNetworkWiring(net)

# obtener atractores
attr <- getAttractors(net)
attr

# mostrar atractores
plotAttractors(attr)
plotStateGraph(attr) 

# empezamos en (0,1,1,1,1) y preguntamos a que atractor vamos a llegar
path <- getPathToAttractor(net, c(0,1,1,1,1))
path

plotSequence(sequence=path)

