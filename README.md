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


