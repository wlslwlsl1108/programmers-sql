/*
 [ String, Date ] 자동차 평균 대여 기간 구하기 (Lv2)

 [문제 설명]
 다음은 어느 자동차 대여 회사의 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블입니다.
 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며,
 HISTORY_ID, CAR_ID, START_DATE, END_DATE 는
 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

 [문제]
 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 평균 대여 기간이 7일 이상인 자동차들의 자동차 ID와
 평균 대여 기간(컬럼명: AVERAGE_DURATION) 리스트를 출력하는 SQL 문을 작성해주세요.
 평균 대여 기간은 소수점 두번째 자리에서 반올림하고,
 결과는 평균 대여 기간을 기준으로 내림차순 정렬해주시고,
 평균 대여 기간이 같으면 자동차 ID를 기준으로 내림차순 정렬해주세요.

 */

-- 조회  ) 자동차 ID, 평균 대여 기간
SELECT CAR_ID,
-- 조건3) 평균 대여 기간은 소수점 두번째 자리에서 반올림 -> ROUND
-- 조건2) AVERAGE_DURATION 별칭 추가
-- +1 : 시작일이 빠져있으므로 추가 해줌
       ROUND(AVG(DATEDIFF(END_DATE, START_DATE)+1), 1) AS AVERAGE_DURATION
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
-- 조건1) 평균 대여 기간이 7일 이상인 자동차
HAVING AVERAGE_DURATION >= 7
-- 정렬1) 평균 대여 기간 기준 내림차순
ORDER BY AVERAGE_DURATION DESC,
-- 정렬2) 자동차 ID 기준 내림차순
         CAR_ID DESC;


/*

      [ 주의! DATEDIFF 사용 시 시작일은 제외됨 ]

       - DATEDIFF(END_DATE, START_DATE)
              = [ END_DATE ] - [  START_DATE ]

          즉, 기간 계산할 때 사용!

       - 그러나 시작일 제외하고 계산 되므로,
         위와 같은 경우는 시작일 포함해서 계산되도록 +1 해주어야 함!

          => 안그러면 오류 발생!

 */
