/*
 [ String, Date ] 조회수가 가장 많은 중고거래 게시판의 첨부파일 조회하기 (Lv3)

 [문제 설명]
 다음은 중고거래 게시판 정보를 담은 USED_GOODS_BOARD 테이블과 중고거래 게시판 첨부파일 정보를 담은 USED_GOODS_FILE 테이블입니다.
 USED_GOODS_BOARD 테이블은 다음과 같으며 BOARD_ID, WRITER_ID, TITLE, CONTENTS, PRICE, CREATED_DATE, STATUS, VIEWS은
 게시글 ID, 작성자 ID, 게시글 제목, 게시글 내용, 가격, 작성일, 거래상태, 조회수를 의미합니다.

 USED_GOODS_FILE 테이블은 다음과 같으며 FILE_ID, FILE_EXT, FILE_NAME, BOARD_ID는
 각각 파일 ID, 파일 확장자, 파일 이름, 게시글 ID를 의미합니다.

 [문제]
 USED_GOODS_BOARD와 USED_GOODS_FILE 테이블에서
 조회수가 가장 높은 중고거래 게시물에 대한 첨부파일 경로를 조회하는 SQL 문을 작성해주세요.
 첨부파일 경로는 FILE ID를 기준으로 내림차순 정렬해주세요.
 기본적인 파일경로는 /home/grep/src/ 이며, 게시글 ID를 기준으로 디렉토리가 구분되고,
 파일이름은 파일 ID, 파일 이름, 파일 확장자로 구성되도록 출력해주세요.
 조회수가 가장 높은 게시물은 하나만 존재합니다.

 */

-- 조회) 파일 경로
-- 조건2) 기본적인 파일 경로 /home/grep/src/
-- 조건3) 게시글 ID 기준으로 디렉토리 구분
-- 조건4) 파일 이름은 파일 ID, 파일 이름, 파일 확장자로 구성
SELECT CONCAT('/home/grep/src/',
              b.BOARD_ID,
              '/',
              f.FILE_ID,
              f.FILE_NAME,
              f.FILE_EXT) AS FILE_PATH
FROM (
-- 조건1) 조회수가 가장 높은 중고거래 게시물
         SELECT BOARD_ID
         FROM USED_GOODS_BOARD
         ORDER BY VIEWS DESC
             LIMIT 1)
         b
         JOIN USED_GOODS_FILE f
              ON b.BOARD_ID = f.BOARD_ID
-- 정렬1) FILE ID를 기준으로 내림차순
ORDER BY f.FILE_ID DESC;

/*

      [ CONCAT ]

       - 문자열 이어붙이기 위해 사용
       - 컬럼은 컬럼명 그대로 기입
       - 문자열은 ' ' 작은따옴표 사용

-----------------------------------------------------------------------------

      [ 왜? 조건3이 GROUP BY 안해도 되는 이유 ]

       - 문제 조건은 " 조회수 가장 높은 게시물 1건 " 만 대상
       - 서브쿼리에서 1개 게시물(BOARD_ID) 확정
       - JOIN 통해 FILE 테이블 붙일 때도 BOARD_ID로 묶여 나옴

           => 즉, 애초에 게시물 1개로 확정되므로 그룹화 불필요!!

-----------------------------------------------------------------------------

      [ 왜? 서브쿼리 ]

       - 서브쿼리 = 조회수 최댓값인 게시판 1건 추출
       - 외부쿼리는 파일 목록 + 파일 정렬만 처리!
       - ORDER BY는 1번만 사용 가능!
          ( 서브쿼리에서 1번, 외부쿼리에서 1번 이렇게 나눠서는 가능)

 */

