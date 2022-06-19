/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
CREATE TABLE CATEGRP(
		CATEGRPNO                     		NUMBER(10)		 NOT NULL,
		NAME                          		VARCHAR2(50)		 NOT NULL,
		SEQNO                         		NUMBER(10)		 NOT NULL,
		VISIBLE                       		CHAR(1)		 NOT NULL,
		RDATE                         		DATE		 NOT NULL
);

COMMENT ON TABLE CATEGRP is '카테고리 그룹';
COMMENT ON COLUMN CATEGRP.CATEGRPNO is '카테고리 그룹 번호';
COMMENT ON COLUMN CATEGRP.NAME is '이름';
COMMENT ON COLUMN CATEGRP.SEQNO is '출력 순서';
COMMENT ON COLUMN CATEGRP.VISIBLE is '출력 모드';
COMMENT ON COLUMN CATEGRP.RDATE is '그룹 생성일';


/**********************************/
/* Table Name: CALDICT */
/**********************************/
CREATE TABLE CALDICT(
		NO                            		NUMBER(38)		 NULL ,
		FNAME                         		VARCHAR2(40)		 NULL ,
		BCLASS                        		VARCHAR2(40)		 NULL ,
		SCLASS                        		VARCHAR2(40)		 NULL ,
		FSIZE                         		NUMBER(38)		 NULL ,
		KCAL                          		NUMBER(38)		 NULL ,
		CARBO                         		NUMBER(38)		 NULL ,
		PROTEIN                       		NUMBER(38)		 NULL ,
		FAT                           		NUMBER(38)		 NULL ,
		SUGAR                         		NUMBER(38)		 NULL ,
		SODIUM                        		NUMBER(38)		 NULL ,
		CNT                           		NUMBER(5)		 NULL ,
		CATEGRPNO                     		NUMBER(10)		 NOT NULL
);

COMMENT ON TABLE CALDICT is 'CALDICT';
COMMENT ON COLUMN CALDICT.NO is 'NO';
COMMENT ON COLUMN CALDICT.FNAME is 'FNAME';
COMMENT ON COLUMN CALDICT.BCLASS is 'BCLASS';
COMMENT ON COLUMN CALDICT.SCLASS is 'SCLASS';
COMMENT ON COLUMN CALDICT.FSIZE is 'FSIZE';
COMMENT ON COLUMN CALDICT.KCAL is 'KCAL';
COMMENT ON COLUMN CALDICT.CARBO is 'CARBO';
COMMENT ON COLUMN CALDICT.PROTEIN is 'PROTEIN';
COMMENT ON COLUMN CALDICT.FAT is 'FAT';
COMMENT ON COLUMN CALDICT.SUGAR is 'SUGAR';
COMMENT ON COLUMN CALDICT.SODIUM is 'SODIUM';
COMMENT ON COLUMN CALDICT.CNT is 'CNT';
COMMENT ON COLUMN CALDICT.CATEGRPNO is 'CATEGRPNO';



ALTER TABLE CATEGRP ADD CONSTRAINT IDX_CATEGRP_PK PRIMARY KEY (CATEGRPNO);

ALTER TABLE CALDICT ADD CONSTRAINT IDX_CALDICT_FK0 FOREIGN KEY (CATEGRPNO) REFERENCES CATEGRP (CATEGRPNO);

