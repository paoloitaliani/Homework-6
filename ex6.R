#Exercise 1



unicef <- read.table("unicef97.txt",header=TRUE)
varnames <- names(unicef)[-1]
response <- names(unicef)[1]
unicef.full.model <- as.formula(paste(response,"~", paste(varnames,collapse=" + ")))

fullmod=lm(unicef.full.model,data = unicef)
empty <- lm(unicef$Child.Mortality~1,data=unicef)

backward=step(fullmod,direction="backward", data=unicef,verbose=F)
forward=step(empty,direction="forward",scope=unicef.full.model, data=unicef)

best=lm(unicef$Child.Mortality ~ Literacy.Fem + Drinking.Water + Polio.Vacc +  Urban.Pop + Foreign.Aid,data=unicef)
summary(best)
#test assumptions

par(mfrow=c(2,2))
plot(best,1)
plot(best,2)
plot(best,3)

#Exercise 3
library(MASS)
Sigma <-matrix(c(1,0.6,0.6,1), nrow=2)

X=list()
Y=list()
data=list()
mod=list()
mod.m2=list()
mod.m0=list()
mod.mc=list()
slm=list()
slm.mc=list()
t.p.value=list()
t.p.value.mc=list()

for (i in 1:10000){
  X[[i]] <-mvrnorm(n=50, mu=c(0,0), Sigma=Sigma)
  Y[[i]]=rnorm(n=50,mean = 0,sd=1)
  data[[i]]=cbind(X[[i]],Y[[i]])
  colnames(data[[i]])=c("X1","X2","Y")
  mod[[i]] =lm(formula = Y ~ X1+ X2, data = as.data.frame(data[[i]]))
  mod.mc[[i]] =lm(formula = Y ~ X1, data = as.data.frame(data[[i]]))
  mod.m2[[i]] =lm(formula = Y ~ X2, data = as.data.frame(data[[i]]))
  mod.m0[[i]] =lm(formula = Y ~ 1, data = as.data.frame(data[[i]]))
  slm[[i]] <- summary(mod[[i]])
  t.p.value[[i]] <- coef(slm[[i]])[2,4]
  slm.mc[[i]] <- summary(mod.mc[[i]])
  t.p.value.mc[[i]] <- coef(slm.mc[[i]])[2,4]

}


inc <- function(x){
  eval.parent(substitute(x <- x + 1))
  
}

count=0
t.p.value1=list()
t.p.value2=list()
count2=0
slm.m=list()
t.p.value.m=list()
mod.m=list()

for (i in 1:10000){
  
  t.p.value1[[i]] <- coef(slm[[i]])[2,4]
  t.p.value2[[i]] = coef(slm[[i]])[3,4]
  
  if (t.p.value1[[i]]<0.05){    #a
    inc(count)
    
  }
  if (t.p.value2[[i]]<0.05){   #b
    
    if(t.p.value1[[i]]<0.05){
      inc(count2)
      
    } 
  }  else {
    
       mod.m[[i]] =lm(formula = Y ~ X1, data = as.data.frame(data[[i]]))
      
       slm.m[[i]] <- summary(mod.m[[i]])
       t.p.value.m[[i]] <- coef(slm.m[[i]])[2,4]
       if(t.p.value.m[[i]]<0.05){
         inc(count2)
       }
      }
  
}

prop1=count/10000
prop2=count2/10000

#c

AIC=list()
AIC.mc=list()
AIC.m2=list()
AIC.m0=list()

for (i in 1:10000){
  AIC[[i]]=AIC(mod[[i]])
  AIC.mc[[i]]=AIC(mod.mc[[i]])
  AIC.m2[[i]]=AIC(mod.m2[[i]])
  AIC.m0[[i]]=AIC(mod.m0[[i]])
  
  
}
countcase=0
count3=0
for (i in 1:10000){
  if (AIC[[i]]>AIC.mc[[i]] && AIC[[i]]>AIC.m2[[i]] && AIC[[i]]>AIC.m0[[i]]){
    inc(countcase)
    if(t.p.value.mc[[i]]<0.05){
      inc(count3)
    }

   
    
  }  else if(AIC.mc[[i]]>AIC[[i]] && AIC.mc[[i]]>AIC.m2[[i]] && AIC.mc[[i]]>AIC.m0[[i]]){
    inc(count3)
    
  }

}

prop3=count3/10000

trial <- matrix(c(0.048,0.0593,0.1614), ncol=3,nrow = 1)
colnames(trial) <- c('a', 'b',"c")
rownames(trial) <- c('proportion')
