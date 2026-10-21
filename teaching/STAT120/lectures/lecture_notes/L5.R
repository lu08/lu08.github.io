library(tidyverse)
df.child <- read.csv("unicef-changing-childhood-data.csv")

# create a smaller dataset for simplicity
df.child.small <- df.child %>%
  filter(COUNTRYNEW %in% c("United States", "Japan", "Nigeria")) %>%
  select(COUNTRYNEW, AGE, WP22110, WP22109, WP30, WP22091)


#------------------------------#
# in-class notes 10/20
#------------------------------#

boxplot(df.child.small$WP22110)
boxplot(df.child.small$WP22110 ~ df.child.small$COUNTRYNEW)

stem(df.child.small$WP22110)

hist(df.child.small$WP22110)

plot(df.child.small$WP22110, df.child.small$WP22109)
abline(a=0,b=1)


df.child.small %>%
  ggplot(aes(x = WP22110, y=WP22109, color=COUNTRYNEW)) +
  geom_point(size=0.5) +
  theme_minimal()

df.child.small %>%
  filter(WP22110 < 60) %>%
  ggplot(aes(x=COUNTRYNEW, y=WP22110)) +
  geom_violin() +
  theme_minimal()


df.child.small %>%
  filter(WP22110 < 60) %>%
  ggplot(aes(x=WP22110,fill=COUNTRYNEW)) +
  geom_histogram(bins=30, color="black") +
  theme_bw()


df.child.small %>%
  filter(WP30 %in% c(1,2)) %>%
  ggplot(aes(x=COUNTRYNEW,fill=as.factor(WP30))) +
  geom_bar()

