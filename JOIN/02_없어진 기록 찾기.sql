/*
 [ JOIN ] 없어진 기록 찾기 (Lv3)

 [문제 설명]
 ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다.
 ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는
 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.

 ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다.
 ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는
 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다.

 ANIMAL_OUTS 테이블의 ANIMAL_ID는 ANIMAL_INS의 ANIMAL_ID의 외래 키입니다.


 [문제]
 천재지변으로 인해 일부 데이터가 유실되었습니다.
 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회하는 SQL 문을 작성해주세요.
 */


-- 조회) 동물 ID, 동물 이름
SELECT o.ANIMAL_ID,
       o.NAME
FROM ANIMAL_OUTS o
         -- 입양간 기록은 보호소에 기록이 없어도(null) 있어야 하므로
-- 입양 테이블 기준으로 LEFT 조인!
         LEFT JOIN ANIMAL_INS i
                   ON i.ANIMAL_ID = o.ANIMAL_ID
-- 조건1) 입양 간 기록은 있고
WHERE o.DATETIME IS NOT NULL
-- 조건2) 보호소에 들어온 기록 없는 동물
  AND i.DATETIME IS NULL
    - 정렬) 동물 ID를 기준으로 정렬(기본이 오름차순)
ORDER BY o.ANIMAL_ID;


/*

      [ 주의!  별칭 사용 금지 ]

    - GROUP BY
    - WHERE

   => SELECT 절보다 먼저 실행되기 때문!!

 */

