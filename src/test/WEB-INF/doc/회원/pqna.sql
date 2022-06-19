/**********************************/
/* Table Name: 상품 */
/**********************************/
CREATE TABLE products(
        productno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        cateno                                NUMBER(10)         NOT NULL ,
        ptitle                                 VARCHAR2(300)         NOT NULL,
        pcontent                               CLOB                  NOT NULL,
        precom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        pcnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        preplycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        ppasswd                                VARCHAR2(15)         NOT NULL,
        pword                                  VARCHAR2(300)         NULL ,
        rdate                                 DATE               NOT NULL,
        pfile1                                   VARCHAR(100)          NULL, -- 원본 파일명 이미지
        pfile1saved                            VARCHAR(100)          NULL, --저장된 파일명 이미지
        pthumb1                              VARCHAR(100)          NULL, --preview image
        psize1                                 NUMBER(10)      DEFAULT 0 NULL,  --파일사이즈
        price                                 NUMBER(10)      DEFAULT 0 NULL,  
        dc                                    NUMBER(10)      DEFAULT 0 NULL,  
        saleprice                            NUMBER(10)      DEFAULT 0 NULL,  
        point                                 NUMBER(10)      DEFAULT 0 NULL,  
        salecnt                               NUMBER(10)      DEFAULT 0 NULL,  
  FOREIGN KEY (cateno) REFERENCES cate (cateno)
);

COMMENT ON TABLE products is '컨텐츠-상품';
COMMENT ON COLUMN products.productno is '컨텐츠 번호';
COMMENT ON COLUMN products.cateno is '카테고리 번호';
COMMENT ON COLUMN products.ptitle is '제목';
COMMENT ON COLUMN products.pcontent is '내용';
COMMENT ON COLUMN products.precom is '추천수';
COMMENT ON COLUMN products.pcnt is '조회수';
COMMENT ON COLUMN products.preplycnt is '댓글수';
COMMENT ON COLUMN products.ppasswd is '패스워드';
COMMENT ON COLUMN products.pword is '검색어';
COMMENT ON COLUMN products.rdate is '등록일';
COMMENT ON COLUMN products.pfile1 is '메인 이미지';
COMMENT ON COLUMN products.pfile1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN products.pthumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN products.psize1 is ' 메인 이미지 크기';
COMMENT ON COLUMN products.price is '정가';
COMMENT ON COLUMN products.dc is '할인률';
COMMENT ON COLUMN products.saleprice is '판매가';
COMMENT ON COLUMN products.point is '포인트';
COMMENT ON COLUMN products.salecnt is '수량';

CREATE SEQUENCE products_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

DROP TABLE products;
DROP SEQUENCE products_seq;
/**********************************/
/* Table Name: 상품 문의 */
/**********************************/
CREATE TABLE pqna(
		pqnano                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		MEMBERNO                      		NUMBER(10)		 NULL ,
		productno                     		NUMBER(10)		 NULL ,
		ptitle                        		VARCHAR2(50)		 NOT NULL,
		pcontent                      		VARCHAR2(1000)		 NOT NULL,
		ppwd                          		NUMBER(10)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO),
  FOREIGN KEY (productno) REFERENCES PRODUCTS (productno)
);

COMMENT ON TABLE pqna is '상품 문의';
COMMENT ON COLUMN pqna.pqnano is '질문답변번호';
COMMENT ON COLUMN pqna.MEMBERNO is '회원 번호';
COMMENT ON COLUMN pqna.productno is '상품 번호';
COMMENT ON COLUMN pqna.ptitle is '질문답변 제목';
COMMENT ON COLUMN pqna.pcontent is '질문답변 내용';
COMMENT ON COLUMN pqna.ppwd is '질문답변 비밀번호';
COMMENT ON COLUMN pqna.rdate is '문의 날짜';

DROP SEQUENCE pqna_seq;
CREATE SEQUENCE pqna_seq
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
INSERT INTO products(productno, cateno, ptitle, pcontent, precom, pcnt, preplycnt, ppasswd, pword, rdate, price, dc, saleprice, point, salecnt)
VALUES(products_seq.nextval, 1, '아임웰 훈제 닭가슴살', '아주 맛있는 훈제 닭가슴살', 0, 0, 0, '123', '닭가슴살', sysdate,2000, 10, 1800, 100, 500);

INSERT INTO pqna(pqnano, memberno, productno, ptitle, pcontent, ppwd, rdate)
VALUES ( pqna_seq.nextval, 1, 1, '상품질문', '상품질문내용', 1234, sysdate );

2. 목록
- 검색을 하지 않는 경우, 전체 목록 출력
SELECT pqnano, memberno, productno, ptitle, pcontent, ppwd, rdate
FROM pqna
ORDER BY pqnano ASC;
     
     
3. 조회
SELECT pqnano, memberno, productno, ptitle, pcontent, ppwd, rdate
FROM pqna
WHERE memberno = 1;

4. 수정
UPDATE pqna 
SET pcontent='상품내용2'
WHERE memberno=1;

COMMIT;

 
5. 삭제
1) 모두 삭제
DELETE FROM pqna;
 
2) 특정 질문 삭제
DELETE FROM pqna
WHERE pqnano=1;

COMMIT;