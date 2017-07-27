x <- c(1:10)
y <- x^2-x+1

# type = n 아무것도 표시하지 않음
plot(y~x, type="n")

# plot pane 2행 4열로 설정
par(mfrow=c(2, 4))

# pch
for(i in 9:16){
  plot(y~x, type="p", col="blue", pch=i)
}

# type
type = c("p", "l", "o", "b", "c", "s", "S", "h" )

for(i in 1:8){
  plot(y~x, type=type[i], col="blue")
}
