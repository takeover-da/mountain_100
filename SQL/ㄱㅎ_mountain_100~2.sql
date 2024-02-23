-- ����� ����
CREATE TABLE user_table (
                       id VARCHAR2(50) NOT NULL,           -- ID
                       password VARCHAR2(50),              -- �н�����
                       gender VARCHAR2(10),                -- ����
                       name VARCHAR2(100),                 -- �̸�
                       birth DATE,                         -- �������
                       nickname VARCHAR2(100),             -- �г���
                       signup_date DATE DEFAULT SYSDATE,   -- ��������
                       user_code NUMBER PRIMARY KEY        -- �����PK
);

INSERT INTO user_table 
    (id, password, gender, name, birth, nickname, signup_date, user_code) 
    VALUES ('user1', 'password1', 'M', '������', TO_DATE('19900101', 'YYYYMMDD'), 'ĸƾ��', TO_DATE('20220101', 'YYYYMMDD'), 1);
INSERT INTO user_table 
    (id, password, gender, name, birth, nickname, signup_date, user_code) 
    VALUES ('user2', 'password2', 'M', '���μ�', TO_DATE('19851215', 'YYYYMMDD'), '�����μ�',TO_DATE('20220215', 'YYYYMMDD'), 2);
INSERT INTO user_table 
    (id, password, gender, name, birth, nickname, signup_date, user_code) 
    VALUES ('user3', 'password3', 'F', '������', TO_DATE('19780325', 'YYYYMMDD'), '�������', TO_DATE('20220301', 'YYYYMMDD'), 3 );
INSERT INTO user_table 
    (id, password, gender, name, birth, nickname, signup_date, user_code) 
    VALUES ('user4', 'password4', 'F', '�밡��', TO_DATE('19951210', 'YYYYMMDD'), '���������', TO_DATE('20220410', 'YYYYMMDD'), 4 );

select * from user_table;
describe user_table;
drop table user_table;


CREATE SEQUENCE user_table_seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;



-- ������
CREATE TABLE mount (
    mount_name VARCHAR2(50),         -- ���̸�
    ST_X NUMBER,                     -- ����
    ST_Y NUMBER,                     -- �浵
    mount_code NUMBER PRIMARY KEY,   -- ���ڵ�
    location VARCHAR2(50)            -- �õ���
);

select * from mount;
describe mount;
drop table mount;



-- �� ������
CREATE TABLE mount_detail (
    mount_code NUMBER,
    FOREIGN KEY (mount_code) REFERENCES mount(mount_code),  -- ���ڵ�(FK)
    address VARCHAR2(25),                                    -- ������
    mount_height NUMBER,                                    -- �� ����
    mount_level VARCHAR2(255),                              -- ���̵�/����ð�
    mount_description CLOB,                                 -- Ư¡
    traffic CLOB                                            -- ��������    
);

select * from mount_detail;
describe mount_detail;
drop table mount_detail;



-- �� �̹��� �Խ���
CREATE TABLE mount_img (
    boarder_code NUMBER PRIMARY KEY,                           -- �Խ��� �ڵ�
    user_code NUMBER, 
    FOREIGN KEY (user_code) REFERENCES user_table(user_code),  -- �����PK(FK)
    image_path VARCHAR2(225),                                  -- �̹��� ���
    likes NUMBER DEFAULT 0,                                    -- ���ƿ� ��
    mount_code NUMBER,
    FOREIGN KEY (mount_code) REFERENCES mount(mount_code),     -- ���ڵ�(FK)
    comments CLOB                                              -- �󼼳���
);

select * from mount_img;
describe mount_img;
drop table mount_img;

CREATE SEQUENCE mount_img_seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;


-- �Խ���
CREATE TABLE boarder (
    boarder_code NUMBER PRIMARY KEY,                           -- �Խ��� �ڵ�
    user_code NUMBER, 
    FOREIGN KEY (user_code) REFERENCES user_table(user_code),  -- �����PK(FK)
    title VARCHAR2(255),                                       -- ����
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,            -- �ۼ�����
    content CLOB,                                              -- ����                     
    views NUMBER DEFAULT 0,                                    -- ��ȸ��
    likes NUMBER DEFAULT 0,                                    -- ���ƿ��
    image_path VARCHAR2(255),                                  -- �̹��� ���
    mount_code NUMBER,
    FOREIGN KEY (mount_code) REFERENCES mount(mount_code)      -- ���ڵ�(FK)                      
);

select * from boarder;
describe boarder;
drop table boarder;

CREATE SEQUENCE boarder_seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;



-- �Խ��� ���
CREATE TABLE boarder_comments (
    id number primary key,
    boarder_code NUMBER PRIMARY KEY,                                             -- �Խ��� �ڵ�
    user_code NUMBER, 
    FOREIGN KEY (user_code) REFERENCES user_table(user_code),                    -- �����PK(FK)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                              -- �ۼ�����
    content CLOB,                                                                -- ����
    parent_comment_id number,
    foreign key (user_code) references user_table(user_code),
    foreign key (boarder_code) references boarder(boarder_code),
    FOREIGN KEY (parent_comment_id) REFERENCES boarder_comments(boarder_code)    -- ���ۿ�
);

select * from boarder_comments;
describe boarder_comments;
drop table boarder_comments;

CREATE SEQUENCE boarder_comments_seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;


-- ���θ�(�Խ���)
CREATE TABLE customshop (
    boarder_code NUMBER PRIMARY KEY,                           -- �Խ��� �ڵ�
    user_code NUMBER, 
    FOREIGN KEY (user_code) REFERENCES user_table(user_code),  -- �����PK(FK)
    title VARCHAR2(255),                                       -- ����
    contents CLOB,                                             -- ������  
    price NUMBER,                                              -- ����
    likes NUMBER DEFAULT 0,                                    -- ���ƿ��
    image_path VARCHAR2(255)                                  -- �̹��� ���                   
);

select * from customshop;
describe customshop;
drop table customshop;

create sequence customshop_comment_seq
    start with 1
    increment by 1
  NOMAXVALUE;



-- ���θ� ���(����)
CREATE TABLE customshop_comments (
    id number primary key,
    boarder_code NUMBER PRIMARY KEY,                           -- �Խ��� �ڵ�
    user_code NUMBER, 
    FOREIGN KEY (user_code) REFERENCES user_table(user_code),  -- �����PK(FK)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,            -- �ۼ�����
    content CLOB,
    parent_comment_id number,
    foreign key (boarder_code) references customshop(boarder_code),
    foreign key (parent_comment_id) references customshop_comments(id)-- ����
);

select * from customshop_comments;
describe customshop_comments;
drop table customshop_comments;

CREATE SEQUENCE customshop_comments_seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;



-- Ŀ��
commit;

select * from user_tables;
SELECT sequence_name
FROM user_sequences;



