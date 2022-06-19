/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
DROP TABLE cate;
DROP TABLE categrp;

CREATE TABLE categrp(
      categrpno                           NUMBER(10)       NOT NULL PRIMARY KEY,
      name                                VARCHAR2(50)       NOT NULL,
      seqno                               NUMBER(10)       DEFAULT 0       NOT NULL,
      visible                             CHAR(1)       DEFAULT 'y'       NOT NULL,
      rdate                               DATE       NOT NULL
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

drop sequence cate_seq;

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

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '추천상품', 6, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES(categrp_seq.nextval, '베스트', 7, 'Y', sysdate);
commit;

-- List, 목록
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY categrpno ASC;

 CATEGRPNO NAME                                                    SEQNO V RDATE   
---------- -------------------------------------------------- ---------- - --------
         1 공지사항                                                    1 Y 22/06/03
         2 다이어트 꿀팁                                               2 Y 22/06/03
         3 커뮤니티                                                    3 Y 22/06/03
         4 홈트레이닝                                                  4 Y 22/06/03
         5 칼로리사전                                                  5 Y 22/06/03
         6 추천상품                                                    6 N 22/06/03

-- Read, 조회
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
WHERE categrpno = 1;

 CATEGRPNO NAME                                                    SEQNO V RDATE              
---------- -------------------------------------------------- ---------- - -------------------
         1 공지사항                                                    1 Y 2022-06-03 05:34:26