/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
CREATE TABLE categrp(
		categrpno                     		NUMBER(10)		 NOT NULL PRIMARY KEY,
		name                          		VARCHAR2(50)		 NOT NULL,
		seqno                         		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		visible                       		CHAR(1)		 DEFAULT 'y'		 NOT NULL,
		rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE categrp is '카테고리 그룹';
COMMENT ON COLUMN categrp.categrpno is '카테고리 그룹 번호';
COMMENT ON COLUMN categrp.name is '이름';
COMMENT ON COLUMN categrp.seqno is '출력 순서';
COMMENT ON COLUMN categrp.visible is '출력 모드';
COMMENT ON COLUMN categrp.rdate is '그룹 생성일';

CREATE SEQUENCE categrp_seq
  START WITH 1           -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 99999999 -- 최대값: 99999999 --> NUMBER(8) 대응
  CACHE 2                  -- 2번은 메모리에서만 계산
  NOCYCLE;                -- 다시 1부터 생성되는 것을 방지

drop sequence categrp_seq;

-- Create, 등록
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '공지사항', 1, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '다이어트 꿀팁', 2, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '커뮤니티', 3, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '홈트레이닝', 4, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '칼로리사전', 5, 'Y', sysdate);

commit;

-- List, 목록
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY categrpno ASC;

 CATEGRPNO NAME                                                    SEQNO V RDATE              
---------- -------------------------------------------------- ---------- - -------------------
         1 공지사항                                                    1 Y 2022-06-02 11:48:41
         2 다이어트 꿀팁                                               2 Y 2022-06-02 11:48:41
         3 커뮤니티                                                    3 Y 2022-06-02 11:48:41
         4 홈트레이닝                                                  4 Y 2022-06-02 11:48:41
         5 칼로리사전                                                  5 Y 2022-06-02 11:48:41


-- Read, 조회
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
WHERE categrpno = 1;

 CATEGRPNO NAME                                                    SEQNO V RDATE              
---------- -------------------------------------------------- ---------- - -------------------
         1 영화                                                        1 Y 2022-02-24 12:07:48

/**********************************/
/* Table Name: 카테고리 */
/**********************************/
CREATE TABLE cate(
		cateno                        		NUMBER(10)		 NOT NULL,
		categrpno                     		NUMBER(10)		 NULL 
);

COMMENT ON TABLE cate is '카테고리';
COMMENT ON COLUMN cate.cateno is '카테고리 번호';
COMMENT ON COLUMN cate.categrpno is '카테고리 그룹 번호';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		memberno                      		NUMBER(10)		 NOT NULL
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.memberno is '회원 번호';


/**********************************/
/* Table Name: 컨텐츠 */
/**********************************/
CREATE TABLE contents(
		contentsno                    		NUMBER(10)		 NOT NULL,
		cateno                        		NUMBER(10)		 NULL ,
		memberno                      		NUMBER(10)		 NULL 
);

COMMENT ON TABLE contents is '컨텐츠';
COMMENT ON COLUMN contents.contentsno is '컨텐츠 번호';
COMMENT ON COLUMN contents.cateno is '카테고리 번호';
COMMENT ON COLUMN contents.memberno is '회원 번호';



ALTER TABLE categrp ADD CONSTRAINT IDX_categrp_PK PRIMARY KEY (categrpno);

ALTER TABLE cate ADD CONSTRAINT IDX_cate_PK PRIMARY KEY (cateno);
ALTER TABLE cate ADD CONSTRAINT IDX_cate_FK0 FOREIGN KEY (categrpno) REFERENCES categrp (categrpno);

ALTER TABLE member ADD CONSTRAINT IDX_member_PK PRIMARY KEY (memberno);

ALTER TABLE contents ADD CONSTRAINT IDX_contents_PK PRIMARY KEY (contentsno);
ALTER TABLE contents ADD CONSTRAINT IDX_contents_FK0 FOREIGN KEY (cateno) REFERENCES cate (cateno);
ALTER TABLE contents ADD CONSTRAINT IDX_contents_FK1 FOREIGN KEY (memberno) REFERENCES member (memberno);

SELECT * from categrp;

DELETE FROM categrp;
commit;

SELECT categrpno, name, seqno, visible, rdate 
FROM categrp
WHERE categrpno = 21;

UPDATE categrp
SET name='업무 양식', seqno = 3, visible='Y'
WHERE categrpno = 23;

commit;
