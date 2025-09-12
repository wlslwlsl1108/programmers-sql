/*
 [ String, Date ] 대여 기록이 존재하는 자동차 리스트 구하기(Lv3)

 [문제 설명]
 다음은 어느 자동차 대여 회사에서 대여 중인 자동차들의 정보를 담은 CAR_RENTAL_COMPANY_CAR 테이블과
 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블입니다.
 CAR_RENTAL_COMPANY_CAR 테이블은 아래와 같은 구조로 되어있으며, CAR_ID, CAR_TYPE, DAILY_FEE, OPTIONS 는
 각각 자동차 ID, 자동차 종류, 일일 대여 요금(원), 자동차 옵션 리스트를 나타냅니다.

 자동차 종류는 '세단', 'SUV', '승합차', '트럭', '리무진' 이 있습니다.
 자동차 옵션 리스트는 콤마(',')로 구분된 키워드 리스트(예: '열선시트', '스마트키', '주차감지센서')로 되어있으며,
 키워드 종류는 '주차감지센서', '스마트키', '네비게이션', '통풍시트', '열선시트', '후방카메라', '가죽시트' 가 있습니다.

 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며,
 HISTORY_ID, CAR_ID, START_DATE, END_DATE 는 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

 [문제]
 CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서
 자동차 종류가 '세단'인 자동차들 중 10월에 대여를 시작한 기록이 있는 자동차 ID 리스트를 출력하는 SQL 문을 작성해주세요.
 자동차 ID 리스트는 중복이 없어야 하며, 자동차 ID를 기준으로 내림차순 정렬해주세요.
 */


-- 조회) 가격대 별, 상품 개수
SELECT
-- 조건1) 만원 단위의 가격대 별 → 컬럼명 = PRICE_GROUP
FLOOR(price / 10000) * 10000 AS PRICE_GROUP,
-- 조건2) 상품 개수  → 컬럼명 = PRODUCTS
COUNT(*) AS PRODUCTS
FROM PRODUCT
-- 만원 단위의 가격대 별로 그룹화
GROUP BY FLOOR(price / 10000) * 10000
-- 정렬) 가격대 기준으로 오름차순
ORDER BY PRICE_GROUP;


/*
      [  FLOOR(price / 10000) * 10000  ]

         -    ex. 37,000 원 경우

              1. price / 10,000 = 3.7

              2. FLOOR(3.7) = 3

              3. 3 * 10,000 = 30,000
 */

