# Team5-README.txt

### 실행 방법
- /src/main/java/config/Properties.java
    해당 파일을 사용자 DB 정보에 맞춰 변경하면 사용자 DB에 접속할 수 있습니다.
    > serverIP = "IP" (ex. "localhost")
	 strSID = "SID" (ex. "orcl" or "xe")
	 portNum = "PORT" (ex. "1521")
	 user = "USER_NAME" (ex. "BUS")
	 pass = "PASSWORD" (ex. "comp322")

- /src/main/java/webapp/main.jsp
        해당 파일에서 Run As > Run on Server > Tomcat Server을 선택하면 메인 화면에서 실행 됩니다.

- 실행 후 테스트할 수 있는 아이디
    1. 상단의 Sign In 클릭
    2. ID : test1@example.net / test2@example.net
        Password : test / test
    3.  Sign In 클릭

### 기능 설명

- Sign In (src/main/webapp/login.jsp)
    로그인

- Sign Up (src/main/webapp/signup.jsp)
    회원가입

- 버스 시간표 검색 (src/main/webapp/main.jsp)
    설정한 날짜의 입력한 시간 이후의 버스 정보를 찾는 페이지로 이동
    아래는 22년 12월 25일 동대구에서 가평으로 가는 07:00 이후의 모든 버스 시간표 출력
    > DATE : 2022/12/25
    > DEPARTURE : Dondaegu
    > TIME : 07:00
    > ARRIVAL : Gapyeong
	
- 버스 시간 정보 (src/main/webapp/BUS.jsp)
    - 메인 페이지에서 설정한 값에 해당하는 버스 시간표 출력
    - Details의 Show를 누르면 해당 시간의 버스 상세 정보 출력
    - Ticket의 Book을 누르면 해당 시간의 버스 예약 페이지로 이동

- 버스 예약 (src/main/webapp/reservation.jsp)
    버스에 탑승할 인원 설정 후 좌석 체크 후 Confirm 클릭

- 내 예약 정보 보기 (src/main/webapp/myReservation.jsp)
    - 상단의 My Reservation 클릭하여 내 예약 정보 확인
    - Cancel Reservation 클릭 시 예약 취소 후 포인트 반

- 개발자 페이지 (src/main/webapp/admin/select.jsp)
    데이터 베이스 정보 확인

## 제작 환경
- Eclipse / VSCode
- JAVA
- JSP / CSS
- GitHub