/*
 [ String, Date ] 취소되지 않은 진료 예약 조회하기 (Lv4)

 [문제 설명]
 다음은 환자 정보를 담은 PATIENT 테이블과 의사 정보를 담은 DOCTOR 테이블,
 그리고 진료 예약목록을 담은 APPOINTMENT에 대한 테이블입니다.
 PATIENT 테이블은 다음과 같으며 PT_NO, PT_NAME, GEND_CD, AGE, TLNO는
 각각 환자번호, 환자이름, 성별코드, 나이, 전화번호를 의미합니다.

 DOCTOR 테이블은 다음과 같으며 DR_NAME, DR_ID, LCNS_NO, HIRE_YMD, MCDP_CD, TLNO는
 각각 의사이름, 의사ID, 면허번호, 고용일자, 진료과코드, 전화번호를 나타냅니다.

 APPOINTMENT 테이블은 다음과 같으며 APNT_YMD, APNT_NO, PT_NO, MCDP_CD, MDDR_ID, APNT_CNCL_YN, APNT_CNCL_YMD는
 각각 진료 예약일시, 진료예약번호, 환자번호, 진료과코드, 의사ID, 예약취소여부, 예약취소날짜를 나타냅니다.

 [문제]
 PATIENT, DOCTOR 그리고 APPOINTMENT 테이블에서
 2022년 4월 13일 취소되지 않은 흉부외과(CS) 진료 예약 내역을 조회하는 SQL 문을 작성해주세요.
 진료예약번호, 환자이름, 환자번호, 진료과코드, 의사이름, 진료예약일시 항목이 출력되도록 작성해주세요.
 결과는 진료예약일시를 기준으로 오름차순 정렬해주세요.

 */

-- 조회) 진료예약번호, 환자이름, 환자번호, 진료과코드, 의사이름, 진료예약일시
SELECT a.APNT_NO,
       p.PT_NAME,
       a.PT_NO,
       a.MCDP_CD,
       d.DR_NAME,
       a.APNT_YMD
FROM PATIENT p
         JOIN APPOINTMENT a
              ON p.PT_NO = a.PT_NO
         JOIN DOCTOR d
              ON a.MDDR_ID = d.DR_ID
-- 조건1) 2022년 4월 13일 취소되지 않은
WHERE DATE(a.APNT_YMD) = '2022-04-13'
  AND a.APNT_CNCL_YN = 'N'
-- 조건2) 흉부외과(CS) 진료 예약 내역 조회
  AND a.MCDP_CD = 'CS'
-- 정렬) 진료예약일시 기준 오름차순
ORDER BY a.APNT_YMD;

/*

      [ 3개의 테이블 조인 ]

       - 2개 테이블 조인과 동일한 방식으로 진행!
 */
