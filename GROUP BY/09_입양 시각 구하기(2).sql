/*
 [ GROUP BY ] 입양 시각 구하기(2) (Lv4)

 [문제 설명]
 ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다.
 ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는
 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다.

 [문제]
 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다.
 0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL 문을 작성해주세요.
 이때 결과는 시간대 순으로 정렬해야 합니다.

 */

-- 조건1) 0시부터 23시까지
-- 0부터 23까지 숫자 생성하는 임시 테이블 h 정의
WITH RECURSIVE h AS (
-- 초기값 : 첫 번째 행은 0부터 시작
    SELECT 0 AS HOUR
UNION ALL
-- 재귀적으로 hour 값을 1씩 증가시키며 23 될때까지 반복 생성
SELECT HOUR + 1 FROM h
WHERE HOUR < 23
    )
-- 조회  ) HOUR, COUNT
-- 위에서 만든 h 테이블(0~23시)과 ANIMAL_OUTS 테이블 이용해 시간대별 입양 건수 조회
SELECT h.HOUR,                      -- 시간대(0~23시)
       COUNT(a.ANIMAL_ID) AS COUNT  -- 각 시간대별 입양된 동물 수 계산
FROM h
-- 조건2) 각 시간대별로 입양이 몇 건 발생했는지
-- h 테이블(0~23시) / ANIMAL_OUTS 테이블을 시간대 기준으로 LEFT JOIN
    LEFT JOIN ANIMAL_OUTS a
-- ANIMAL_OUTS의 DATETIME 컬럼에서 시(hour) 부분만 추출하여 비교
ON h.HOUR = HOUR(a.DATETIME)
GROUP BY h.HOUR
-- 정렬  ) 시간대 기준으로 오름차순
ORDER BY h.HOUR;

/*

      [ WITH RECURSIVE ]

       - SQL 에서 반복문 사용하고 싶을 때 사용
       - 사용방법 예시)
              WITH RECURSIVE H AS (
                  SELECT 0 AS HOUR         -- 초기값: 0부터 시작
                  UNION ALL
                  SELECT HOUR + 1          -- 1씩 증가
                  FROM H
                  WHERE HOUR < 23          -- 23까지 반복
              )
              SELECT * FROM H;

-----------------------------------------------------------------------------

      [ UNION ALL ] -> 블로그 예시 참고

       - 중복 제거 없이 다 보여줌  → 즉, 두 SELECT 결과를 그대로 모두 합

       - 위 경우 UNION 만 사용할 경우 중복이 제거되어,

         재귀 (0~23까지 반복 생성) 가 이루어지지 않음

       - UNION 만 사용하면

              → 현재까지 생성된 데이터/ 새로 생긴 데이터 비교하여 중복 값 지움

                => 재귀가 딱 1번만 실행되고 바로 종료 됨

-----------------------------------------------------------------------------

      [ 만약 그냥 SELECT 문만 쓴다면? ]

      SELECT
          HOUR(DATETIME) AS HOUR,
          COUNT(*) AS COUNT
      FROM ANIMAL_OUTS
      GROUP BY HOUR
      ORDER BY HOUR;

       - 입양이 없는 시간대에 대한 결과가 나오지 않음.

              → 데이터가 있는 시간대만 출력!

 */

