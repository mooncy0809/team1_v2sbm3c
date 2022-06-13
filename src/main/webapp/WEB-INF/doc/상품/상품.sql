/**********************************/
/* Table Name: 상품 */
/**********************************/
DROP TABLE products;
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

DROP SEQUENCE products_seq;
CREATE SEQUENCE products_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지




--삽입
INSERT INTO products(productno, cateno, ptitle, pcontent, precom, pcnt, preplycnt, ppasswd, pword, rdate, price, dc, saleprice, point, salecnt)
VALUES(products_seq.nextval, 1, '아임웰 훈제 닭가슴살', '아주 맛있는 훈제 닭가슴살', 0, 0, 0, '123', '닭가슴살', sysdate,2000, 10, 1800, 100, 500);

INSERT INTO products(productno, cateno, ptitle, pcontent, precom, pcnt, preplycnt, ppasswd, pword, rdate, price, dc, saleprice, point, salecnt)
VALUES(products_seq.nextval, 21, '불닭맛 닭가슴살', '아주 맛있는 닭가슴살', 0, 0, 0, '123', '닭가슴살', sysdate,2000, 10, 1800, 100, 500);

SELECT * FROM products;

commit;

PRODUCTNO     CATENO PTITLE                                                                                                                                                                                                                                                                                                       PCONTENT                                                                             PRECOM       PCNT  PREPLYCNT PPASSWD         PWORD                                                                                                                                                                                                                                                                                                        RDATE               PFILE1                                                                                               PFILE1SAVED
---------- ---------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ -------------------------------------------------------------------------------- ---------- ---------- ---------- --------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ ------------------- ---------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------
PTHUMB1                                                                                                  PSIZE1      PRICE         DC  SALEPRICE      POINT    SALECNT
---------------------------------------------------------------------------------------------------- ---------- ---------- ---------- ---------- ---------- ----------
         1          1 아임웰 훈제 닭가슴살                                                                                                                                                                                                                                                                                         아주 맛있는 훈제 닭가슴살                                                                 0          0          0 123             닭가슴살                                                                                                                                                                                                                                                                                                     2022-06-03 05:35:32                                                                                                                                                                                                           
                                                                                                              0       2000         10       1800        100        500