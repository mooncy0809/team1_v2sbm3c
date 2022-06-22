/**********************************/
/* Table Name: 관심분야 */
/**********************************/
DROP TABLE favorite CASCADE CONSTRAINTS;
CREATE TABLE favorite(
        FAVORITENO                         NUMBER(10)         NOT NULL         PRIMARY KEY,
        RDATE                                 DATE         NOT NULL,
        CATENO                               NUMBER(10)         NULL ,
        MEMBERNO                          NUMBER(10)         NULL ,
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO),
  FOREIGN KEY (CATENO) REFERENCES CATE (CATENO)
);

COMMENT ON TABLE favorite is '관심분야';
COMMENT ON COLUMN favorite.FAVORITENO is '관심분야번호';
COMMENT ON COLUMN favorite.RDATE is '등록일';
COMMENT ON COLUMN favorite.CATENO is '카테고리그룹 번호';
COMMENT ON COLUMN favorite.MEMBERNO is '회원 번호';

CREATE SEQUENCE favorite_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE; 
  
