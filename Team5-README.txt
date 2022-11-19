- bus_insert.sql
phase 2에서 한글로 되어있던 것들을 영어로 바꾸고 기능들에 맞게 들어가 있는 데이터를 수정함

- bus_schema.sql
데이터의 형식에 맞게 schema를 일부 수정함 (한글 -> 영어)

- phase 2에서 bus_query에서 작성한 쿼리를 서비스에 맞게 바꾸어서 java 파일 내 코드로 작성함
- 아래 기능설명에 query의 구체적인 내용과 query를 기술함

- bus_schema.sql과 bus_insert.sql을 차례로 실행하고 userid랑 passwd 뭐로 했는지 적으면 될듯





-- 기능 설명
기능들을 선택하면 예시가 나오는데 예시와 똑같이 입력하면 기능들이 수행됨
기능을 가장 잘 보여줄 수 있는 data들을 예시로 둔 것

-- 6. 버스 좌석 정보 조회 (예약 안 된 좌석)
-- Args
-- 출발지, 도착지, 날짜, 출발 시간
-- Return : Args에 해당하는 버스의 아직 예약되지 않은 좌석 목록
-- Seat ID, ROW NO., COL NO.
-- ex. 청량리->동해 22년10월7일 05시 15분에 출발하는 버스에서
-- 예약되지 않는 버스들을 출력
select * from SEAT
where sid not in
    (SELECT distinct RE.RSID
    FROM ROUTE RO, TIMETABLE T, BUS B, RESERVATION RE
    WHERE RO.DSTATION = 'chungryangri'
    AND RO.ASTATION = 'donghae'
    AND T.TRID = RO.RID
    AND T.TDATE = TO_DATE('22/10/07', 'yy/mm/dd')
    AND T.DEPART_TIME = TO_DATE('22/10/07 05:15', 'yy/mm/dd HH24:MI')
    AND T.TID = RE.RTID)
order by sid asc;



-- 7. 버스 좌석 정보 예매
select * from reservation where RAID = '692633736';
insert into reservation values('692633736', 'F3', 61);
select * from reservation where RAID = '692633736';
rollback;

-- 8. 예매한 목록 update
select * from reservation WHERE RAID = '547937757';
-- Args
-- Seat ID, Timetable ID, Account ID
-- ex. Account ID가 547937757인 사람의 예약 정보 중
-- Timetable 32번을 예약한 좌석을 J3에서 J4로 변경
UPDATE RESERVATION
SET RSID = 'J4' -- 바뀐 SEAI ID
WHERE RAID = '629293299' -- Account ID
AND RTID = '32' -- Timetable ID
AND RSID = 'J3'; -- 바꿀 SEAI ID

select * from reservation WHERE RAID = '547937757';
rollback;

-- 9. 예매 내역 삭제
-- Args
-- Seat ID, Timetable ID, Account ID
DELETE FROM RESERVATION
WHERE RAID = '547937757' -- Account ID
AND RTID = '32' -- Timetable ID
AND RSID = 'J3'; -- SEAT ID

-- 10. 예약 정보 조회 (티켓 정보 조회)
-- Args
-- Account ID : '246306950'
-- Return
-- 날짜(DATES), 출발 시간(DEPART_TIME), 도착 시간(ARRIVE_TIME),
-- 버스 번호(BUS_ID), 좌석 번호(SEAT),
-- 출발지(DEPART_STATION), 출발지 플랫폼 번호(DEPART_PLATFORM)
-- 도착지(ARRIVE_STATION), 도착지 플랫폼 번호(ARRIVE_PLATFORM)
-- ex. 로그인되어 있는 Account ID를 통해
-- 예약 정보 출력
SELECT
    TO_CHAR(T.TDATE, 'YYYY/MM/DD') AS DATES,
    TO_CHAR(T.DEPART_TIME, 'HH24:MI') AS DEPART_TIME,
    TO_CHAR(T.ARRIVE_TIME, 'HH24:MI') AS ARRIVE_TIME,
    T.TBID AS BUS_ID,
    RE.RSID AS SEAT,
    RO.DSTATION AS DEPART_STATION,
    RO.DPLATFORM AS DEPART_PLATFORM,
    RO.ASTATION AS ARRIVE_STATION,
    RO.APLATFORM AS ARRIVE_PLATFORM
FROM RESERVATION RE, TIMETABLE T, ROUTE RO
WHERE RE.RAID = '246306950'
AND RE.RTID = T.TID
AND T.TRID=RO.RID;

-- 11. 예매 상세 정보
select * from reservation WHERE RAID = '790210786';
-- Args
-- Timetable ID
-- Return
-- Driver Name, BUS COMPANY

SELECT E.LNAME AS DRIVER_LNAME, E.FNAME AS DRIVER_FNAME, B.BCOMPANY AS BUS_COMPANY
FROM TIMETABLE T, DRIVES D, BUS B, EMPLOYEE E
WHERE T.TID = 137
AND D.DBID = T.TBID
AND B.BID = T.TBID
AND E.SSN = D.DSSN;

