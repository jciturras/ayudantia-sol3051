#################################################
# INTRODUCCION A R -  Julio César Iturra Sanhueza; jcturra@uc.cl  
#################################################



# ALGUNOS TIPS ------------------------------------------------------------

#(1) CTRL + ENTER = ejecutar una línea de código
#(2) CTRL + SHIFT + R = Insertar sección, esto permite orderan su código
#(3) El símbolo "#" sirve para crear comentarios.
#(4) ALT + "-", es posible crear un "<-", sirve para crear sus objetos.


# Esta es una nueva sección -----------------------------------------------

# 1. El Entorno de R-Studio
#   - Script: Es aquí donde escribimos la sintaxis.
#   - Consola: Donde vemos nuestros resultados.
#   - Environment: Donde se guardan nuestros objetos.

# 1.1. Paquetes

#La gracia de R es que es posible emplear paquetes de otros usuarios. 
#Estos paquetes deben ser instalados y "llamados" a su sesión. 
#A continuación hay un par de ejemplos.

install.packages("paquete") #Aquí instalo el paquete que necesito
library(paquete) #Luego lo "llamo" a mi sesión. Cargamos el paquete.
## Solo se instala una vez el paquete, después solo se llama o carga en la sesión

# 2. Cargar bases de datos

# 2.1 Determinar nuestro espacio de trabajo ---------------------------------------------

#Siempre se deben usar / en la ruta para que R logre captar su dirección
#de lo contrario, no se leerá adecuadamente.

setwd("/aqui/va/nuestra/carpeta/de/trabajo")
setwd("C:/Users/JC/Dropbox/ayudantias magister/Ayudantía UDP/Intro a R") #este es en mi PC


#2.2 Installar y cargar paquetes ---------------------------------------------

install.packages("haven") #Instalar "haven"
library(haven) #Cargar paquete.

tt <- read_sav("titanic2.sav") #en SPSS del paquete haven
tt <- read.csv("titanic.csv") #en CSV

class(tt$pclass)
class(tt$sex)

# Analicemos nuestros datos -----------------------------------------------

#Recordemos:

str(mi.base) #es el contenido y estructura de su fuente de datos.
class(x) #permite saber el tipo de variable/objeto estoy manipulando

summary(x) #Permite obtener estadísticos descriptivos
           #Si se aplica sobre un data.frame, obtenemos los descriptivos de todas las variables.
        

summary.factor(x) #fuerza a b a ser un factor y obtenemos el recuento.
table(x) #permite obtener el recuento de una o más variables
        
table(x,y) #es una forma de crear tablas de contingencia (fila, columna)

prop.table(table(x,y)) #Nos muestra las proporciones de nuestra tabla de contingencia.


# Exploración gráfica -----------------------------------------------------

plot(tt$survived) #Un gráfico de barras simple par el Estatus de sobrevivencia.

hist(tt$sibsp) # Un histograma para el número parientes a bordo

# Si queremos guardar nuestro gráfico para usarlo después:

jpeg("migrafico.jpg") #Lo guardamos en JPEG
hist(tt$sibsp) #aquí va el comando del gráfico
dev.off() #termina el proceso

pdf("migrafico.pdf") #Lo guardamos en PDF
hist(tt$sibsp) #aquí va el comando del gráfico
dev.off() #termina el proceso


# Actividad ---------------------------------------------------------------

#1. Observe el tipo de estructura de datos que está empleando.
#2. En base a la base señalada, observe su "estructura" 
#3. Observe qué tipo/clase de variable es:
      # - sex
      # - pclass 
      # - age
      # - survived
#4. Según esto, determine cuál comando va emplear para describir las variables.
#5. Construya una tabla de contingencia (filas x columnas): 
#
#                      survived x pclass
#
#. Explore gráficamente la variable age y pclass

