/*
 [ JOIN ] 주문량이 많은 아이스크림 조회하기 (Lv4)

 [문제 설명]
 다음은 아이스크림 가게의 상반기 주문 정보를 담은 FIRST_HALF 테이블과 7월의 아이스크림 주문 정보를 담은 JULY 테이블입니다.
 FIRST_HALF 테이블 구조는 다음과 같으며, SHIPMENT_ID, FLAVOR, TOTAL_ORDER는
 각각 아이스크림 공장에서 아이스크림 가게까지의 출하 번호, 아이스크림 맛, 상반기 아이스크림 총주문량을 나타냅니다.
 FIRST_HALF 테이블의 기본 키는 FLAVOR 입니다.
 FIRST_HALF 테이블의 SHIPMENT_ID는 JULY 테이블의 SHIPMENT_ID의 외래 키입니다.

 JULY 테이블 구조는 다음과 같으며, SHIPMENT_ID, FLAVOR, TOTAL_ORDER 은
 각각 아이스크림 공장에서 아이스크림 가게까지의 출하 번호, 아이스크림 맛, 7월 아이스크림 총주문량을 나타냅니다.
 JULY 테이블의 기본 키는 SHIPMENT_ID 입니다.
 JULY 테이블의 FLAVOR는 FIRST_HALF 테이블의 FLAVOR의 외래 키입니다.
 7월에는 아이스크림 주문량이 많아 같은 아이스크림에 대하여 서로 다른 두 공장에서 아이스크림 가게로 출하를 진행하는 경우가 있습니다.
 이 경우 같은 맛의 아이스크림이라도 다른 출하 번호를 갖게 됩니다.

 [문제]
 7월 아이스크림 총 주문량과 상반기의 아이스크림 총 주문량을 더한 값이 큰 순서대로 상위 3개의 맛을 조회하는 SQL 문을 작성해주세요.


 */

-- 조회 ) FLAVOR
SELECT f.FLAVOR
FROM (
-- 조건2) 상반기의 아이스크림별 총 주문량
         SELECT FLAVOR, SUM(TOTAL_ORDER) AS FIRST_TOTAL
         FROM FIRST_HALF
         GROUP BY FLAVOR
     ) f
         JOIN (
-- 조건1) 7월의 아이스크림별 총 주문량
    SELECT FLAVOR, SUM(TOTAL_ORDER) AS JULY_TOTAL
    FROM JULY
    GROUP BY FLAVOR
) j
              ON f.FLAVOR = j.FLAVOR
-- 정렬 ) 총 주문량을 더한 값 기준으로 내림차순
-- 조건3) 7월 / 상반기의 총 주문량 더한 값 상위 3개
ORDER BY (f.FIRST_TOTAL + j.JULY_TOTAL) DESC
    LIMIT 3;

/*

      [ 서브쿼리 후 조인도 가능! ]

       - 최종 FLAVOR 컬럼만 조회하지만,
         아이스크림별 총 주문량(TOTAL) 에 대한 계산이 필요!

       - 서브쿼리를 사용하여
         상반기/7월 각 테이블의 맛, 아이스크림별 총 주문량 조회

       - 조회 후, 이 두테이블을 조인!

       - 그래야 아이스크림별 총 주문량 중 상위 3개 선택 가능

-----------------------------------------------------------------------------

      [ 왜? ORDER BY (f.FIRST_TOTAL + j.JULY_TOTAL) ]

       - 현재 조인이 되어 완성된 테이블은
          FLAVOR 컬럼   /   f.FIRST_TOTAL 컬럼   /   j.JULY_TOTAL 컬럼

       - 문제에서 7월/상반기 아이스크림의 총 주문량을 더한 값 기준으로
          정렬하라고 했으므로 두 값을 더한 값으로 정렬!

           => 1. 집계 함수 가능 (GROUP BY 조건 있다면 그룹별 집계, 아니면 전체 집계)
              2. 사칙연산 가능
              3. 별칭 가능

 */

