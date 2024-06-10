--------------------------------------------------------------------------------
-- FLASHBACK TABLE 테이블명 TO BEFORE DROP;
PURGE RECYCLEBIN;
COMMIT;
ROLLBACK;
--------------------------------------------------------------------------------
-- TABLE: SEOUL_SPOT_115
--------------------------------------
-- CREATE
CREATE TABLE SEOUL_SPOT_115 (
    NO          NUMBER PRIMARY KEY, -- 번호
    CATEGORY    VARCHAR2(100),      -- 카테고리
    AREA_CD     VARCHAR2(100),      -- 코드명
    AREA_NM_KR  VARCHAR2(100),      -- 장소명(한글)
    AREA_NM_ENG VARCHAR2(100)       -- 장소명(영어)
);
--------------------------------------
-- DROP
DROP TABLE SEOUL_SPOT_115;
DROP TABLE SEOUL_SPOT_115 PURGE;
--------------------------------------
-- INSERT
-- data import 서울시 주요 115장소명 목록(코드포함).csv


--------------------------------------------------------------------------------
-- TABLE: SEOUL_LINE_TRAFFIC
--------------------------------------
-- CREATE
CREATE TABLE SEOUL_LINE_TRAFFIC (
    YEAR    NUMBER,        -- 년도
    MONTH   NUMBER,        -- 월
    LINE    VARCHAR2(50),  -- 노선
    TRAFFIC NUMBER,        -- 교통량
    DAY     VARCHAR2(50)   -- 요일
);
--------------------------------------
-- DROP
DROP TABLE SEOUL_LINE_TRAFFIC;
DROP TABLE SEOUL_LINE_TRAFFIC PURGE;
--------------------------------------
-- INSERT
-- data import 서울도시고속도로 노선별 요일별 교통량(통합).csv
--------------------------------------
-- SELECT
SELECT
    *
FROM
    SEOUL_LINE_TRAFFIC
WHERE
    MONTH = 1 AND LINE = '강남순환로'
;
    
SELECT
    DISTINCT YEAR
FROM
    SEOUL_LINE_TRAFFIC
ORDER BY YEAR
;
    
SELECT
    DISTINCT LINE
FROM
    SEOUL_LINE_TRAFFIC
ORDER BY LINE
;


