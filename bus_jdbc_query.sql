SELECT * FROM ACCOUNT;
select * from reservation;
select * from timetable;
select * from route;
-- 1. 로그인 / 로그아웃
-- Args
-- Email : 'james90@example.net'
-- PW : 'cwfOlgHhJFZUtX'
-- Return
-- AID : 242103837
SELECT AID
FROM ACCOUNT
WHERE EMAIL='james90@example.net'
AND PW='cwfOlgHhJFZUtX';

-- 2. 아이디(이메일) 찾기
-- Args
-- Name : 'Greg', 'Ingram' (First Name, Last Name)
-- Phone Number : '05447234270' 
-- Return : 아이디(이메일)
-- Email : jdavis@example.org
SELECT EMAIL
FROM ACCOUNT
WHERE FNAME = 'Greg'
AND LNAME = 'Ingram'
AND PHONE = '05447234270';

-- 3. 가능한 버스 시간 표 출력
-- Args
-- 출발역, 날짜
-- Returns
-- Timetable ID, 날짜, 출발역, 출발 시간, 도착역, 도착 시간
-- ex. 해당 날짜(22/10/06)에 출발역(강릉역)에서 출발하는 모든 시간표 출력
-- 60	22/10/06	강릉역	03:09	옥천역	13:57
-- 98	22/10/06	강릉역	11:24	용산역	11:20
-- 170	22/10/06	강릉역	00:31	단양역	10:00
-- 127	22/10/06	강릉역	12:06	단양역	20:45
select * from route;
select * from timetable;
SELECT DISTINCT
    T.TID, T.TDATE,
    RO.DSTATION, TO_CHAR(T.DEPART_TIME, 'HH24:MI') AS DEPART_TIME,
    RO.ASTATION, TO_CHAR(T.ARRIVE_TIME, 'HH24:MI') AS ARRIVE_TIME
    --T.TDATE, count(T.TID)
FROM ROUTE RO, TIMETABLE T
WHERE RO.DSTATION = '강릉역'
AND T.TRID = RO.RID
AND T.TDATE = TO_DATE('22/10/06', 'YY/MM/DD')
--GROUP BY T.TDATE
ORDER BY T.TDATE ASC;


-- 4. 버스 정보 조회
-- Args
-- 출발지, 도착지, 날짜
-- '광명역', '서산역', '22/10/06'
-- Return : Args에 해당하는 버스의 정보 출력
-- BUS ID, COMPANY, TYPE
-- 7437	   가상 고속	   일반
-- 8966	   턴키 고속	   일반
-- ex. 22년10월06일 '광명역'에서 출발해서 '서산역'에 도착하는 버스들의 정보 출력
SELECT
    B.BID AS BUS_ID,
    B.BCOMPANY AS BUS_COMPANY,
    B.BTYPE AS BUS_TYPE
FROM ROUTE RO, TIMETABLE T, BUS B
WHERE RO.DSTATION = '광명역' -- var1
AND RO.ASTATION = '서산역' -- var2
AND T.TRID = RO.RID
AND T.TDATE = TO_DATE('22/10/06', 'yy/mm/dd') -- var3
AND B.BID = T.TBID;

-- 5. 좌석 가격 조회
-- Args
-- 출발지, 도착지
-- Return
-- Age, Bus Type, Fee
-- ex. '광명역'에서 '서산역'으로 가는 ROUTE의 요금
-- (Route가 정해지면 버스 요금은 같음)
SELECT distinct P.AGE AS AGE,
    P.BUSTYPE as BUS_TYPE,
    P.FEE as FEE
FROM PRICE P, ROUTE RO
WHERE RO.DSTATION = '광명역' AND RO.ASTATION = '서산역'
AND RO.RID = P.PRID
ORDER BY AGE DESC, BUSTYPE DESC;

-- 5-1. 좌석 상세 가격 조회
-- Args
-- 출발지, 도착지
-- Return
-- BUS ID, BUS TYPE, AGE, FEE
-- ex. '광명역'에서 '서산역'으로 가는 BUS들의 요금
-- 해당 버스가 일반인지 우등인지는 이미 정해져 있기 때문에
-- 해당 버스의 타입의 요금만 출력
-- 2493번 버스 타입이 일반이기 때문에 광명역->서산역 요금 중 일반인 것만 출력
-- 5292번 버스 타입이 우등이기 때문에 광명역->서산역 요금 중 우등인 것만 출력
-- 2493   	일반 	청소년	5400
-- 2493  	일반 	어린이	3100
-- 2493  	일반 	성인	    6200
-- 5292 	우등 	청소년	7600
-- 5292 	우등 	어린이	5500
-- 5292 	우등 	성인	    8400
select BUS_ID, BUS_TYPE, AGE, FEE
from 
(SELECT
    B.BID AS BUS_ID,
    B.BCOMPANY AS BUS_COMPANY,
    B.BTYPE AS BUS_TYPE
FROM ROUTE RO, TIMETABLE T, BUS B
WHERE RO.DSTATION = '광명역' AND RO.ASTATION = '서산역'
AND T.TRID = RO.RID
AND B.BID = T.TBID)
left join 
(SELECT distinct P.AGE AS AGE,
    P.BUSTYPE as BUS_TYPE2,
    P.FEE as FEE
FROM PRICE P, ROUTE RO
WHERE RO.DSTATION = '광명역' AND RO.ASTATION = '서산역'
AND RO.RID = P.PRID
ORDER BY AGE DESC, BUSTYPE DESC)
ON (BUS_TYPE = BUS_TYPE2)
ORDER BY BUS_ID ASC, AGE DESC;

-- 5-2. 좌석 상세 가격 조회
-- Args
-- Timetable ID (21)
-- Return
-- 요금 정보
-- ex. Timetable ID를 알면 Route (TRID), BUS (TBID)를 알기 때문에 요금 정보 조회 가능
SELECT P.AGE, P.BUSTYPE, P.FEE
FROM TIMETABLE T, PRICE P, BUS B
WHERE T.TID = 21
AND T.TBID = B.BID
AND T.TRID = P.PRID
AND B.BTYPE = P.BUSTYPE
ORDER BY AGE DESC;

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