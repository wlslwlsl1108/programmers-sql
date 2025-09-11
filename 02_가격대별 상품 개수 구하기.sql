/*
 [ GROUP BY ] 조건에 맞는 사용자와 총 거래금액 조회하기(Lv3)

 [문제 설명]
 다음은 어느 의류 쇼핑몰에서 판매중인 상품들의 정보를 담은 PRODUCT 테이블입니다.
 PRODUCT 테이블은 아래와 같은 구조로 되어있으며, PRODUCT_ID, PRODUCT_CODE, PRICE는
 각각 상품 ID, 상품코드, 판매가를 나타냅니다.
 상품 별로 중복되지 않는 8자리 상품코드 값을 가지며 앞 2자리는 카테고리 코드를 나타냅니다.

 [문제]
 PRODUCT 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력하는 SQL 문을 작성해주세요.
 이때 컬럼명은 각각 컬럼명은 PRICE_GROUP, PRODUCTS로 지정해주시고
 가격대 정보는 각 구간의 최소금액(10,000원 이상 ~ 20,000 미만인 구간인 경우 10,000)으로 표시해주세요.
 결과는 가격대를 기준으로 오름차순 정렬해주세요.
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

