/*
 [ JOIN ] 그룹별 조건에 맞는 식당 목록 출력하기 (Lv4)

 [문제 설명]
 다음은 고객의 정보를 담은 MEMBER_PROFILE 테이블과 식당의 리뷰 정보를 담은 REST_REVIEW 테이블입니다.
 MEMBER_PROFILE 테이블은 다음과 같으며 MEMBER_ID, MEMBER_NAME, TLNO, GENDER, DATE_OF_BIRTH는
 회원 ID, 회원 이름, 회원 연락처, 성별, 생년월일을 의미합니다.

 REST_REVIEW 테이블은 다음과 같으며 REVIEW_ID, REST_ID, MEMBER_ID, REVIEW_SCORE, REVIEW_TEXT,REVIEW_DATE는
 각각 리뷰 ID, 식당 ID, 회원 ID, 점수, 리뷰 텍스트, 리뷰 작성일을 의미합니다.

 [문제]
 MEMBER_PROFILE와 REST_REVIEW 테이블에서 리뷰를 가장 많이 작성한 회원의 리뷰들을 조회하는 SQL 문을 작성해주세요.
 회원 이름, 리뷰 텍스트, 리뷰 작성일이 출력되도록 작성해주시고,
 결과는 리뷰 작성일을 기준으로 오름차순, 리뷰 작성일이 같다면 리뷰 텍스트를 기준으로 오름차순 정렬해주세요.

 */

-- 조회  ) 회원 이름, 리뷰 텍스트, 리뷰 작성일
SELECT m.MEMBER_NAME,
       r.REVIEW_TEXT,
-- 결과 예시와 동일한 데이트 포맷 사용
       DATE_FORMAT(r.REVIEW_DATE, '%Y-%m-%d') AS REVIEW_DATE
FROM MEMBER_PROFILE m
-- 조인
         JOIN REST_REVIEW r
              ON m.MEMBER_ID = r.MEMBER_ID
WHERE m.MEMBER_ID = (
-- 서브쿼리
-- 조건1) 리뷰를 가장 많이 작성한 회원
    SELECT MEMBER_ID
    FROM REST_REVIEW
    GROUP BY MEMBER_ID
    ORDER BY COUNT(*) DESC
    LIMIT 1
    )
-- 정렬1) 리뷰 작성일 기준으로 오름차순
ORDER BY r.REVIEW_DATE,
-- 정렬2) 리뷰 텍스트 기준으로 오름차순
    r.REVIEW_TEXT;

/*

      [ 리뷰를 가장 많이 작성한 회원이 2명이라면? (동점자) ]

       - 위 코드는 동점자가 없을 경우에만 정상적으로 실행됨

       - 동점자 있으면 그 중 임의의 1명만 선택됨

       - 아래 코드처럼
          IN (SELECT ... HAVING COUNT(*) = (SELECT MAX(cnt)...))
          → 가장 많이 리뷰한 회원 여러명이면 모두 포함해서 출력 가능!!

               SELECT
                  m.MEMBER_NAME,
                   r.REVIEW_TEXT,
                   DATE_FORMAT(r.REVIEW_DATE, '%Y-%m-%d') AS REVIEW_DATE
               FROM MEMBER_PROFILE m
               JOIN REST_REVIEW r
                 ON m.MEMBER_ID = r.MEMBER_ID
               WHERE m.MEMBER_ID IN (
                   -- 리뷰 수가 가장 많은 회원(복수 가능)
                   SELECT MEMBER_ID
                   FROM REST_REVIEW
                   GROUP BY MEMBER_ID
                   HAVING COUNT(*) = (
                       SELECT MAX(cnt)
                       FROM (
                           SELECT COUNT(*) AS cnt
                           FROM REST_REVIEW
                           GROUP BY MEMBER_ID
                       ) t
                   )
               )
               -- 정렬: 리뷰 작성일 오름차순 → 리뷰 텍스트 오름차순
               ORDER BY r.REVIEW_DATE ASC,
                        r.REVIEW_TEXT ASC;


 */

