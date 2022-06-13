/**********************************/
/* Table Name: 게시물 - 커뮤니티 */
/**********************************/
drop table contents;
CREATE TABLE CONTENTS(
		CONTENTSNO                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEMBERNO                      		NUMBER(10)		 NOT NULL ,
		cateno                        		NUMBER(10)		 NOT NULL ,
		TITLE                         		VARCHAR2(300)		 NOT NULL,
		CONTENT                       		CLOB		 NOT NULL,
		RECOM                         		NUMBER(7)		 DEFAULT 0         NOT NULL,
		CNT                           		NUMBER(7)		 DEFAULT 0         NOT NULL,
		REPLYCNT                      		NUMBER(7)		 DEFAULT 0         NOT NULL,
		PASSWD                        		VARCHAR2(15)		 NOT NULL,
		WORD                          		VARCHAR2(300)		 NULL ,
		RDATE                         		DATE		 NOT NULL,
		FILE1                         		VARCHAR2(100)		 NULL ,
		FILE1SAVED                    		VARCHAR2(100)		 NULL ,
		THUMB1                        		VARCHAR2(100)		 NULL ,
		SIZE1                         		NUMBER(10)		DEFAULT 0 NULL,
        mname                               VARCHAR(20)       NULL,
  FOREIGN KEY (cateno) REFERENCES cate (cateno),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE CONTENTS is '게시물 - 커뮤니티';
COMMENT ON COLUMN CONTENTS.CONTENTSNO is '컨텐츠 번호';
COMMENT ON COLUMN CONTENTS.MEMBERNO is '회원 번호';
COMMENT ON COLUMN CONTENTS.cateno is '카테고리 번호';
COMMENT ON COLUMN CONTENTS.TITLE is '제목';
COMMENT ON COLUMN CONTENTS.CONTENT is '내용';
COMMENT ON COLUMN CONTENTS.RECOM is '추천수';
COMMENT ON COLUMN CONTENTS.CNT is '조회수';
COMMENT ON COLUMN CONTENTS.REPLYCNT is '댓글수';
COMMENT ON COLUMN CONTENTS.PASSWD is '패스워드';
COMMENT ON COLUMN CONTENTS.WORD is '검색어';
COMMENT ON COLUMN CONTENTS.RDATE is '등록일';
COMMENT ON COLUMN CONTENTS.FILE1 is '메인 이미지';
COMMENT ON COLUMN CONTENTS.FILE1SAVED is '실제 저장된 메인 이미지';
COMMENT ON COLUMN CONTENTS.THUMB1 is '메인 이미지 Preview';
COMMENT ON COLUMN CONTENTS.SIZE1 is '메인 이미지 크기';
COMMENT ON COLUMN CONTENTS.MNAME is '작성자';

DROP SEQUENCE contents_seq;

CREATE SEQUENCE contents_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지
  
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
                              file1, file1saved, thumb1, size1, mname)
VALUES(contents_seq.nextval, 1, 4, '인터스텔라', '앤헤서웨이 주연', 0, 0, 0, '123', '우주', sysdate,
            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, '크러쉬');

-- FK 컬럼의 값이 사전에 등록되었는지 확인
-- ORA-02291: integrity constraint (AI8.SYS_C007066) violated - parent key not found

INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
                              file1, file1saved, thumb1, size1, mname)
VALUES(contents_seq.nextval, 1, 4, '마션', '멧데이먼 주연 화성 탈출', 0, 0, 0, '123', '우주', sysdate,
            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, '크러쉬');
            
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
                              file1, file1saved, thumb1, size1, mname)
VALUES(contents_seq.nextval, 1, 4, 'AI', '주드로', 0, 0, 0, '123', '로봇,인공지능', sysdate,
            'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, '크러쉬');  
            
commit;
  

/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE reply(
		replyno                       		INTEGER(10)		 NULL 		 PRIMARY KEY,
		CONTENTSNO                    		NUMBER(10)		 NULL ,
		MEMBERNO                      		NUMBER(10)		 NULL ,
		content                       		VARCHAR2(1000)		 NOT NULL,
  FOREIGN KEY (CONTENTSNO) REFERENCES CONTENTS (CONTENTSNO),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE reply is '댓글';
COMMENT ON COLUMN reply.replyno is '댓글 번호';
COMMENT ON COLUMN reply.CONTENTSNO is '컨텐츠 번호';
COMMENT ON COLUMN reply.MEMBERNO is '회원 번호';
COMMENT ON COLUMN reply.content is '내용';