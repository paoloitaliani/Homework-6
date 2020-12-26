# Exercise 1

On the Virtuale page of the course (under Data Sets) you find the dataset
unicef97.dat. You can read it using
unicef <- read.table("unicef97.dat",header=TRUE)
This data set was published by the United Nations Children’s Fund UNICEF 1997.
It contains information on 121 countries in 1995/96. It was of particular interest to
make statements about factors influencing child mortality in the different countries.
The dataset contains the following variables:

-Child.Mortality child mortality rate (deaths before the age of 5 per 1000 births)
-Literacy.Fem literacy among females compared to males in percent
(ie, 100 means that female literacy equals male literacy)
-Literacy.Ad literacy among adults in percent
-Drinking.Water percentage of population with access to safe drinking water
-Polio.Vacc percentage of one-year olds vaccinated against polio
-Tetanus.Vacc.Preg percentage of pregnant women vaccinated against tetanus
-Urban.Pop percentage of population living in urban areas
-Foreign.Aid received foreign aid as percentage of GDP

You can get abbreviated country names by
row.names(unicef)
Find an appropriate linear regression model explaining the response variable Child.Mortality
by some or all of the other variables. Interpret your final model, and comment on
the appropriateness of the model assumptions.

# Exercise 2

Consider a situation with three variables Y, x1, x2 taking values Yi
, x1i
,
and x2i
, i = 1, . . . , n, where it is of interest to model
Yi = β0 + β1x1i + β2x2i + ei
, ei ∼ N (0, σ2
) iid, (1)
and to test whether variable x1 has an impact of Y . Assume that the truth is
β0 = β1 = β2 = 0, Yi = ei
, ei ∼ N (0, 1), (2)
and x1i and x2i are also both normally distributed1 with mean 0 and variance 1,
with (x1i
, x2i) iid for different i = 1, . . . , n. x1i and x2i
jointly normally distributed2
with correlation (here equal to the covariance) ρ(x1i
, x2i) = 0.6.
Run a simulation study in which you explore the effect of variable selection in model
(1) on the result of testing the null hypothesis β1 = 0 by generating 10,000 datasets
with n = 50 according to the true model (2) given above. For each dataset, test the
H0 : β1 = 0 using the standard t-test according to the following methods:

(a) Just fit model (1) and use the t-test for H0 : β1 = 0.

(b) Fit model (1) and test H0 : β2 = 0 first. If β2 is significant, use the fit of
model (1) to use the t-test for H0 : β1 = 0. If β2 is not significant, refit a
model without variable x2 and use that model to test H0 : β1 = 0.

(c) Fit all four possible models (without any x-variable, with x1 only, x2 only, or
with both of them)34 and select the one that has the best AIC (you can use the
AIC-function to do that). Use a t-test for H0 : β1 = 0 in the selected model
only if x1 was selected (otherwise don’t run a test).
For all 10,000 datasets (for method (c) only for those datasets that select models
that include x1), save the p-values of the resulting t-tests.

What are the proportions of how often H0 : β1 = 0 is rejected by to the three
methods at level α = 0.05? (According to standard theory ignoring model selection
it should be 5%.)
Hint: The required p-values are accessible using
slm <- summary(lmout)
t.p.value <- coef(slm)[2,4]
where lmout is the output object of lm, the number 2 in [2,4] assumes that β1 is
the second coefficient to be fitted (the intercept is by default the first one, so you
should normally get β1 as second coefficient), and the number 4 is there because
column 1 is the estimate, column 2 its standard error, column 3 the t-statistic and
column 4 its p-value.
You don’t need to do the following for getting the exercise points, but it may also
be interesting to see how often the F-test testing the H0 that Y does not depend on
any of the x-variables is significant according to the three methods (again standard
theory ignoring model selection suggests 5%). F-test p-values are not stored in the
lm-object, and need to be extracted as follows:
f.p.value <- pf(slm$fstatistic[1], slm$fstatistic[2], slm$fstatistic[3],
lower.tail = FALSE)
In fact you only need to add something like this to your simulation of all the other
stuff in order to try this out as well.
