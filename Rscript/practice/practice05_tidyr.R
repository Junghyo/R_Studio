install.packages("tidyr") # 데이터를 정리하는데 유용
install.packages("dplyr") # 자료를 찾거나 바꾸는데 유용
require(tidyr)
require(dplyr)
help("tidyr")
help("dplyr")

member <- data.frame(family=c(1,2,3), namef=c("a","b","c"), agef=c(30,40,23),
                     namem=c("d","e","f"), agem=c(44,53,25))
member
# member에서 name, age 뒤에 오는 f와 m은 여성과 남성을 구분한 것이다.
# 이렇게만 봐도 무리가 없지만 만약 이 데이터를 가지고 여성만 보고 싶거나
# 성별에 관한 분석 등을 할 때 상당한 제약이 오게 된다.

# 이럴때 사용하는 code가 gather와 separate다.

# 단계 1 : gather
example("gather")
# gather(data, key, value, 컬럼명) data.frame의 컬럼명을 key, 그에 해당하는 값들을 value로
# 수직으로 길게 뿌려준다.
member_g <- gather(member, key, value, namef:agem)
member_g
# gather 사용시 경고문이 나오는데 gather문은 데이터를 보기 좋게 정리해주지만
# 잘못 사용하는 경우 처음의 데이터 형식을 잃어버리는 경우가 생기기에 주의하는 뜻으로 나온다.

# 단계 2 : separate
# gather문으로 data.frame을 수직으로 뿌려도 여전히 한눈에 알아보기엔 쉽지가 않다.
# name과 age 뒤에 오는 f와 m을 떼어내서 gender란 컬럼을 추가하고 f,m을 데이터로 넣는다면?
example("separate")
# separate(data, 잘라낼 컬럼, c("variable", "추가할 컬럼명"), 잘라낼 텍스트크기)
member_s <- separate(member_g, key, c("variable", "gender"), 1)
member_s
# variable에 n, a가 들어온다. 잘라낼 텍스트크기를 1로 했기 때문에 앞에 글자만 떨어진 것이다.

member_s <- separate(member_g, key, c("variable", "gender"), 4)
member_s
# 4로 조정한 결과 name과 f, m은 잘 떨어졌으나 age는 떨어지지 않는다(f,m 포함 4글자)

member_s <- separate(member_g, key, c("variable", "gender"), -2)
member_s
# -2를 줘서 뒤에서 두번째 글자부터 쪼개면 f와 m이 name이나 age에서 깔끔하게 떨어진다

# 하지만 name에 해당하는 age가 name 옆 컬럼으로 붙어야 하는데 수직으로 정렬되어 
# 아직 보기가 불편하다.

# 단계 3 : spread (gather의 반대)
# spread(data, 기존컬럼명이담긴컬럼명, 데이터가 담긴 컬럼명)
example(spread)
member_new <- spread(member_s, variable, value)
member_new

# 데이터가 잘 정렬되었다.
filter(member_new, gender=="f")
# 이렇게 간단히 여자들의 신상만 파악할 수 있다.
filter(member_new, age>=30)
# 30살 이상인 사람만

# 기존 member에서 여성의 정보만 가져오려고 한다면
select(member, family, namef, agef)
# 비슷해보일 수도 있겠지만 실제로 방대한 컬럼명과 방대한 데이터를 다룬다고 한다면
# 컬럼명을 하나하나 비교해서 하기엔 무리가 있다.
# 간단하게 30살 이상인 사람들 가져오라고 한다면?
# 쉽게 해결할 수 있을 것 같지 않다.

# 다만 위에 기존 데이터 -> gather -> separate  -> spread를 거치는게 번거로운데 
# 이를 줄여주는게 파이프라인이다.
# %>%
member %>%
gather(key, value, namef:agem) %>%
separate(key, c("variable", "gender"), -2) %>%
spread(variable, value)

# %>%를 잘 사용하기 위해선 전체적인 흐름도를 파악하는 것이 중요하다.
# 다만 익숙해진다면 로직이 어떻게 진행되는지 바로 파악할 수 있고 코딩을 좀 더 명료하게 해준다.
