// npm i oracledb
const oracledb = require('oracledb');
const dbConfig = require('./dbconfig');

oracledb.autoCommit = true;


// Oracle 클라이언트 설치 및 경로 지정
// https://www.oracle.com/database/technologies/instant-client/downloads.html
// 반드시 Basic Package로 다운 받을 것!

// DB 선행작업
/*
CREATE TABLE users (
    id NUMBER PRIMARY KEY,  -- PK
    username VARCHAR2(50),  -- UserID 또는 User 닉네임
    password VARCHAR2(50),  -- 패스워드
    name VARCHAR2(100)      -- 실제 사용자 이름
);

INSERT INTO users (id, username, password, name) VALUES (1, 'user1', 'password1', '김철수');
INSERT INTO users (id, username, password, name) VALUES (2, 'user2', 'password2', '이영희');
INSERT INTO users (id, username, password, name) VALUES (3, 'user3', 'password3', '박민수');
commit; -- commit을 반드시 할 것!
 */
oracledb.initOracleClient({ libDir: '../instantclient_21_13' });
// oracledb.initOracleClient({ libDir: '/usr/lib/oracle/21/client64/lib' });
selectDatabase();
// async 비동기 함수 처리, 아래 db 관련 함수가 await 키워드를 사용하기 때문에 사용하는 문법
// DB Select
async function selectDatabase() {

    console.log("!!!!! db conenction !!!!!");

    // awiat: 비동기 수행시 해당 명령어가 완료될때까지 기다려주는 키워드
    let connection = await oracledb.getConnection(dbConfig);

    let binds = {}; // 쿼리에 있는 바인드 변수(JS 변수를 쿼리에 사용하고 싶을때)가 있을 때 사용.
    let options = {
        // 쿼리의 결과가 객체 형식으로 반환
        outFormat: oracledb.OUT_FORMAT_OBJECT   // query result format
    };

    console.log("!!!!! db select !!!!!");

    let result = await connection.execute("select * from user_table", binds, options);

    console.log("!!!!! db response !!!!!");
    console.log(result.rows);
    console.log(result.rows[0]);
    // 이름 열을 접근하려면? 배열일 경우
    // console.log(result.rows[0][3]);
    // console.log(result.rows[0].NAME);

    console.log("!!!!! db close !!!!!");
    await connection.close();

}