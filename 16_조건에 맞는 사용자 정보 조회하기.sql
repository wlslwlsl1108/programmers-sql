/*
 [ String, Date ] 조건에 맞는 사용자 정보 조회하기 (Lv3)

 [문제 설명]
 다음은 중고 거래 게시판 정보를 담은 USED_GOODS_BOARD 테이블과 중고 거래 게시판 첨부파일 정보를 담은 USED_GOODS_USER 테이블입니다.
 USED_GOODS_BOARD 테이블은 다음과 같으며 BOARD_ID, WRITER_ID, TITLE, CONTENTS, PRICE, CREATED_DATE, STATUS, VIEWS는
 게시글 ID, 작성자 ID, 게시글 제목, 게시글 내용, 가격, 작성일, 거래상태, 조회수를 의미합니다.
 USED_GOODS_USER 테이블은 다음과 같으며 USER_ID, NICKNAME, CITY, STREET_ADDRESS1, STREET_ADDRESS2, TLNO 는
 각각 회원 ID, 닉네임, 시, 도로명 주소, 상세 주소, 전화번호를 의미합니다.

 [문제]
 USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 중고 거래 게시물을 3건 이상 등록한 사용자의
 사용자 ID, 닉네임, 전체주소, 전화번호를 조회하는 SQL 문을 작성해주세요.
 이때, 전체 주소는 시, 도로명 주소, 상세 주소가 함께 출력되도록 해주시고,
 전화번호의 경우 xxx-xxxx-xxxx 같은 형태로 하이픈 문자열(-)을 삽입하여 출력해주세요.
 결과는 회원 ID를 기준으로 내림차순 정렬해주세요.

 */

-- 조회) 사용자 ID, 닉네임, 전체주소, 전화번호
SELECT u.USER_ID,
       u.NICKNAME,
-- 조건2) 전체 주소는 시, 도로명 주소, 상세주소 함께 출력
       CONCAT(u.CITY, ' ',u.STREET_ADDRESS1, ' ',u.STREET_ADDRESS2) AS 전체주소,
-- 조건3) 전화번호는 하이픈 문자열(-) 삽입하여 출력
       CONCAT(
               SUBSTRING(u.TLNO, 1, 3), '-',
               SUBSTRING(u.TLNO, 4, 4), '-',
               SUBSTRING(u.TLNO, 8, 4)
       ) AS 전화번호
FROM USED_GOODS_USER u
         JOIN USED_GOODS_BOARD b
              ON u.USER_ID = b.WRITER_ID
GROUP BY u.USER_ID, u.NICKNAME
-- 조건1) 중고 거래 게시물을 3건 이상 등록
HAVING COUNT(*) >= 3
-- 정렬) 회원 ID 기준 내림차순
ORDER BY u.USER_ID DESC;

/*

      [ CONCAT_WS ]

       - 문자열 연결 함수 (CONCAT 과 유사)
       - WS = With Separator  (구분자와 함께)
       - 첫번째 인자 = 구분자, 그 뒤에 이어질 컬럼/문자열 나열
       - 각 문자열 사이에 구분자 자동으로 넣음
       - NULL 값 무시!

 */

-- CONCAT_WS 사용 예시

-- 조건2) 전체 주소는 시, 도로명 주소, 상세주소 함께 출력
CONCAT_WS(' ', u.CITY,u.STREET_ADDRESS1,u.STREET_ADDRESS2) AS 전체주소,
-- 조건3) 전화번호는 하이픈 문자열(-) 삽입하여 출력
       CONCAT_WS('-',
           SUBSTRING(u.TLNO, 1, 3),
           SUBSTRING(u.TLNO, 4, 4),
           SUBSTRING(u.TLNO, 8, 4)
       ) AS 전화번호