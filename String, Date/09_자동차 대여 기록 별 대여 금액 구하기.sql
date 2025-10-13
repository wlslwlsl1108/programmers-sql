/*
 [ String, Date ] 자동차 대여 기록 별 대여 금액 구하기 (Lv4)

 [문제 설명]
 다음은 어느 자동차 대여 회사에서 대여 중인 자동차들의 정보를 담은 CAR_RENTAL_COMPANY_CAR 테이블과
 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블과
 자동차 종류 별 대여 기간 종류 별 할인 정책 정보를 담은 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블 입니다.

 CAR_RENTAL_COMPANY_CAR 테이블은 아래와 같은 구조로 되어있으며, CAR_ID, CAR_TYPE, DAILY_FEE, OPTIONS 는
 각각 자동차 ID, 자동차 종류, 일일 대여 요금(원), 자동차 옵션 리스트를 나타냅니다.

 자동차 종류는 '세단', 'SUV', '승합차', '트럭', '리무진' 이 있습니다.
 자동차 옵션 리스트는 콤마(',')로 구분된 키워드 리스트(예: ''열선시트,스마트키,주차감지센서'')로 되어있으며,
 키워드 종류는 '주차감지센서', '스마트키', '네비게이션', '통풍시트', '열선시트', '후방카메라', '가죽시트' 가 있습니다.

 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며,
 HISTORY_ID, CAR_ID, START_DATE, END_DATE 는 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블은 아래와 같은 구조로 되어있으며,
 PLAN_ID, CAR_TYPE, DURATION_TYPE, DISCOUNT_RATE 는 각각 요금 할인 정책 ID, 자동차 종류, 대여 기간 종류, 할인율(%)을 나타냅니다.

 할인율이 적용되는 대여 기간 종류로는 '7일 이상' (대여 기간이 7일 이상 30일 미만인 경우),
 '30일 이상' (대여 기간이 30일 이상 90일 미만인 경우), '90일 이상' (대여 기간이 90일 이상인 경우) 이 있습니다.
 대여 기간이 7일 미만인 경우 할인정책이 없습니다.

 [문제]
 CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블과
 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블에서 자동차 종류가 '트럭'인 자동차의 대여 기록에 대해서
 대여 기록 별로 대여 금액(컬럼명: FEE)을 구하여 대여 기록 ID와 대여 금액 리스트를 출력하는 SQL 문을 작성해주세요.
 결과는 대여 금액을 기준으로 내림차순 정렬하고, 대여 금액이 같은 경우 대여 기록 ID를 기준으로 내림차순 정렬해주세요.

 */

SELECT
    h.HISTORY_ID,
    ROUND(
            c.DAILY_FEE * (DATEDIFF(h.END_DATE, h.START_DATE) + 1) *
            (1 - IFNULL(
                         CASE
                             WHEN DATEDIFF(h.END_DATE, h.START_DATE) + 1 >= 90 THEN (
                                 SELECT DISCOUNT_RATE
                                 FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN
                                 WHERE CAR_TYPE = '트럭' AND DURATION_TYPE = '90일 이상'
                             )
                             WHEN DATEDIFF(h.END_DATE, h.START_DATE) + 1 >= 30 THEN (
                                 SELECT DISCOUNT_RATE
                                 FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN
                                 WHERE CAR_TYPE = '트럭' AND DURATION_TYPE = '30일 이상'
                             )
                             WHEN DATEDIFF(h.END_DATE, h.START_DATE) + 1 >= 7 THEN (
                                 SELECT DISCOUNT_RATE
                                 FROM CAR_RENTAL_COMPANY_DISCOUNT_PLAN
                                 WHERE CAR_TYPE = '트럭' AND DURATION_TYPE = '7일 이상'
                             )
                             ELSE 0
                             END
                     , 0) / 100)
    ) AS FEE
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY h
         JOIN CAR_RENTAL_COMPANY_CAR c
              ON h.CAR_ID = c.CAR_ID
WHERE c.CAR_TYPE = '트럭'
ORDER BY FEE DESC,
         h.HISTORY_ID DESC;


