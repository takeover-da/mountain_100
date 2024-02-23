-- 게시글 테이블 생성
CREATE TABLE posts (
                       id NUMBER PRIMARY KEY,
                       author_id NUMBER,
                       title VARCHAR2(255),
                       content CLOB,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       views NUMBER DEFAULT 0,
                       FOREIGN KEY (author_id) REFERENCES users(id)
);
CREATE TABLE comments (
                          id NUMBER PRIMARY KEY,
                          post_id NUMBER,
                          author_id NUMBER,
                          content CLOB,
                          created_at TIMESTAMP(6),
                          parent_comment_id NUMBER,
                          FOREIGN KEY (parent_comment_id) REFERENCES comments(id)
);

-- 60개의 더미 게시글 생성
BEGIN
FOR i IN 1..60 LOOP
        INSERT INTO posts (id, title, content, author_id)
        VALUES (i, '테스트 제목 ' || i, '테스트 내용 ' || i, ROUND(DBMS_RANDOM.VALUE(1, 10)));
END LOOP;
COMMIT;
END;
/
