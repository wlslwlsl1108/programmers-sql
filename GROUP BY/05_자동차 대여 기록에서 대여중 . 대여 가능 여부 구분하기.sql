/*
 [ GROUP BY ] 자동차 대여 기록에서 대여중 / 대여 가능 여부 구분하기 (Lv3)

 [문제 설명]
 다음은 어느 자동차 대여 회사의 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블입니다.
 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며,
 HISTORY_ID, CAR_ID, START_DATE, END_DATE 는
 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

 [문제]
 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서
 2022년 10월 16일에 대여 중인 자동차인 경우 '대여중' 이라고 표시하고,
 대여 중이지 않은 자동차인 경우 '대여 가능'을 표시하는 컬럼(컬럼명: AVAILABILITY)을 추가하여
 자동차 ID와 AVAILABILITY 리스트를 출력하는 SQL 문을 작성해주세요.
 이때 반납 날짜가 2022년 10월 16일인 경우에도 '대여중'으로 표시해주시고 결과는 자동차 ID를 기준으로 내림차순 정렬해주세요.

 */


-- 조회) 자동차 ID, AVAILABILITY
SELECT CAR_ID,
-- 조건1) (2022년 10월 16일 기준) 대여 중인 자동차 = '대여중'
-- → 반납일이 기준일일 경우에도 '대여중'
       CASE
           WHEN MAX(CASE WHEN DATE('2022-10-16') BETWEEN START_DATE AND END_DATE THEN 1 END) = 1
               THEN '대여중'
-- 조건2) (2022년 10월 16일 기준) 대여 중이지 않은 자동차 = '대여 가능'
           ELSE '대여 가능'
-- 조건3) 별칭 추가 (AVAILABILITY)
           END AS AVAILABILITY
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
-- 정렬) 자동차 ID 기준 내림차순
ORDER BY CAR_ID DESC;

/*

      [ 왜? MAX 사용? ]

      => 자동차가 여러번 대여 기록이 있으므로,
          현재 반납완료 상황에서는 CASE 결과 NULL,
          대여중 상황에서는 CASE 결과 1 로 표기됨

          즉, 여러번 대여 기록 중 대여중(MAX=1)인 조건만 추출하기 위함!


          1. 상황

             - 테이블 내에 동일 CAR_ID가 존재
                 → 차를 여러번 대여했기 때문에 기록 여러 개 존재
                   => CASE WHEN 만 사용 시,
                      자동차 한대가 여러 줄의 결과로 나옴!


          2. 해결

             - 같은 자동차 ID를 GROUP BY로 그룹화
             - 그 안에서 "대여중인 기록이 하나라도 있으면 대여중 표시"
                 → 그룹 안에서 조건 체크하는 방법으로 MAX(집계함수) 사용!

 */

