
/**********************************/
/* Table Name: 질문게시판 */
/**********************************/
CREATE TABLE qna(
		qnano                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		categrpno                        		NUMBER(10)		 NULL ,
		MEMBERNO                      		NUMBER(10)		 NULL ,
		title                         		VARCHAR2(50)		 NOT NULL,
		content                       		VARCHAR2(1000)		 NOT NULL,
		pwd                           		NUMBER(10)		 NOT NULL,
        rdate                                   DATE             NOT NULL,
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO),
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
);

COMMENT ON TABLE qna is '질문게시판';
COMMENT ON COLUMN qna.qnano is '질문답변번호';
COMMENT ON COLUMN qna.categrpno is '카테고리 번호';
COMMENT ON COLUMN qna.MEMBERNO is '회원 번호';
COMMENT ON COLUMN qna.title is '질문답변 제목';
COMMENT ON COLUMN qna.content is '질문답변 내용';
COMMENT ON COLUMN qna.pwd is '질문답변 비밀번호';
COMMENT ON COLUMN qna.rdate is '작성일';

DROP TABLE qna;
DROP SEQUENCE qna_seq;
CREATE SEQUENCE qna_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
--1. 등록
 
--1) id 중복 확인(null 값을 가지고 있으면 count에서 제외됨)
SELECT COUNT(id)
FROM member
WHERE id='user1';

SELECT COUNT(id) as cnt
FROM member
WHERE id='user1';
 
 cnt
 ---
   0   ← 중복 되지 않음.
   
 2) 등록
 
 --INSERT INTO cate(cateno, categrpno, name, rdate, cnt)
-- VALUES(cate_seq.nextval, 4, '자신없어', sysdate, 0);

INSERT INTO qna(qnano, categrpno, memberno, title, content, pwd, rdate)
VALUES ( qna_seq.nextval, 4 , 1,  '질문', '질문내용', 1234, sysdate );

2. 목록
- 검색을 하지 않는 경우, 전체 목록 출력
SELECT qnano, categrpno, memberno, title, content, pwd
FROM qna
ORDER BY qnano ASC;
     
     
3. 조회
SELECT qnano, categrpno, memberno, title, content, pwd
FROM qna
WHERE qnano = 1;

4. 수정
UPDATE qna 
SET content='질문내용2'
WHERE memberno=1;

COMMIT;

 
5. 삭제
1) 모두 삭제
DELETE FROM qna;
 
2) 특정 질문 삭제
DELETE FROM qna
WHERE qnano=1;



SELECT m.memberno as m_memberno, m.id as m_id,
               q.qnano, q.title, q.content, q.pwd, q.rdate
    FROM member m, qna q
    WHERE m.memberno = q.memberno
    
COMMIT;