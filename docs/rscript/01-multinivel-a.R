## ----include=FALSE--------------------------------------------------------------------------
knitr::opts_chunk$set(warning = FALSE,message = FALSE, cache = FALSE, results = "hold")
options(scipen=999, max.print = 50)
rm(list=ls())
options(knitr.kable.NA = '')


## ----include=FALSE--------------------------------------------------------------------------
library(dplyr)
library(summarytools)
library(sjlabelled)
library(ggplot2)
library(ggExtra)
library(lme4)
library(texreg)


## ----xaringanExtra-clipboard, echo=FALSE----------------------------------------------------
htmltools::tagList(
  xaringanExtra::use_clipboard(
    button_text = "<i class=\"fa fa-clipboard\"></i>",
    success_text = "<i class=\"fa fa-check\" style=\"color: #90BE6D\"></i>",
  ),
  rmarkdown::html_dependency_font_awesome()
)


## ----eval=FALSE, include=FALSE--------------------------------------------------------------
## knitr::purl("docs/01-multinivel-a.rmd")


## ----echo=TRUE------------------------------------------------------------------------------
popdata <- read_spss("data/popular2.sav")


## ---- include=T-----------------------------------------------------------------------------
popdata<- popdata %>% select(pupil,class,popular,sex,extrav,texp)


## ----echo=FALSE-----------------------------------------------------------------------------
print(dfSummary(popdata, headings = FALSE), method = "render")


## -------------------------------------------------------------------------------------------
popdata %>% 
  filter(class %in% c(82,74,33)) %>%
  group_by(class) %>% 
  summarise(mean_j=mean(popular),var_j=var(popular),sd_j=sd(popular)) %>% data.frame()


## ---- fig.height=5,fig.width=12-------------------------------------------------------------
popdata %>% filter(class %in% c(82,74,33)) %>% 
  ggplot() + 
  geom_density(aes(x = popular,fill=factor(class,levels = c(82,74,33))),alpha=0.3) +
  geom_vline(xintercept = mean(popdata$popular),color="red",linetype="dashed", size=1) +
  ylab("Densidad")+
  xlab("Popularidad alumno") +
  scale_fill_discrete("ID Curso")+
  theme_classic()+ 
  theme(legend.position = "top")


## -------------------------------------------------------------------------------------------
popdata <- popdata %>%  mutate(mean_i=mean(popular))  # media muestral
popdata <- popdata %>%  group_by(class) %>% mutate(mean_j=mean(popular)) # media para grupos


## ---- fig.height=5,fig.width=12-------------------------------------------------------------
p<- popdata %>% 
  ggplot() +
  geom_point(aes(y = mean_j,x = class)) +
  geom_hline(yintercept = 5.03,color="red") +
  ylab("Media popularidad (Curso)")+
  xlab("ID Curso")+
  theme_classic() + 
  geom_text(data=subset(popdata, class %in%c(82,74,33)),
            aes(y = mean_j,x = class,label=class),
            nudge_x = -1,
            nudge_y = -0.1, 
            color="blue")
ggMarginal(p, type="box",margins = 'y',fill = '#00A2FF81', size=20) 


## -------------------------------------------------------------------------------------------
m00<-lmer(popular ~ (1|class), popdata)
summary(m00)


## -------------------------------------------------------------------------------------------
sigma2_mu <- VarCorr(m00)$class[[1]]
sigma2_e <- sigma(m00)^2


## -------------------------------------------------------------------------------------------
sigma2_mu / (sigma2_mu+sigma2_e)


## ----fig.show='hold', message=FALSE, warning=FALSE, fig.width=12----------------------------
library(lattice)
qqmath(ranef(m00, condVar = TRUE))


## -------------------------------------------------------------------------------------------
m01.ri<- lmer(popular ~ sex + extrav + texp + (1 |class), popdata)
screenreg(list(m00,m01.ri), custom.model.names = c("Modelo Nulo", "Modelo 1"))


## -------------------------------------------------------------------------------------------
m01.rirs<- lmer(popular ~ sex + extrav + texp + (1+ sex + extrav |class), popdata)
screenreg(list(m01.ri,m01.rirs),custom.model.names = c("Modelo 1", "Modelo 2"))


## ----fig.width=12---------------------------------------------------------------------------
qqmath(ranef(m01.rirs))


## -------------------------------------------------------------------------------------------
m02.rirs<- lmer(popular ~  extrav*sex + texp + (1+ sex + extrav |class), popdata)


## -------------------------------------------------------------------------------------------
m03.rirs<- lmer(popular ~ sex + extrav*texp + (1+ sex + extrav |class), popdata)


## -------------------------------------------------------------------------------------------
screenreg(list(m01.rirs,m02.rirs,m03.rirs))

