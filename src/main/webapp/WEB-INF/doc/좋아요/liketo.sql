
drop table liketo CASCADE CONSTRAINTS;
CREATE TABLE liketo(
    likeno                      NUMBER(5)    NOT NULL PRIMARY KEY, 
    contentsno                         NUMBER(7)    NOT NULL REFERENCES contents(contentsno) ON DELETE CASCADE  ,    
    memberno                             NUMBER(6)    NOT NULL  REFERENCES member(memberno) ON DELETE CASCADE ,
    like_check                        NUMBER(5)   DEFAULT 0 NULL,
    FOREIGN KEY (memberno) REFERENCES member (memberno),
    FOREIGN KEY (contentsno) REFERENCES contents (contentsno)
);

DROP SEQUENCE likteto_seq;
CREATE SEQUENCE liketo_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
INSERT INTO liketo(likeno, contentsno, memberno, like_check)
VALUES (liketo_seq.nextval, 32 , 3, 0);

commit;

UPDATE liketo
SET like_check = like_check - 1
WHERE memberno=3 AND contentsno=32;

select likeno, contentsno, memberno, like_check
from liketo
where memberno=3 AND contentsno=32;

SELECT l.like_check,  l.MEMBERNO as l_memberno, c.contentsno, c.memberno, c.cateno, c.title, c.content, c.recom, c.cnt, c.replycnt, c.rdate,
                               c.file1, c.file1saved, c.thumb1, c.mname, c.size1
FROM liketo l, contents c
WHERE l.contentsno = c.contentsno AND l.MEMBERNO=3 AND c.contentsno=32;