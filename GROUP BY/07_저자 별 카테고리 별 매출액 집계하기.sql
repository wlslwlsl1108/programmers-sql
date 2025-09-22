/*
 [ GROUP BY ] 저자 별 카테고리 별 매출액 집계하기 (Lv4)

 [문제 설명]
 다음은 어느 한 서점에서 판매중인 도서들의 도서 정보(BOOK), 저자 정보(AUTHOR) 테이블입니다.
 BOOK 테이블은 각 도서의 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.
 ( 도서 ID(BOOK_ID), 카테고리(CATEGORY), 저자 ID(AUTHOR_ID), 판매가(PRICE), 출판일(PUBLISHED_DATE) )

 AUTHOR 테이블은 도서의 저자의 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.
 ( 저자 ID(AUTHOR_ID), 저자명(AUTHOR_NAME) )

 BOOK_SALES 테이블은 각 도서의 날짜 별 판매량 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.
 ( 도서 ID(BOOK_ID), 판매일(SALES_DATE) , 판매량(SALES) )

 [문제]
 2022년 1월의 도서 판매 데이터를 기준으로 저자 별, 카테고리 별 매출액(TOTAL_SALES = 판매량 * 판매가) 을 구하여,
 저자 ID(AUTHOR_ID), 저자명(AUTHOR_NAME), 카테고리(CATEGORY), 매출액(SALES) 리스트를 출력하는 SQL 문을 작성해주세요.
 결과는 저자 ID를 오름차순으로, 저자 ID가 같다면 카테고리를 내림차순 정렬해주세요.

 */

-- 조회  ) 저자 ID, 저자명, 카테고리, 매출액
SELECT b.AUTHOR_ID,
       a.AUTHOR_NAME,
       b.CATEGORY,
-- 조건2) 저자 별, 카테고리 별 매출액 (TOTAL_SALES = 판매량 * 판매가)
       SUM(s.SALES * b.PRICE) AS TOTAL_SALES
FROM BOOK b
-- BOOK / AUTHOR 테이블 조인
         JOIN AUTHOR a
              ON b.AUTHOR_ID = a.AUTHOR_ID
--- BOOK / AUTHOR 테이블과 SALES 테이블 조인
         JOIN BOOK_SALES s
              ON b.BOOK_ID = s.BOOK_ID
-- 조건1) 2022년 1월 판매 기준
WHERE SALES_DATE LIKE '2022-01%'
--- 조건2) 저자 별, 카테고리 별 매출액 (TOTAL_SALES = 판매량 * 판매가)
GROUP BY a.AUTHOR_ID,
         a.AUTHOR_NAME,
         b.CATEGORY
-- 정렬1) 저자 ID 기준으로 오름차순
ORDER BY a.AUTHOR_ID,
-- 정렬2) 카테고리 기준으로 내림차순
         b.CATEGORY DESC;



