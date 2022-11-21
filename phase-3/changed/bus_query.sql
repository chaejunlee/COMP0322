ALTER SESSION set NLS_DATE_FORMAT = 'yyyy-mm-dd HH24:MI:SS';
-- TYPE 1: A Single-Table Query

-- Q1: 91번 타임테이블에 해당하는 버스에서
-- 예약된 좌석 번호를 출력

select RSID AS SEAT_NUMBER
from RESERVATION
where RTID = 199;

-- Q2: 서울역에서 일하는 직원의 이름을 출력

select fname, lname
from EMPLOYEE
where ESname = 'taeanyeok';
 

-- TYPE 2: Multi-way join with join predicates in WHERE

-- Q3: Account ID가 840056353인 사람이 예약한 버스의 운행 날짜를 출력

select TO_DATE(TDate)
from RESERVATION, ACCOUNT, TIMETABLE
where Aid = RAid AND Rtid = Tid
    AND Aid = 175339938;
 
-- Q4: Zipcode가 52439인 역에서 출발하는
-- 모든 노선의 출발역과 도착역과 가격을 출력

select Dstation, Astation,
  to_date(to_char(depart_time, 'yyyy-mm-dd hh24:mi:ss')),
  to_date(to_char(arrive_time, 'yyyy-mm-dd hh24:mi:ss'))
from TIMETABLE, ROUTE, STATION
where STname = Dstation AND Trid = Rid
    AND Zipcode = 03386;
       
-- TYPE 3: Aggregation + multi-way join with join predicates with GROUP BY

-- Q5: 각 회사들의 '우등' 운행 예약 개수를 출력 
        
select bcompany, Btype, COUNT(RAid) as Reservations
from BUS, RESERVATION, TIMETABLE, ROUTE
where bid = tbid AND RTid = Tid AND TRid = Rid
    AND Btype = 'plus'
group by bcompany, Btype;

-- Q6: 서울역에 도착하는 노선 중 나이별로 가장 싼 요금과 가장 비싼 요금을 출력

select AGE, MIN(FEE) AS MIN_FEE, MAX(FEE) AS MAX_FEE
from PRICE, ROUTE
where Rid = PRid
    AND Astation = 'seoeulyeok'
GROUP BY AGE;

-- Q7: 존재하는 노선 중 출발역을 기준으로
-- 각 출발역이 갈 수 있는 도착역의 개수를 출력

select dstation, count (astation) as destinations
from timetable, route
where trid = rid
group by dstation;

-- TYPE 4: Subquery

-- Q8: salary가 95000 이상인 직원이 운전하는 버스 회사 이름 출력 

select bcompany, COUNT(bcompany) as NUM_EMPLOYEE
from drives, bus
where dbid = bid AND Dssn IN (
    select ssn
    from employee
    where salary > 95000
)
group by bcompany
order by NUM_EMPLOYEE DESC;

-- Q9: 앞에서 두 번째 자리(ROW = B)를 예약한 사람의 Full Name

select Fname, Lname
from account
where Aid IN (
    select RAid
    from reservation, seat
    where rsid = sid and Rownumber = 'B'
);

-- TYPE 5: EXISTS를 포함하는 Subquery

-- Q10: 운전자가 할당된 버스 중에서 timetable에 없는 버스 번호를 출력

select distinct tt.tbid
from timetable tt
where not exists (
    select distinct d.dbid
    from drives d
    where tt.tbid = d.dbid);
     
-- TYPE 6: selection + projection + in predicate

-- Q11: 부산에서 출발해서 갈 수 있는 모든 곳 중
-- 제주도가 아닌 곳을 출력 (역 이름 아님)

select s.address
from station s
where s.stname in (
    select b.stname
    from route, station a, station b
    where dstation = a.stname
      and astation = b.stname
            and b.address not like 'jeju%'
      and a.address like 'busan%');

-- Q12: 급여가 3만 이하인 직원이 일하는 역의 주소 
       
select address
from station
where stname in (
    select esname
    from employee
    where Salary < 30000);

-- TYPE 7: in-line view를 활용한 Query
    
-- Q13: 고성역에서 출발하는 노선 중에
-- 06시에서 12시 사이에 출발하고 12시와 18시 사이에 도착하는 노선을
-- 출발 시간이 빠르고 도착 시간이 빠른 순서대로 출력
    
select to_date(to_char(depart_time, 'yyyy-mm-dd hh24:mi:ss')), to_date(to_char(arrive_time, 'yyyy-mm-dd hh24:mi:ss'))
from (
    select depart_time, arrive_time
    from timetable, route
    where trid = rid
      and dstation = 'gosungyeok')
where depart_time between TO_DATE('06:00', 'HH24:MI') AND TO_DATE('12:00', 'HH24:MI')
  and arrive_time between TO_DATE('12:00', 'HH24:MI') AND TO_DATE('18:00', 'HH24:MI')
order by depart_time, arrive_time;

-- Q14: 예약된 좌석 중 4번 이상 (3번 초과) 예약된 줄(row)를 출력 

select rownumber, rows_taken
from (
    select rownumber, count (colnumber) as rows_taken
    from account, reservation, seat
    where raid = aid and sid = rsid
    group by rownumber
    order by rows_taken desc)
where rows_taken > 3;

-- TYPE 8: Multi-way join with join predicates in where + order by

-- Q15: 직원이 3명 이상이 (2명 초과) 일하는
-- 역 중에 플랫폼이 가장 많은 역 순서대로 출력

select stname, totalplatform, works
from (
    select stname, totalplatform, count(ssn) as works
    from station, employee
    where esname = stname
    group by stname, totalplatform)
where works > 2
order by totalplatform desc;

-- Q16: First name이 'Gabriella'인 사람이 예약한 정보 중
-- 10월 3일 이후 출발하는 정보의 날짜, 출발역, 도착역을 날짜를 기준으로 오름차순 출력 

select fname, TO_DATE(tdate), dstation as FROM_A, astation as TO_B
from account, reservation, timetable, route
where aid = raid and tid = rtid and trid = rid
  and fname = 'Gabriella'
  and tdate > TO_DATE('2022-10-03 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
order by tdate;

-- Q17: 동대구역에서 출발해 영등포역으로 가는 노선 중
-- 10월 2일 08시 이후에 출발하는 일시와 버스 종류, 요금을
-- 출발 일시 오름차순으로 출력

select to_date(to_char(depart_time, 'yyyy-mm-dd hh24:mi:ss')), bustype, fee
from timetable, route, price
where trid = rid and rid = prid
  and dstation = 'dongdaeguyeok' and astation = 'yeongdeungpoyeok'
  and depart_time > to_date('2022-10-02 08:00:00', 'yyyy-mm-dd hh24:mi:ss')
  and age = '18+'
order by depart_time;

-- TYPE 9: Aggregation + multi-way join with join predicates
-- with group by and order by

-- Q18: 버스표를 가장 많이 예매한 사람 순서대로 출력 

select fname, lname, count(rsid) as reservations
from account, reservation
where raid = aid
group by fname, lname
order by reservations desc;

-- Q19: 존재하는 노선 중 도착역을 기준으로
-- 각 도착역으로 갈 수 있는 출발역의 개수를 내림차순으로 출력

select astation, count (dstation) as origin
from timetable, route
where trid = rid
group by astation
order by origin DESC;

-- Q20: 예약된 정보 중 같은 노선의 버스를 타는 사람이 1명 초과인 (2명 이상) 
-- 노선 정보를 사람 수 내림차순으로 출력 

select tid, same
from (
    select tid, count(tid) as same
    from timetable, reservation
    where tid = rtid
    group by tid
    order by same desc)
where same > 1;

-- TYPE 10: SET Operation을 이용한 query

-- Q21: 'Derek'이 예약한 좌석 번호 중 
-- 'Gabriella'가 예약하지 않은 좌석 번호를 출력

-- 'Derek'이 예약한 좌석은 T5, X3, Z5 3개 인데
-- 'Gabriella'도 T5를 예약했기 때문에
-- 'Derek'이 예약한 3개 중 2개만 출력된다.

(select rsid from account, reservation
where aid = raid and fname = 'Derek')
 minus
(select rsid from account, reservation
where aid = raid and fname = 'Gabriella');

-- Q22: 신경주역에서 출발하는 6000원과 6500원 사이에 있는 성인 티켓에 대해 
-- 버스 출발 시간과 도착 시간을 출력 

select to_date(to_char(depart_time, 'yyyy-mm-dd hh24:mi:ss')), to_date(to_char(arrive_time, 'yyyy-mm-dd hh24:mi:ss'))
from timetable
where trid in (
    (select rid
    from route
    where dstation = 'shinkyungjuyeok') -- 결과 84개 
      intersect
    (select prid
    from price
    where fee between 6000 and 6500 and Age = '18+') -- 결과 2개 
); -- 총 결과 1개 (rid = 48)

-- Q23: 로그인 / 로그아웃
-- Args
-- Email : 'james90@example.net'
-- PW : 'cwfOlgHhJFZUtX'
-- Return
-- AID : 242103837
SELECT AID
FROM ACCOUNT
WHERE EMAIL='james90@example.net'
AND PW='cwfOlgHhJFZUtX';

-- Q24. 아이디(이메일) 찾기
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

-- Q25. 가능한 버스 시간 표 출력
-- Args
-- 출발역, 날짜
-- Returns
-- Timetable ID, 날짜, 출발역, 출발 시간, 도착역, 도착 시간
-- ex. 해당 날짜(22/10/06)에 출발역(강릉역)에서 출발하는 모든 시간표 출력
-- 60	22/10/06	강릉역	03:09	옥천역	13:57
-- 98	22/10/06	강릉역	11:24	용산역	11:20
-- 170	22/10/06	강릉역	00:31	단양역	10:00
-- 127	22/10/06	강릉역	12:06	단양역	20:45
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

-- Q26. 버스 정보 조회
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

-- Q27. 좌석 가격 조회
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

-- Q28. 좌석 상세 가격 조회
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

-- Q29. 좌석 상세 가격 조회
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

-- Q30. 버스 좌석 정보 조회 (예약 안 된 좌석)
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

-- Q31. 예약 정보 조회 (티켓 정보 조회)
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

-- Q32. 예매 상세 정보
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