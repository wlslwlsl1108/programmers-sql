/*
 [ String, Date ] 자동차 대여 기록에서 장기/단기 대여 구분하기 (Lv1)

 [문제 설명]
 다음은 어느 자동차 대여 회사의 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블입니다.
 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며,
 HISTORY_ID, CAR_ID, START_DATE, END_DATE 는
 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

 [문제]
 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일이 2022년 9월에 속하는 대여 기록에 대해서
 대여 기간이 30일 이상이면 '장기 대여' 그렇지 않으면 '단기 대여' 로 표시하는 컬럼(컬럼명: RENT_TYPE)을 추가하여
 대여기록을 출력하는 SQL 문을 작성해주세요.
 결과는 대여 기록 ID를 기준으로 내림차순 정렬해주세요.
 START_DATE와 END_DATE의 경우 예시의 데이트 포맷과 동일해야 정답처리 됩니다.

 */

-- 조회  ) 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일
SELECT HISTORY_ID,
       CAR_ID,
       DATE_FORMAT(START_DATE, '%Y-%m-%d') AS START_DATE,
       DATE_FORMAT(END_DATE, '%Y-%m-%d') AS END_DATE,
-- 조건2) 대여 기간일이 30일 이상이면 '장기 대여'
       CASE
           WHEN DATEDIFF(END_DATE, START_DATE) +1 >= 30 THEN '장기 대여'
-- 조건3) 그 외에는 '단기 대여'
           ELSE '단기 대여'
-- 조건4) 컬럼(RENT_TYPE) 추가
           END AS RENT_TYPE
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
-- 조건1) 대여 시작일이 2022년 9월
WHERE START_DATE LIKE '2022-09%'
-- 정렬  ) 대여 기록 ID 기준으로 내림차순
ORDER BY HISTORY_ID DESC;

/*

      [ 주의! DATEDIFF 사용 시 시작일은 제외됨 ]

       - DATEDIFF(END_DATE, START_DATE)
              = [ END_DATE ] - [  START_DATE ]

          즉, 기간 계산할 때 사용!

       - 그러나 시작일 제외하고 계산 되므로,
         위와 같은 경우는 시작일 포함해서 계산되도록 +1 해주어야 함!

          => 안그러면 오류 발생!

 */

