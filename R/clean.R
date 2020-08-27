# devtools::install_github("richfitz/remoji")
# library(remoji)
# emj <- emoji(list_emoji(), TRUE)
# all_emojis <- do.call(paste, c(as.list(emj), sep = ""))

library(tidyverse)
library(emo)

# https://www.hvitfeldt.me/blog/real-emojis-in-ggplot2/

view_emoji <- function(string) { utf8::utf8_print(string) }

raw <- readr::read_csv('data/raw.csv')
data <- raw %>% 
  mutate(emoji = emo::ji_extract_all(message))

emoji_grouped <- data %>% 
  group_by(emoji) %>% 
  tally() %>% 
  arrange(desc(n)) %>% 
  ungroup %>% 
  # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/lengths
  mutate(length = lengths(emoji),
         emoji = paste0(emoji))

emoji_pairs <- emoji_grouped %>% 
  filter(length > 1)

data_w_emojis <- data %>% 
  mutate(emoji = paste0(emoji))

view_emoji("\U0001f3e0")

readr::write_csv(emoji_grouped, 'data/emoji_grouped.csv')
readr::write_csv(data_w_emojis, 'data/data_w_emojis.csv')
       