## -------------------------------------------------------------------------------------------------------
1+1


## -------------------------------------------------------------------------------------------------------
(100+100)/4


## -------------------------------------------------------------------------------------------------------
a <- 100 #Guardamos 100 dentro del objeto a
b <- 4   #Guardamos 4 dentro del objeto b
c <- 1+1 #Guardamos el resultado de 1+1 en c


## -------------------------------------------------------------------------------------------------------
print(a)


## -------------------------------------------------------------------------------------------------------
print(a*b) #multiplicando a x b


## -------------------------------------------------------------------------------------------------------
d <- (a*a)/b #a x a dividido b
print(d)
#O su versión abreviada:
d


## -------------------------------------------------------------------------------------------------------
d^2 #Estamos elevando al cuadrado al objeto e


## -------------------------------------------------------------------------------------------------------
 x <- 5
 y <- 16
 x<y
 x>y


## -------------------------------------------------------------------------------------------------------
 x<=5
 y>=20
 y == 16
 x != 5


## -------------------------------------------------------------------------------------------------------
TRUE|FALSE
TRUE & FALSE
!TRUE
isTRUE(TRUE)


## -------------------------------------------------------------------------------------------------------
x <- 1:20
x
z <- NA
z


## -------------------------------------------------------------------------------------------------------
z[x>=8] <- 1
z


## -------------------------------------------------------------------------------------------------------
z[x<15] <- 0
z


## -------------------------------------------------------------------------------------------------------
z <- ifelse(test = x>5, yes = 1, no = 0)
z


## -------------------------------------------------------------------------------------------------------
x <- 1:20
x[2]
x[2:3]


## -------------------------------------------------------------------------------------------------------
w <- cbind(x, z)
w


## -------------------------------------------------------------------------------------------------------
w[1,] 
w[,1]  


## -------------------------------------------------------------------------------------------------------
d <- data.frame(w)
d$x
d$z
d$x + d$z

## ---- eval=FALSE, message=FALSE, warning=FALSE, include=TRUE--------------------------------------------
## install.packages("haven") #cargar .sav (SPSS)
## library(haven) #Cargar la librería


## ----include=FALSE--------------------------------------------------------------------------------------
library(haven)

## ---- eval=FALSE, message=FALSE, warning=FALSE, include=TRUE, size="small"------------------------------
tt <- read_sav(url("https://jciturras.github.io/ayudantia-sol3051/slides/00-intro-r/data/titanic2.sav"))
tt <- read.csv(url("https://jciturras.github.io/ayudantia-sol3051/slides/00-intro-r/data/titanic.csv"))


## ---- eval=TRUE, message=FALSE, warning=FALSE, include=TRUE, results='hold'-----------------------------
class(tt) #ver el tipo de datos 
class(tt$sex) #¿qué tipo de variable es sex?
class(tt$age) #¿qué tipo de variable es age?
class(tt$pclass) #¿qué tipo de variable es pclass?
str(tt) #Contenido y estructura de la base de datos


## ---- eval=TRUE, message=FALSE, warning=FALSE, include=TRUE---------------------------------------------
summary(tt$age) #Estadísticos descriptivos
mean(tt$age) #Media de edad
sd(tt$age) #desviación estándar de edad
summary.factor(tt$sex) # ¿cuántos hombres y mujeres hay?


## ---- eval=TRUE, message=FALSE, warning=FALSE, include=TRUE---------------------------------------------
summary.factor(tt$pclass) #Con summary también podemos ver un factor
table(tt$pclass) #Otra alternativa
prop.table(table(tt$pclass)) #Vemos las proporciones
table(tt$pclass, tt$sex) #tabla cruzada sexo y clase social


## -------------------------------------------------------------------------------------------------------
table(tt$survived)
tt$surv<- ifelse(tt$survived=="Sobrevive",yes = 1,no = 0)
table(tt$surv)


## -------------------------------------------------------------------------------------------------------
logit01<- glm(formula = surv~sex+pclass,data = tt,family = "binomial")
logit02<- glm(formula = surv~sex+pclass+age,data = tt,family = "binomial")

logit02$coefficients

coef.age <- -0.03439323
coef.age

logit02$residuals
logit02$fitted.values

summary(logit02)

## -------------------------------------------------------------------------------------------------------
class(logit01)


## -------------------------------------------------------------------------------------------------------
logit01


## -------------------------------------------------------------------------------------------------------
logit01$coefficients
coef(logit01)


## ----include=FALSE--------------------------------------------------------------------------------------
options(max.print = 20)


## ----results='markup'-----------------------------------------------------------------------------------
logit01$fitted.values
logit01$residuals


## -------------------------------------------------------------------------------------------------------
summary(logit01)


# 7.2 Actividad

# 1. Empleando la base “titanic”, realice algunos procedimientos de exploración y análisis de datos.
# 
# 2.Observe el tipo de estructura de datos que está empleando.
# 
# 3. En base a la base señalada, observe su “estructura”
# 
# 4. Observe qué tipo/clase de variable es: sex, pclass, age y survived
# 
# 5. Según esto, determine cuál comando va emplear para describir las variables.
# 
# 6.Construya una tabla de contingencia (filas x columnas): survived x pclass
# 7 Estime un modelo de regresión logística para surv con los predictores sex, age y pclass.
# 
# 8. Obtenga el resumen del modelo y responda:
#   
#  * ¿Cuál es el valor del coeficiente de regresión de age?
