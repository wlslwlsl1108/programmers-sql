/*
 [ JOIN ] 5월 식품들의 총매출 조회하기 (Lv4)

 [문제 설명]
 다음은 식품의 정보를 담은 FOOD_PRODUCT 테이블과 식품의 주문 정보를 담은 FOOD_ORDER 테이블입니다.
 FOOD_PRODUCT 테이블은 다음과 같으며 PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE는
 식품 ID, 식품 이름, 식품코드, 식품분류, 식품 가격을 의미합니다.
 FOOD_ORDER 테이블은 다음과 같으며 ORDER_ID, PRODUCT_ID, AMOUNT, PRODUCE_DATE, IN_DATE, OUT_DATE, FACTORY_ID, WAREHOUSE_ID는
 각각 주문 ID, 제품 ID, 주문량, 생산일자, 입고일자, 출고일자, 공장 ID, 창고 ID를 의미합니다.

 [문제]
 FOOD_PRODUCT와 FOOD_ORDER 테이블에서 생산일자가 2022년 5월인 식품들의 식품 ID, 식품 이름, 총매출을 조회하는 SQL 문을 작성해주세요.
 이때 결과는 총매출을 기준으로 내림차순 정렬해주시고 총매출이 같다면 식품 ID를 기준으로 오름차순 정렬해주세요.
 */


-- 조회) 식품 ID, 식품 이름, 총매출
SELECT p.PRODUCT_ID,
       p.PRODUCT_NAME,
-- 총매출 = [ 가격 * 판매량 ] 의 합!
       SUM(p.PRICE * o.AMOUNT) AS TOTAL_SALES
FROM FOOD_PRODUCT p
-- 식품 ID(제품 ID) 기준으로 조인
         JOIN FOOD_ORDER o
              ON p.PRODUCT_ID = o.PRODUCT_ID
-- 조건) 생산일자 = 2022년 5월
WHERE o.PRODUCE_DATE LIKE '2022-05%'
GROUP BY p.PRODUCT_ID,
         p.PRODUCT_NAME
-- 정렬1) 총 매출을 기준으로 내림차순
ORDER BY TOTAL_SALES DESC,
-- 정렬2) 식품 ID를 기준으로 오름차순
         PRODUCT_ID;

/*

      [ 주의! ]

    - GROUP BY 할 때, SELECT 절에 있는 컬럼은 다 넣어주기!
        ( 집계함수 제외 )

   - SELECT 절에 2개의 컬럼 존재 시,
     서로 1:1 관계라면 GROUP BY에 둘 중 한 컬럼만 넣어줘도 오류X

   - 만약 N:1 관계 or 중복된 항목이 있으면,
         GROUP BY 에 넣은 컬럼 기준으로 정리가 되어버린다!

        => 그룹 단위 결과 출력시, 기준이 모호해지는 것을 방지
        => 표준 SQL 에서는 모든 컬럼을 GROUP BY에 넣는 것이 원칙!
 */

