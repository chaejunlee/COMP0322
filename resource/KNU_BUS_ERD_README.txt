# ENTITY

ACCOUNT
  - Aid [primary key]
  - Login(email [candidate key], password)
  - APhone_number
  - AName(AFirst_name, ALast_name)

 설명:
  > Account를 구분짓기 위한 Aid를 저장합니다.
  > 예약 서비스이기 때문에 로그인을 위한 email과 password를 저장합니다.
  > 인증을 위한 전화번호를 저장합니다.
  > 회원의 이름을 저장합니다.
 
TICKET
  - Tid [primary key]
  - Customer_age

 설명:
  > Ticket을 구분짓기 위한 Tid를 저장합니다.
  > 티켓의 가격을 결정하기 위해 구매자의 나이를 저장합니다.

TRIP [Weak Entity]
 설명:
  > Ticket과 관련된 모든 정보를 저장하는 엔티티입니다.
  > 각각 엔티티의 FK를 모두 조합한 Superkey를 key로 갖습니다.
  > 하나에 티켓에 들어가는 여행 세부 정보의 중복을 최소화하고자 trip을 weak entity로 따로 분리해내었습니다.
  > 따로 attribute를 생각해내지는 못했습니다. Attribute들은 모두 Entity로 분리해내었습니다.

STATION 
  - STid [primary key]
  - STName
  - Num_Of_Platforms
 설명:
  > 출발역이자 도착역의 정보를 저장합니다.
 
EMPLOYEE
  - Eid [primary key]
  - EName(EFirst_name, ELast_name)
  - Department
 설명:
  > 버스 회사의 직원을 저장합니다.
  > Relation에서 버스 운전 기사로 사용됩니다.
 
BUS
  - Bid [primary key]
  - BCompany
  - BType
 설명:
  > 운행에 사용되는 버스의 정보를 저장합니다.

SEAT
  - SEAT_id [partial key]
 설명:
  > 운행하는 버스의 좌석을 저장합니다.
  > 좌석은 버스에 Dependent한 Entity라고 판단해 Weak Entity로 구성하였습니다.
  > 그런데 TRIP과 Relation을 연결하면서 Strong Entity로 바꿔야하지 않을까 생각이 들어 ER Schema를 구성할 때 다시 생각하기로 하였습니다.
 
# RELATION 

BUYS
= ACCOUNT (customer) <BUYS> (available ticket) TICKET
= 1:N
 설명:
  > "한 명의 회원이 N개의 티켓을 산다"의 Relation 입니다.
  > ACCOUNT는 partial participation을 가지고 있고 TICKET은 total participation을 가지고 있습니다.

DESCRIBES
= TICKET (ticket) <DESCRIBES> (available trip) TRIP
= 1:1
  - available
  - price
 설명:
  > TICKET이 가지고 있는 TRIP의 정보에 대한 Relation 입니다.
  > 이 관계를 통해 어떤 운행에 대한 자리가 예매 여부와 해당 표의 가격이 저장됩니다.
  > TRIP의 자리에 바로 TICKET을 넣어도 되지 않을까 생각이 들어 ER Schema 때 다시 돌아와 수정할 계획입니다.

ARRIVES_AT
= TRIP (incoming bus) <ARRIVES_AT> (destination station) STATION 
= 1:N
  - arriving_platform
  - arriving_time
 설명:
  > TRIP에 대해서 버스가 어디에서 출발하는지를 나타내는 Relation 입니다.
  > 출발에 대한 탑승구와 출발 시간을 attribute로 갖습니다.
  > 출발과 도착에 대해서 중복이 있어서 STATION을 Entity로 분리해낸 뒤 2개의 Relation으로 TRIP과 연결해주었습니다.

DEPARTS_FROM
= TRIP (leaving bus) <DEPARTS_FROM> (origin station) STATION
= 1:N
  - departing_platform
  - departing_time
 설명:
  > TRIP에 대해서 버스의 목적지를 나타내는 Relation 입니다.
  > 도착에 대한 탑승구와 도착 시간을 attribute로 갖습니다.

DRIVES
= EMPLOYEE (driver) <DRIVES> (bus) TRIP
= 1:N
 설명:
  > TRIP에 대해서 버스를 운전하는 운전자를 나타내는 Relation 입니다.
  > BUS에 연결을 해야할지, TRIP에 연결을 해야할지 고민을 했습니다만 TRIP에 연결하는 것으로 결정하였습니다. 해당 부분은 ER Schema에서 다시 고민해 결정하겠습니다.
  

USED_FOR
= BUS (bus) <USED_FOR> (trip) TRIP
= 1:N
 설명:
  > TRIP에 사용되는 BUS를 나타내는 Relation 입니다.

HAS
= BUS (bus) <HAS> (seat) SEAT
= 1:N
 설명:
  > BUS에 속하는 SEAT를 나타내는 Relation 입니다.
  > 위 Relation 때문에 SEAT를 weak entity로 결정하게 되었습니다.
  > 중복을 피하기 위해 SEAT를 버스로부터 분리해냈습니다.
  > 예를 들어 BUS 1의 A1 좌석과 BUS 2의 A1 좌석은 이름은 같지만 다르기 때문에 weak entity로 분리해내었습니다.

BOOKS
= TRIP (trip) <BOOKS> (available seat) SEAT
= 1:1
  - available
  - price
 설명:
  > TRIP이 예약하게 되는 SEAT를 나타내는 Relation 입니다.
  > 이 부분에서 weak entity인 SEAT를 TRIP과 1:N 관계로 이어야하는지 1:1 관계로 이어야하는지 고민을 했습니다. 실제로 DB에서는 같은 SEAT를 여러 TRIP이 가리키겠지만 논리적으로는 1:1이 맞는 것 같아서 우선 1:1로 결정했습니다. ER Schema를 구성할 때 다시 고민해보려 합니다.