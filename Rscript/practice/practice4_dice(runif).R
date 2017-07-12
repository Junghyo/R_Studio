# unifrom distribution simulate(dice)
# p = 1/n, n of die = 6
roll <- 1000000
die <- ceiling(runif(roll)*6)
die
die_tb <- table(die)
die_tb
barplot(die_tb)
# 던진 횟수(roll)가 많을수록 각 주사위의 빈도수가 비슷해진다.

# sum of two dice
dice1 <- ceiling(runif(roll)*6) # 주사위 1개
dice2 <- ceiling(runif(roll)*6) # 주사위 1개 더
all <- dice1+dice2 # 두 눈의 합
all_tb <- table(dice_all) # table화
all_tb
barplot(all_tb)
# 2 : (1,1)
# 3 : (1,2), (2,1)
# 4 : (1,3), (3,1), (2,2)
# 5 : (1,4), (4,1), (2,3), (3,2)
# 6 : (1,5), (5,1), (2,4), (4,2), (3,3)
# 7 : (1,6), (6,1), (2,5), (5,2), (3,4), (4,3)
# 8 : (2,6), (6,2), (3,5), (5,3), (4,4)
# 9 : (3,6), (6,3), (4,5), (5,4)
#10 : (4,6), (6,4), (5,5)
#11 : (5,6), (6,5)
#12 : (6,6)
# barchart를 보면 이런 모양으로 나옴
# 2가 나올 조건 : 1가지
# 7이 나올 조건 : 6가지
all_tb[1]*6   # 2 : 17028
all_tb[6]     # 7 : 16632
all_tb[11]*6  # 11: 16482
# 비슷하게 나온다. 주사위를 던지는 횟수가 많아질수록 빈도가 동일하게 나올꺼라 예상
jpeg("C:/R_Studio/Rscript/practice/p6_dice.jpg")
dev.off()
