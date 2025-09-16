/*
 [ SELECT ] 재구매가 일어난 상품과 회원 리스트 구하기 (Lv2)

 [문제 설명]
 다음은 어느 의류 쇼핑몰의 온라인 상품 판매 정보를 담은 ONLINE_SALE 테이블 입니다.
 ONLINE_SALE 테이블은 아래와 같은 구조로 되어있으며
 ONLINE_SALE_ID, USER_ID, PRODUCT_ID, SALES_AMOUNT, SALES_DATE는
 각각 온라인 상품 판매 ID, 회원 ID, 상품 ID, 판매량, 판매일을 나타냅니다.
 동일한 날짜, 회원 ID, 상품 ID 조합에 대해서는 하나의 판매 데이터만 존재합니다.

 [문제]
 ONLINE_SALE 테이블에서 동일한 회원이 동일한 상품을 재구매한 데이터를 구하여,
 재구매한 회원 ID와 재구매한 상품 ID를 출력하는 SQL 문을 작성해주세요.
 결과는 회원 ID를 기준으로 오름차순 정렬해주시고 회원 ID가 같다면 상품 ID를 기준으로 내림차순 정렬해주세요.

 */


-- 조회) 재구매한 회원 ID, 재구매한 상품 ID
SELECT USER_ID,
       PRODUCT_ID
FROM ONLINE_SALE
-- 그룹화
GROUP BY USER_ID,
         PRODUCT_ID
-- 조건) 동일한 회원이 동일한 상품을 재구매한 데이터
HAVING COUNT(*) >= 2
-- 정렬1) 회원 ID 기준 오름차순
ORDER BY USER_ID,
-- 정렬2) 상품 ID 기준 내림차순
         PRODUCT_ID DESC;

/*

      [ HAVING ]

        => GROUP BY 로 묶인 결과 집합에 " 조건 " 을 주는 곳

          1. 집계 함수 결과

               - COUNT(*)
               - SUM(컬럼)
               - AVG(컬럼)
               - MAX(컬럼)
               - MIN(컬럼)


          2. 산술 연산, 비교 연산

               - ex. HAVING SUM(컬럼) / COUNT(*) > 2


          3. 다중 조건

               - AND , OR 로 연결 가능


          4. 별칭 사용

               - HAVING 절에서 별칭 사용 가능

-----------------------------------------------------------------------------

      [ WHERE    /    HAVING ]

         [ HAVING ]
             →  집계된 값(GROUP BY)에 대한 조건

         [ WHERE ]
             →  그 외 조건

 */

