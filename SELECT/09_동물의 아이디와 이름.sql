/*
 [ SELECT ] 동물의 아이디와 이름 (Lv1)

 [문제 설명]
 ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다.
 ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는
 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.

 [문제]
 동물 보호소에 들어온 모든 동물의 아이디와 이름을 ANIMAL_ID 순으로 조회하는 SQL 문을 작성해주세요.
 SQL을 실행하면 다음과 같이 출력되어야 합니다.
 */


-- 조회) 동물의 아이디, 이름
SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
-- 정렬) 동물 아이디 순
ORDER BY ANIMAL_ID;

