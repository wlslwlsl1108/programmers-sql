/*
 [ SELECT ] 서울에 위치한 식당 목록 출력하기 (Lv4)

 [문제 설명]
 다음은 식당의 정보를 담은 REST_INFO 테이블과 식당의 리뷰 정보를 담은 REST_REVIEW 테이블입니다.
 REST_INFO 테이블은 다음과 같으며 REST_ID, REST_NAME, FOOD_TYPE, VIEWS, FAVORITES, PARKING_LOT, ADDRESS, TEL은
 식당 ID, 식당 이름, 음식 종류, 조회수, 즐겨찾기수, 주차장 유무, 주소, 전화번호를 의미합니다.

 REST_REVIEW 테이블은 다음과 같으며 REVIEW_ID, REST_ID, MEMBER_ID, REVIEW_SCORE, REVIEW_TEXT,REVIEW_DATE는
 각각 리뷰 ID, 식당 ID, 회원 ID, 점수, 리뷰 텍스트, 리뷰 작성일을 의미합니다.

 [문제]
 REST_INFO와 REST_REVIEW 테이블에서 서울에 위치한 식당들의
 식당 ID, 식당 이름, 음식 종류, 즐겨찾기수, 주소, 리뷰 평균 점수를 조회하는 SQL 문을 작성해주세요.
 이때 리뷰 평균점수는 소수점 세 번째 자리에서 반올림 해주시고
 결과는 평균점수를 기준으로 내림차순 정렬해주시고,
 평균점수가 같다면 즐겨찾기수를 기준으로 내림차순 정렬해주세요.

 */

-- 조회) 식당 ID, 식당 이름, 음식 종류, 즐겨찾기수, 주소, 리뷰 평균 점수
SELECT i.REST_ID,
       i.REST_NAME,
       i.FOOD_TYPE,
       i.FAVORITES,
       i.ADDRESS,
-- 조건2) 리뷰 평균점수는 소수점 세 번째 자리에서 반올림
       ROUND(AVG(r.REVIEW_SCORE),2) AS SCORE
FROM REST_INFO i
         JOIN REST_REVIEW r
              ON i.REST_ID = r.REST_ID
-- 조건1) 서울에 위치한 식당
WHERE ADDRESS LIKE '서울%'
GROUP BY i.REST_ID,
         i.REST_NAME,
         i.FOOD_TYPE,
         i.FAVORITES,
         i.ADDRESS
-- 정렬1) 평균 점수 기준으로 내림차순
ORDER BY SCORE DESC,
-- 정렬2) 즐겨찾기수 기준으로 내림차순
         FAVORITES DESC;

/*

      [ ORDER BY ]

       - 별칭 사용 가능!!

-----------------------------------------------------------------------------

      [ ROUND(컬럼, 자릿수) ]

       - 해당 자리수까지 표현 가능! ( 반올림 )

 */

