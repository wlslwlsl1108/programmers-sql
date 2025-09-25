/*
 [ SELECT ] 오프라인/온라인 판매 데이터 통합하기 (Lv4)

 [문제 설명]
 다음은 어느 의류 쇼핑몰의 온라인 상품 판매 정보를 담은 ONLINE_SALE 테이블과
 오프라인 상품 판매 정보를 담은 OFFLINE_SALE 테이블 입니다.
 ONLINE_SALE 테이블은 아래와 같은 구조로 되어있으며 ONLINE_SALE_ID, USER_ID, PRODUCT_ID, SALES_AMOUNT, SALES_DATE 는
 각각 온라인 상품 판매 ID, 회원 ID, 상품 ID, 판매량, 판매일을 나타냅니다.

 동일한 날짜, 회원 ID, 상품 ID 조합에 대해서는 하나의 판매 데이터만 존재합니다.

 OFFLINE_SALE 테이블은 아래와 같은 구조로 되어있으며 OFFLINE_SALE_ID, PRODUCT_ID, SALES_AMOUNT, SALES_DATE 는
 각각 오프라인 상품 판매 ID, 상품 ID, 판매량, 판매일을 나타냅니다.

 동일한 날짜, 상품 ID 조합에 대해서는 하나의 판매 데이터만 존재합니다.

 [문제]
 ONLINE_SALE 테이블과 OFFLINE_SALE 테이블에서 2022년 3월의 오프라인/온라인 상품 판매 데이터의
 판매 날짜, 상품 ID, 유저 ID, 판매량을 출력하는 SQL 문을 작성해주세요.
 OFFLINE_SALE 테이블의 판매 데이터의 USER_ID 값은 NULL 로 표시해주세요.
 결과는 판매일을 기준으로 오름차순 정렬해주시고
 판매일이 같다면 상품 ID를 기준으로 오름차순,
 상품 ID 까지 같다면 유저 ID를 기준으로 오름차순 정렬해주세요.

 */

-- 조건3) 온라인 상품 판매 데이터
-- 조회 ) 판매 날짜, 상품ID, 유저ID, 판매량
SELECT DATE_FORMAT(SALES_DATE,'%Y-%m-%d') AS SALES_DATE,
       PRODUCT_ID,
       USER_ID,
       SALES_AMOUNT
FROM ONLINE_SALE
WHERE SALES_DATE LIKE '2022-03%'

UNION ALL

-- 조건2) 오프라인 상품 판매 데이터
-- 조회 ) 판매 날짜, 상품ID, 유저ID, 판매량
SELECT DATE_FORMAT(SALES_DATE,'%Y-%m-%d') AS SALES_DATE,
       PRODUCT_ID,
-- 조건4) OFFLINE_SALE 테이블 판매 데이터의 USER_ID 값은 NULL 표시
       NULL AS USER_ID,
       SALES_AMOUNT
FROM OFFLINE_SALE
-- 조건1) 2022년 3월
WHERE SALES_DATE LIKE '2022-03%'

-- 정렬1) 판매일 기준으로 오름차순
ORDER BY SALES_DATE,
-- 정렬2) 상품ID 기준으로 오름차순
         PRODUCT_ID,
-- 정렬3) 유저ID 기준으로 오름차순
         USER_ID;

/*

      [ 시도1) FULL OUTER JOIN ]

       - MySQL에서는 FULL OUTER JOIN 지원X
       - LEFT JOIN + RIGHT JOIN  을 UNION  해줘야 동작 동일

         예시)
           -- LEFT JOIN 부분 (온라인 기준, 오프라인 매칭 여부 확인)
           -- 온라인 데이터 기준으로 오프라인 데이터 있으면 붙이고 없으면 NULL
           SELECT
               DATE_FORMAT(n.SALES_DATE, '%Y-%m-%d') AS SALES_DATE,
               n.PRODUCT_ID                          AS PRODUCT_ID,
               n.USER_ID                             AS USER_ID,      -- 온라인 USER_ID
               n.SALES_AMOUNT                        AS SALES_AMOUNT  -- 온라인 SALES_AMOUNT
           FROM ONLINE_SALE n
           LEFT JOIN OFFLINE_SALE f
             ON n.PRODUCT_ID = f.PRODUCT_ID
            AND n.SALES_DATE = f.SALES_DATE
           WHERE n.SALES_DATE LIKE '2022-03%'

           UNION

           -- RIGHT JOIN 부분 (오프라인 기준, 온라인 매칭 여부 확인)
           -- 오프라인 데이터 기준으로 온라인 데이터 있으면 붙이고 없으면 NULL
           ELECT
               DATE_FORMAT(f.SALES_DATE, '%Y-%m-%d') AS SALES_DATE,
               f.PRODUCT_ID                          AS PRODUCT_ID,
               NULL                                   AS USER_ID,      -- 오프라인은 항상 NULL
               f.SALES_AMOUNT                        AS SALES_AMOUNT  -- 오프라인 SALES_AMOUNT
           FROM ONLINE_SALE n
           RIGHT JOIN OFFLINE_SALE f
             ON n.PRODUCT_ID = f.PRODUCT_ID
            AND n.SALES_DATE = f.SALES_DATE
           WHERE f.SALES_DATE LIKE '2022-03%'

           ORDER BY SALES_DATE,
                    PRODUCT_ID,
                    USER_ID;

-----------------------------------------------------------------------------

      [ COALSCE ]

       - 두 테이블 중 NULL 아닌 값을 선택해서 하나의 값으로 만듦
       - 이번 문제는 사실상 필요 X  →   겹치는 데이터 없으므로!

-----------------------------------------------------------------------------

      [ 왜? LEFT JOIN + RIGHT JOIN 안해줘도 가능한지? ]

       - 이번 문제는 조건에서
          " 동일한 날짜, 상품 ID 조합에 대해서는 하나의 판매 데이터만 존재 "

              → 온라인 / 오프라인 데이터가 서로 겹치지 않음

       - 즉, 단순히 온라인과 오프라인 데이터를 합치면 됨

-----------------------------------------------------------------------------

      [ UNION ALL ]

       - 단순히 두 결과를 합쳐서 그대로 반환
       - 중복된 행도 그대로 남음  →  중복 검사 안해서 빠름
       - 조건절 WHERE) 테이블에 각각 별도로 걸어줘야 함
       - 정렬 ORDER BY) 마지막에 전체 결과에 대해 한 번만 정렬 가능

-----------------------------------------------------------------------------

      [ UNION ]

       - 두 결과를 합치고, 중복 행 제거
       - 내부적으로 DISTINCT 연산 수행  →  속도는 UNION ALL 보다 느
       - 조건절 WHERE) 테이블에 각각 별도로 걸어줘야 함
       - 정렬 ORDER BY) 마지막에 전체 결과에 대해 한 번만 정렬 가능
 */

