/*
 [ GROUP BY ] 조건에 맞는 사용자와 총 거래금액 조회하기(Lv3)

 [문제 설명]
 다음은 중고 거래 게시판 정보를 담은 USED_GOODS_BOARD 테이블과 중고 거래 게시판 사용자 정보를 담은 USED_GOODS_USER 테이블입니다.
 USED_GOODS_BOARD 테이블은 다음과 같으며 BOARD_ID, WRITER_ID, TITLE, CONTENTS, PRICE, CREATED_DATE, STATUS, VIEWS는
 게시글 ID, 작성자 ID, 게시글 제목, 게시글 내용, 가격, 작성일, 거래상태, 조회수를 의미합니다.
 USED_GOODS_USER 테이블은 다음과 같으며 USER_ID, NICKNAME, CITY, STREET_ADDRESS1, STREET_ADDRESS2, TLNO는
 각각 회원 ID, 닉네임, 시, 도로명 주소, 상세 주소, 전화번호를 를 의미합니다.

 [문제]
 USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 완료된 중고 거래의 총금액이 70만 원 이상인 사람의
 회원 ID, 닉네임, 총거래금액을 조회하는 SQL문을 작성해주세요. 결과는 총거래금액을 기준으로 오름차순 정렬해주세요.

 */


-- 조회) 회원 ID, 닉네임, 총거래금액
SELECT u.USER_ID,
       u.NICKNAME,
       SUM(b.PRICE) AS TOTAL_SALES
FROM USED_GOODS_USER u
         -- INNER JOIN : 두 테이블 모두 매칭되는 행만 결과에 포함
-- INNER JOIN 을 통해 거래 내역이 없는 유저 제외
         INNER JOIN USED_GOODS_BOARD b
-- WRITER_ID 와 USER_ID 기준으로 조인
                    ON b.WRITER_ID = u.USER_ID
-- 조건1) 완료된 중고 거래
WHERE b.STATUS = 'DONE'
-- 고유키(USER_ID), NICKNAME 를 같이 GROUP BY
-- -> 유저를 유일하게 구분하면서 닉네임도 정확히 매칭 가능
GROUP BY u.USER_ID, u.NICKNAME
-- 조건2) 총금액이 70만원 이상인 사람
HAVING SUM(b.PRICE) >= 700000
-- 정렬) 총거래금액 기준으로 오름차순 정렬
ORDER BY TOTAL_SALES;

