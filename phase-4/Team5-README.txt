- bus_schema.sql
ACCOUNT에 Point attribute 추가
PRICE relation의 Pid를 삭제하고 BusType, Age, PRid를 primary key로 사용

- insert_all.sql
bus_insert.sql에서 수정
전체적으로 시뮬레이션 가능한 데이터 추가


- QUERY EXAMPLE
    - 동대구에서 가평으로 가는 버스의 12월 25일 10시 30분에 출발하는 버스의 남은 좌석 출력
    (아래 예시는 17석 출력)
    select * from SEAT
    where sid not in
        (SELECT distinct RE.RSID
        FROM ROUTE RO, TIMETABLE T, BUS B, RESERVATION RE
        WHERE RO.DSTATION = 'dongdaegu'
        AND RO.ASTATION = 'gapyeong'
        AND T.TRID = RO.RID
        AND T.TDATE = TO_DATE('22/12/25', 'yy/mm/dd')
        AND T.DEPART_TIME = TO_DATE('22/12/25 10:30', 'yy/mm/dd HH24:MI')
        AND T.TID = RE.RTID)
    order by sid asc;

    - 12월 25일 7시 이후에 출발하는 모든 버스 목록 출력
    select *
    from timetable t
    where t.tdate = to_date('22/12/25', 'yy/mm/dd')
    and t.depart_time >= to_date('22/12/25 07:00', 'yy/mm/dd HH24:MI');

    - 12월 24일 15시 30분에 출발하는 버스의 정보 출력
    select distinct b.bid as BUS_ID, b.bcompany as company, b.btype as BUS_TYPE,
    e.ssn as DRIVER_SSN, e.fname as fname, e.lname as lname, e.salary, d.hours
    from timetable t, bus b, employee e, drives d
    where T.TDATE = TO_DATE('22/12/24', 'yy/mm/dd')
    AND T.DEPART_TIME = TO_DATE('22/12/24 15:30', 'yy/mm/dd HH24:MI')
    and t.tbid = b.bid
    and t.tbid = d.dbid
    and d.dssn = e.ssn;