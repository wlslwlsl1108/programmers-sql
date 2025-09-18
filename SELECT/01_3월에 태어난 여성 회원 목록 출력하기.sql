/*
 [ SELECT ] 3월에 태어난 여성 회원 목록 출력하기 (Lv2)

 [문제 설명]
 다음은 식당 리뷰 사이트의 회원 정보를 담은 MEMBER_PROFILE 테이블입니다.
 MEMBER_PROFILE 테이블은 다음과 같으며 MEMBER_ID, MEMBER_NAME, TLNO, GENDER, DATE_OF_BIRTH는
 회원 ID, 회원 이름, 회원 연락처, 성별, 생년월일을 의미합니다.

 [문제]
 MEMBER_PROFILE 테이블에서 생일이 3월인 여성 회원의 ID, 이름, 성별, 생년월일을 조회하는 SQL 문을 작성해주세요.
 이때 전화번호가 NULL인 경우는 출력대상에서 제외시켜 주시고, 결과는 회원 ID를 기준으로 오름차순 정렬해주세요.
 */


-- 조회) ID, 이름, 성별, 생년월일
SELECT MEMBER_ID,
       MEMBER_NAME,
       GENDER,
       DATE_FORMAT(DATE_OF_BIRTH,'%Y-%m-%d')
           AS DATE_OF_BIRTH
FROM MEMBER_PROFILE
-- 조건2) 여성 회원
WHERE GENDER = 'W'
-- 조건3) 전화번호 NULL 인 경우 출력대상에서 제외
          AND TLNO IS NOT NULL
-- 조건1) 생일이 3월
          AND MONTH(DATE_OF_BIRTH) = 3
-- 정렬) 회원ID 기준으로 오름차순
ORDER BY MEMBER_ID;


/*

      [ MONTH(DATE_OF_BIRTH)  ]

    -  DATE_OF_BIRTH 에서 " 월(MONTH) 부분만 뽑아서 정수(1~12) 반환"
    - WHERE 절에서 사용
    => " 조건 필터링 "

----------------------------------------------------------------------------

      [ DATE_FORMAT에 직접 '%Y-03-%d' 해주면 안되는 이유 ]

    - DATE_FORMAT 은 문자열로 변환하여 표시하는 역할!
    - [ %Y-03-%d ]  => 출력값을 강제로 3월로 바꿔서 보여주겠다는 뜻
    - 즉, 결과를 이쁘게 보여주려고 사용
    - SELECT 절에서 사용

    => " 결과 출력 포맷 "

 */

