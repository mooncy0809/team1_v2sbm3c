/**********************************/
/* Table Name: 카테고리 */
/**********************************/

DROP table cate;

CREATE TABLE cate(
        cateno                                NUMBER(10)         NOT NULL         PRIMARY KEY,
        categrpno                             NUMBER(10)         NULL ,
        name                                  VARCHAR2(50)         NOT NULL,
        rdate                                 DATE         NOT NULL,
        cnt                                   NUMBER(10)         DEFAULT 0         NOT NULL,
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
);

DROP SEQUENCE cate_seq;

CREATE SEQUENCE cate_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 999999999 --> NUMBER(10) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지


COMMENT ON TABLE cate is '카테고리';
COMMENT ON COLUMN cate.cateno is '카테고리 번호';
COMMENT ON COLUMN cate.categrpno is '카테고리 그룹 번호 ';
COMMENT ON COLUMN cate.name is '카테고리 이름';
COMMENT ON COLUMN cate.rdate is '등록일';
COMMENT ON COLUMN cate.cnt is '관련 자료수';

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 2, '꿀꿀', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 2, '꿀팁입니다', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 3, '전체', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 3, '자유게시판', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 3, '팁/노하우', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 3, '고민/질문', sysdate, 0);

INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
VALUES(cate_seq.nextval, 3, '일기', sysdate, 0);


SELECT * FROM cate;

commit;
    CATENO  CATEGRPNO NAME                                               RDATE                      CNT
---------- ---------- -------------------------------------------------- ------------------- ----------
         1          7 닭가슴살                                           2022-06-03 05:34:54          0