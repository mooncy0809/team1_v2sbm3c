/**********************************/
/* Table Name: 리뷰 */
/**********************************/
drop table review;
CREATE TABLE review(
		reviewno                      	    NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		order_itemno                  		NUMBER(10)		 NULL ,
        memberno                      		NUMBER(10)		 NULL ,
		rtitle                        		VARCHAR2(50)		 NOT NULL,
		rcontent                      		VARCHAR2(2000)		 NOT NULL,
		score                         		NUMBER(10)		 NOT NULL,
        cnt                                NUMBER(7)       DEFAULT 0         NOT NULL,
		rdate                         		DATE		 NOT NULL,
		FILE1                         		VARCHAR2(100)		 NULL ,
		FILE1SAVED                    		VARCHAR2(100)		 NULL ,
		THUMB1                        		VARCHAR2(100)		 NULL ,
		SIZE1                         		NUMBER(10)		DEFAULT 0 NULL,
        mname                               VARCHAR(20)       NULL,
	    PRODUCTNO                       NUMBER(10,0)   NOT NULL,
  FOREIGN KEY (order_itemno) REFERENCES order_item (order_itemno),
  FOREIGN KEY (memberno) REFERENCES member (memberno)
);

COMMENT ON TABLE review is '리뷰';
COMMENT ON COLUMN review.reviewno is '리뷰 번호';
COMMENT ON COLUMN review.order_itemno is '주문상세번호';
COMMENT ON COLUMN review.memberno is '회원번호';
COMMENT ON COLUMN review.rtitle is '리뷰 제목';
COMMENT ON COLUMN review.rcontent is '리뷰 내용';
COMMENT ON COLUMN review.score is '별점';
COMMENT ON COLUMN review.cnt is '조회수';
COMMENT ON COLUMN review.rdate is '작성일';
COMMENT ON COLUMN review.FILE1 is '메인 이미지';
COMMENT ON COLUMN review.FILE1SAVED is '실제 저장된 메인 이미지';
COMMENT ON COLUMN review.THUMB1 is '메인 이미지 Preview';
COMMENT ON COLUMN review.SIZE1 is '메인 이미지 크기';
COMMENT ON COLUMN review.MNAME is '작성자';

DROP SEQUENCE review_seq;
CREATE SEQUENCE review_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지

Insert into TEAM1.REVIEW (REVIEWNO,ORDER_ITEMNO,RTITLE,RCONTENT,SCORE,RDATE,MEMBERNO,CNT,FILE1,FILE1SAVED,THUMB1,SIZE1,MNAME,PRODUCTNO) values (7,9,'맛있어요!!','맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!맛있어요!!ㅍㅍㅍㅍ맛있어요!!맛있어요!!맛있어요!!맛있어요!!',3,to_date('2022-06-19 09:25:57','YYYY-MM-DD HH:MI:SS'),3,21,'crush2.jpg','crush2_1.jpg','crush2_1_t.jpg',304860,'왕눈이',1);
Insert into TEAM1.REVIEW (REVIEWNO,ORDER_ITEMNO,RTITLE,RCONTENT,SCORE,RDATE,MEMBERNO,CNT,FILE1,FILE1SAVED,THUMB1,SIZE1,MNAME,PRODUCTNO) values (2,6,'ddd','asdasd',3,to_date('2022-06-17 05:01:42','YYYY-MM-DD HH:MI:SS'),3,2,'crush3.jpg','crush3_1.jpg','crush3_1_t.jpg',60459,'왕눈이',0);
Insert into TEAM1.REVIEW (REVIEWNO,ORDER_ITEMNO,RTITLE,RCONTENT,SCORE,RDATE,MEMBERNO,CNT,FILE1,FILE1SAVED,THUMB1,SIZE1,MNAME,PRODUCTNO) values (3,6,'ddd','dddd',2,to_date('2022-06-17 05:03:55','YYYY-MM-DD HH:MI:SS'),3,32,'crush.jpg','crush.jpg','crush_t.jpg',77647,'왕눈이',1);
Insert into TEAM1.REVIEW (REVIEWNO,ORDER_ITEMNO,RTITLE,RCONTENT,SCORE,RDATE,MEMBERNO,CNT,FILE1,FILE1SAVED,THUMB1,SIZE1,MNAME,PRODUCTNO) values (4,8,'213','123',3,to_date('2022-06-17 05:57:20','YYYY-MM-DD HH:MI:SS'),3,0,'crush2.jpg','crush2.jpg','crush2_t.jpg',304860,'왕눈이',4);
Insert into TEAM1.REVIEW (REVIEWNO,ORDER_ITEMNO,RTITLE,RCONTENT,SCORE,RDATE,MEMBERNO,CNT,FILE1,FILE1SAVED,THUMB1,SIZE1,MNAME,PRODUCTNO) values (8,11,'123','123',3,to_date('2022-06-20 12:30:13','YYYY-MM-DD HH:MI:SS'),4,1,'식단.jpg','식단.jpg','식단_t.jpg',107592,'아로미',1);
Insert into TEAM1.REVIEW (REVIEWNO,ORDER_ITEMNO,RTITLE,RCONTENT,SCORE,RDATE,MEMBERNO,CNT,FILE1,FILE1SAVED,THUMB1,SIZE1,MNAME,PRODUCTNO) values (9,13,'123123','123123123',3,to_date('2022-06-20 12:32:10','YYYY-MM-DD HH:MI:SS'),4,0,'fanxy.jpg','fanxy.jpg','fanxy_t.jpg',128895,'아로미',1);

commit; 



