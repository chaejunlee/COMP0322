ALTER SESSION set NLS_DATE_FORMAT = 'yyyy-mm-dd HH24:MI:SS';

DROP TABLE DRIVES;
DROP TABLE PRICE;
DROP TABLE RESERVATION;

DROP table SEAT;
DROP table ACCOUNT;
DROP table TIMETABLE;

drop table BUS;
drop table ROUTE;
drop table EMPLOYEE;

drop table STATION;

-- ACCOUNT table에서 phone 만 null 값 허용, Aid는 9자리 phone은 11자리
CREATE TABLE ACCOUNT(
    Aid CHAR(9) NOT NULL,
    Fname VARCHAR(15) NOT NULL,
    Lname VARCHAR(15) NOT NULL,
    Email VARCHAR(30) NOT NULL,
    PW VARCHAR(15) NOT NULL,
    Phone CHAR(11),
    PRIMARY KEY(Aid)
);

-- Sid는 rownumber(EX: A) colnumber(ex: 2)를 jo합han A2, B3 이런 형태
CREATE TABLE SEAT(
    Sid CHAR(2) NOT NULL,
    Rownumber CHAR(1) NOT NULL,
    Colnumber CHAR(1) NOT NULL,
    PRIMARY KEY (Sid)
);

-- Bid는 4295, 0918과 같은 문자형 4자리, Btype에는 우등, il반 , bcompany는 dae원고속 등등
CREATE TABLE BUS(
    Bid CHAR(4) NOT NULL,
    Bcompany VARCHAR(30) NOT NULL,
    Btype VARCHAR(10) NOT NULL,
    PRIMARY KEY (Bid)
);

-- STNAME은 영어로 BUSAN, SEOUL 이런 sik, ZIPCODE는 42855처럼 5자리 문자열
CREATE TABLE STATION(
    STname VARCHAR(30) NOT NULL,
    TotalPlatform NUMBER,
    Address VARCHAR(150) NOT NULL,
    Zipcode CHAR(5),
    PRIMARY KEY (STname)
);

-- Rid는 그냥 primary key 주려고 han거 의mi없음 (있으면 좋eul 것 같긴han데 의mi 생각ha면 inserthagi 힘들듯)
CREATE TABLE ROUTE(
    Rid NUMBER NOT NULL,
    Dstation VARCHAR(30) NOT NULL,
    Astation VARCHAR(30) NOT NULL,
    Dplatform NUMBER NOT NULL,
    Aplatform NUMBER NOT NULL,
    PRIMARY KEY (Rid),
    FOREIGN KEY (Dstation) REFERENCES STATION(STname),
    FOREIGN KEY (Astation) REFERENCES STATION(STname)
);

-- Pid도 그냥 primary key 주려고 han것, age는 실제 23살 na이ga ah니ra 어른, 어린이와 같은 문자열, bustype은 앞에 bus랑 같음, 
CREATE TABLE PRICE(
    Pid VARCHAR(30) NOT NULL,
    Age VARCHAR(30) NOT NULL,
    BusType VARCHAR(30) NOT NULL,
    Fee NUMBER NOT NULL,
    PRid NUMBER NOT NULL,
    PRIMARY KEY (Pid),
    FOREIGN KEY (PRid) REFERENCES ROUTE(Rid)
);

-- Tid도 그냥 primary key, TDate는 날짜, dtime 이랑 atime은 시간형sik으로 넣어야함
CREATE TABLE TIMETABLE(
    Tid NUMBER NOT NULL,
    TDate DATE NOT NULL,
    Depart_time TIMESTAMP NOT NULL,
    Arrive_time TIMESTAMP NOT NULL,
    TBid CHAR(4) NOT NULL,
    TRid NUMBER NOT NULL,
    PRIMARY KEY (Tid),
    FOREIGN KEY (TBid) REFERENCES BUS(Bid),
    FOREIGN KEY (TRid) REFERENCES ROUTE(Rid)
);

-- 그냥 weak entity
CREATE TABLE RESERVATION(
    RAid CHAR(9) NOT NULL,
    RSid CHAR(2) NOT NULL,
    RTid NUMBER NOT NULL,
    PRIMARY KEY (RSid, RTid),
    FOREIGN KEY (RAid) REFERENCES ACCOUNT(Aid),
    FOREIGN KEY (RSid) REFERENCES SEAT(Sid),
    FOREIGN KEY (RTid) REFERENCES TIMETABLE(Tid)
);

-- ssn은 앞에 account의 aid와 비슷han 느낌, salary랑, ESname은 null 허용, esname은 employeega 근무ha는 역 이름lim
CREATE TABLE EMPLOYEE(
    Ssn CHAR(9) NOT NULL,
    Fname VARCHAR(30) NOT NULL,
    Lname VARCHAR(30) NOT NULL,
    Salary NUMBER,
    ESname VARCHAR(30),
    PRIMARY KEY (Ssn),
    FOREIGN KEY (ESname) REFERENCES Station(STname)
);

-- hours는 그냥 그 사람이 그 버스 unjeonhan 시간으로 해서 (3, 1) 해도 될것 같은데 혹시na 100 이상 될까봐 (4,1)로 뒀음.
CREATE TABLE DRIVES(
    DBid CHAR(4) NOT NULL,
    DSsn CHAR(9) NOT NULL,
    Hours NUMBER(4,1),
    PRIMARY KEY (DBid, DSsn),
    FOREIGN KEY (DBid) REFERENCES BUS(Bid),
    FOREIGN KEY (DSsn) REFERENCES EMPLOYEE(Ssn)
);

commit;