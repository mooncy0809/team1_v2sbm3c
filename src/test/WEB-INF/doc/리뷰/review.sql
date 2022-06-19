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
		rdate                         		DATE		 NOT NULL,
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
COMMENT ON COLUMN review.rdate is '작성일';

DROP SEQUENCE review_seq;
CREATE SEQUENCE review_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999999
  CACHE 2                     -- 2번은 메모리에서만 계산
  NOCYCLE;                   -- 다시 1부터 생성되는 것을 방지

INSERT INTO review(reviewno, order_itemno, memberno, rtitle, rcontent, score, rdate)
VALUES (review_seq.nextval, 1, 3, '리뷰 제목', '리뷰 내용', 5, sysdate);

commit; 



