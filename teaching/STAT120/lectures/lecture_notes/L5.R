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


#------------------------------#
# in-class notes 10/22
#------------------------------#

df.child %>%
  group_by(COUNTRYNEW) %>%
  summarise(mean_men = mean(WP22110), mean_women = mean(WP22109)) %>%
  ggplot(aes(x=mean_men, y=mean_women, label=COUNTRYNEW)) +
  #geom_point() +
  geom_label() +
  theme_bw() +
  ggtitle('Marriage-age views by country') +
  labs(x='Min for men', y='Min for women')


df.child %>%
  filter(WP22110 < 97, WP22109<97,WP22107<97 )%>%
  group_by(COUNTRYNEW) %>%
  summarise(mean_men = mean(WP22110), mean_women = mean(WP22109),
            mean_vote= mean(WP22107)) %>%
  ggplot(aes(x=mean_men, y=mean_women, size = mean_vote, label=COUNTRYNEW)) +
  geom_point() + 
  theme_bw() +
  scale_color_gradient(low="royalblue",high="rosybrown")+
  labs(size="mean age of voting") +
  geom_abline(slope=1, intercept=0, linetype='dashed') 



df.child$COUNTRYNEW %>% unique()

df.child %>%
  filter(WP22091<5, WP30<3) %>%
  filter(COUNTRYNEW %in% c("United States", "Germany",  "Japan", "Kenya")) %>%
  ggplot(aes(y=as.factor(WP22091), x= as.factor(WP30))) +
  geom_jitter() +
  theme_bw() +
  facet_wrap(~COUNTRYNEW)


?geom_jitter()


df.child %>%
  filter(WP22071 %in% 1:3, WP22072 %in% 1:3) %>%
  group_by(COUNTRYNEW) %>%
  summarise(
    mean_education = mean(WP22071),
    mean_fun = mean(WP22072),
    .groups = "drop"
  ) %>%
  ggplot(aes(x = mean_education, y = mean_fun, label = COUNTRYNEW)) +
  geom_abline(slope=1, intercept=0, linetype="dashed") +
  geom_label() +
  theme_bw() +
  labs(
    title = "Average views on digital technology by country",
    x = "Not helpful with education",
    y = "Not helpful with fun"
  )
