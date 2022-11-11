Team5-README.txt

# 환경 설정

1. sqldeveloper에서 실행해주세요.

- 한글 데이터가 있어서 sqlplus로 돌리면 한글이 깨집니다.

2. 인코딩을 utf8로 해주세요

- 한글 데이터가 있어서 utf8로 설정해야 합니다.

- 설정 방법: preferences > environment > encoding: UTF8

3. Date Format을 'yyyy-mm-dd hh24:mi:ss'로 해주세요

- 각 실행 파일마다 설정을 해두었지만 Date format을 설정해주세요.

- 설정 방법: preferences > Database > NLS > Date Format: yyyy-mm-dd hh24:mi:ss

# 실행 순서

1. bus_schema.sql을 실행해주세요.

- bus_schema.sql을 실행해서 먼저 schema를 생성해주세요.

- 테이블은 총 10개 입니다.

2. bus_insert.sql을 실행해주세요.

- bus_insert.sql을 실행해서 튜플(데이터)을 삽입해주세요.

- 튜플(데이터)을 총 1730개 입니다.

3. bus_query.sql을 실행해주세요.

- bus_query.sql을 실행해서 쿼리를 실행해주세요.

- 쿼리는 총 22개 입니다.