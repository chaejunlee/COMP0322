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


