-- LOBs - 
-- CLOB - Large text
-- NCLOB - National characters
-- BLOB - image, audio, video, pdf, document
-- BFILE - File Handling

--Oracle Live SQL - Script: Convert clobs to varchar2
DROP TABLE FACEBOOK_COMMENTS;
CREATE TABLE FACEBOOK_COMMENTS(username VARCHAR2(25), comments CLOB);
INSERT INTO FACEBOOK_COMMENTS VALUES('Anbu', 'Facebook is a social media and social networking service owned by the American technology conglomerate Meta. Created in 2004 by Mark Zuckerberg with four other Harvard College students and roommates');
INSERT INTO FACEBOOK_COMMENTS VALUES('David', 'When you like a comment on a public post by a friend on Facebook, the visibility of that activity depends on the privacy settings of the post and the comment. Here’s how it generally works:
1. Public Posts: If the original post is public, anyone who can see the post can also see the likes on comments, including your like.
2. Friends of Friends: If the post is set to "Friends of Friends," then your friends and their friends can see your like.
3. Friends Only: If the post is set to "Friends Only," then only your friends will see your like.
4. Comment Visibility: The visibility of the comment itself also plays a role. If the comment is public, anyone can see your like; if it’s restricted to friends, then only friends can see it.');

DECLARE
    l_clob  CLOB; 
BEGIN 
    SELECT comments INTO l_clob FROM FACEBOOK_COMMENTS WHERE username = 'David';
    print_facebookcomments(l_clob);
END;


CREATE OR REPLACE PROCEDURE print_facebookcomments (p_clob IN CLOB)  
 IS  
   l_offset INT := 1;  
 BEGIN  
   DBMS_OUTPUT.PUT_LINE('Your Comments:');    
    LOOP  
        EXIT WHEN  l_offset > DBMS_LOB.GETLENGTH(p_clob);  
        DBMS_OUTPUT.PUT_LINE( DBMS_LOB.substr( p_clob, 255, l_offset ) );  
        l_offset := l_offset + 255;  
    END LOOP;  
END print_facebookcomments;
/


--SELECT comments FROM FACEBOOK_COMMENTS WHERE username = 'David';