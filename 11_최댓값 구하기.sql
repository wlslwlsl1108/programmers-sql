/*
 [ MAX ] 최댓값 구하기 (Lv1)

 [문제 설명]
 ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다.
 ANIMAL_INS 테이블의 ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는
 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.

 [문제]
 가장 최근에 들어온 동물은 언제 들어왔는지 조회하는 SQL 문을 작성해주세요.
 */


-- 조회) DATETIME ( AS 시간)
-- 조건) 가장 최근에 들어온 동물
SELECT MAX(DATETIME) AS '시간'
FROM ANIMAL_INS;

