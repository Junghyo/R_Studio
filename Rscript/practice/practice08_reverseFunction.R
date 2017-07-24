# strsplit(data, split="쪼개는 조건")
strsplit("asdsadawasdawasdwafwwwsfw", split="w") # w를 기준으로 쪼갠다.
# [1] "asdsada" "asda"    "asd"     "afsf"  (w는 사라짐)
string <- "how are you?"
strsplit(string, split=" ") # "how"  "are"  "you?"
a<- strsplit(string, split="")  # 한글자씩 쪼개짐
a; class(a) 
# [[1]][1] "h" "o" "w" " " "a" "r" "e" " " "y" "o" "u" "?" , list
paste(a) 
# [1] "c(\"h\", \"o\", \"w\", \" \", \"a\", \"r\", \"e\", \" \", \"y\", \"o\", \"u\", \"?\")"
a[[1]]
paste(a[[1]], collapse="") # "how are you?"

# 함수 만들기
# ex) how are you? -> ?uoy era woh
length(a[[1]]) # 12
nchar(string) # 12
reversed <- a[[1]][12:1]
reversed # [1] "?" "u" "o" "y" " " "e" "r" "a" " " "w" "o" "h"
paste(reversed, collapse="") # "?uoy era woh"

# reverse letter function
reversed_f <- function(x){
  proc1 <- strsplit(x, split="")
  reversed <- proc1[[1]][nchar(x):1]
  paste(reversed, collapse="")
}
a<-reversed_f("hi. how are you? nice to meet you")
reversed_f(a) # 원래대

# nchar와 length의 차이
string <- "abc"
nchar(string) # 3
length(string) # 1
v <- c("a", "b", "c")
length(v) # 3
nchar(v) # 1 1 1
v1 <- c("abc", "de")
length(v1) # 2
nchar(v1) # 3, 2
# length는 vector의 크기를 반환하고 nchar는 백터 내 각 데이터들의 크기를 반환


a <- strsplit("how are you?", split=" ")
a
length(a[[1]])
reverse <- a[[1]][3:1]
reverse
paste(reverse, collapse=" ")


# reverse word function
reverse_f <- function(x){
  x2 <- strsplit(x, split=" ")
  reverse <- x2[[1]][length(x2[[1]]):1]
  paste(reverse, collapse=" ")
}
reverse_f("how are you?")