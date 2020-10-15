## ----include=FALSE--------------------------------------------------------
options(scipen=999, max.print = 50)
rm(list=ls())
## ----include=TRUE,eval=FALSE----------------------------------------------
## if (!require("pacman")) install.packages("pacman")  #**ESTO SE DEBE CORRER UNA SOLA VEZ** (!)
## 
## pacman::p_load(dplyr, sjlabelled,summarytools, ggplot2,ggExtra,lme4,texreg)


## ----include=FALSE--------------------------------------------------------
pacman::p_load(dplyr, summarytools, sjlabelled,ggplot2,ggExtra,lme4,texreg,merTools)

## ----eval=TRUE, include=TRUE----------------------------------------------
popdata <- read_spss("https://jciturras.github.io/ayudantia-sol3051/data/popular2.sav")


## ---- include=T-----------------------------------------------------------
popdata<- popdata %>% dplyr::select(pupil,class,popular,sex,extrav,texp)


## ----echo=FALSE-----------------------------------------------------------
dfSummary(popdata, headings = FALSE)


## -------------------------------------------------------------------------
popdata$female <- as_numeric(popdata$sex)         # convertir sex en numerica
ss <- sample(1:length(unique(popdata$class)), 20) # selecciona muestra de 20 cursos
#------------------------------------------------#
ggplot(popdata[popdata$class %in% ss,],
aes(female, popular)) + 
geom_smooth(method=lm, se=F) + 
geom_jitter() + 
facet_wrap(~class, ncol=5) + 
theme_bw()


## -------------------------------------------------------------------------
popdata <- popdata[order(popdata$class),]
#                    val observado  - Gran_Media     
popdata$female_gm <- popdata$female - mean(popdata$female)


## -------------------------------------------------------------------------
#Calcular media de sex (proportion de 1) para cada grupo
popdata$meanfemale <- with(popdata, tapply(female, class, mean))[popdata$class]
#                    val observado  - Media_Grupo  
popdata$female_gc <- popdata$female - popdata$meanfemale


## -------------------------------------------------------------------------
female_bar<-tapply(popdata$sex, popdata$class, mean,na.rm=T) 
popularity_bar<-tapply(popdata$popular, popdata$class, mean,na.rm=T)
#-------------------------------------------------------------------#
m_agg <-lm(popularity_bar~female_bar) 


## -------------------------------------------------------------------------
m0 <- lmer(popular ~ female + extrav +(female|class), data=popdata)


## -------------------------------------------------------------------------
#           Y_ij   ~ X_ij_gc   + (ranef|nivel2)
m1 <- lmer(popular ~ female_gc + extrav + (1|class), data=popdata)


## -------------------------------------------------------------------------
#           Y_ij   ~ X_ij_gm   +  (ranef|nivel2)
m2 <- lmer(popular ~ female_gm + extrav + (1|class),data=popdata)


## -------------------------------------------------------------------------
screenreg(l=list(m_agg,m0, m1, m2),
          custom.model.names = c("OLS","Sin centrar","Cent. Grupo","Cent. G. Media"),
          include.variance = F)


## -------------------------------------------------------------------------
#           Y_ij   ~ X_ij_gm   + W_j  + (1|nivel2)
m3 <- lmer(popular ~ female_gm + extrav + texp + (1|class),data=popdata)


## -------------------------------------------------------------------------
screenreg(l=list(m_agg,m0, m1, m2,m3),
          include.variance = F)


## -------------------------------------------------------------------------
m4a <- lmer(popular ~ female_gm +  extrav + meanfemale + (1|class),data=popdata) 
m4b <- lmer(popular ~ female_gc +  extrav + meanfemale + (1|class),data=popdata)


## -------------------------------------------------------------------------
screenreg(list(m4a,m4b))


## ----eval=FALSE, include=FALSE--------------------------------------------
## #clase: pp 24,
## fixef(m4a)["(Intercept)"]-fixef(m4a)["female_gm"]
## fixef(m4b)["(Intercept)"]-fixef(m4b)["female_gc"]


## -------------------------------------------------------------------------
#                    val observado  - Gran_Media     
popdata$extrav_gm <- popdata$extrav - mean(popdata$extrav)
#Calcular media de sex (proportion de 1) para cada grupo
popdata$meanextrav <- with(popdata, tapply(extrav, class, mean))[popdata$class]
#                    val observado  - Media_Grupo  
popdata$extrav_gc <- popdata$extrav - popdata$meanextrav


## -------------------------------------------------------------------------
m5a <- lmer(popular ~ female +  extrav+texp + (1|class),data=popdata)
m5b <- lmer(popular ~ female +  extrav_gc*texp + (extrav_gc|class),data=popdata)

## -------------------------------------------------------------------------
screenreg(list(m5a,m5b))

