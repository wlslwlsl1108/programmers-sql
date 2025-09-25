/*
 [ GROUP BY ] 대여 횟수가 많은 자동차들의 월별 대여 횟수 구하기 (Lv3)

 [문제 설명]
 다음은 어느 자동차 대여 회사의 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블입니다.
 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며,
 HISTORY_ID, CAR_ID, START_DATE, END_DATE 는 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

 [문제]
 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서
 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상인 자동차들에 대해서
 해당 기간 동안의 월별 자동차 ID 별 총 대여 횟수(컬럼명: RECORDS) 리스트를 출력하는 SQL 문을 작성해주세요.
 결과는 월을 기준으로 오름차순 정렬하고, 월이 같다면 자동차 ID를 기준으로 내림차순 정렬해주세요.
 특정 월의 총 대여 횟수가 0인 경우에는 결과에서 제외해주세요.

 */

-- 조회 ) MONTH, CAR_ID, RECORDS
-- 조건4) 대여 시작 월
SELECT MONTH(START_DATE) AS MONTH,
    CAR_ID,
-- 조건3) 월별 자동차 ID 별 총 대여 횟수(RECORDS)
    COUNT(*) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
-- 조건1) 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지
WHERE START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
  AND CAR_ID IN(
-- 서브쿼리
-- 조건2) 총 대여 횟수가 5회 이상인 자동차만 추출
    SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
    GROUP BY CAR_ID
    HAVING COUNT(*) >= 5
    )
GROUP BY MONTH(START_DATE),
    CAR_ID
-- 조건5) 특정 월의 총 대여 횟수가 0인 경우 제외
HAVING COUNT(*) > 0
-- 정렬1) 월을 기준으로 오름차순
ORDER BY MONTH,
-- 정렬2) 자동차 ID를 기준으로 내림차순
    CAR_ID DESC;



