Q1) What books are required for each course (sort by course number)? 
SQL Query:
SELECT c.CourseNum, C.CourseTitle, b.ISBN, b.Title AS ‘Book Title’, b.Edition
FROM course c, book b
WHERE c.CourseNum = b.CourseNum
ORDER BY c.CourseNum;  

2) What are the ISBN and titles of all the unsold (available) books? 
SQL Query:
SELECT DISTINCT bc.ISBN, b.Title AS ‘Book Title’
FROM book b, book_copy bc
WHERE b.ISBN = bc.ISBN
AND bc.BookType = 'A';


3) Which students have picked up their books?  
SQL Query:
SELECT DISTINCT st.SID, st.Fname  AS 'Student First Name', st.Lname AS 'Student Last Name'
FROM Student st, retrieved_book rb
WHERE st.SID = rb.SRBID;



4) List the books in BPUB’s current inventory and how many of each book they have in stock. 
SQL Query:
SELECT bo.ISBN, bo.Title AS ‘Book Title’, Count(bc.ISBN) AS 'Copies’
FROM Book bo, Book_Copy bc
WHERE bo.ISBN = bc.ISBN
AND bc.BOOKTYPE = 'A'
GROUP BY ISBN, Title;





5) Which sellers received checks with check numbers between 150 and 156? 
SQL Query:
SELECT st.SID, st.Fname  AS 'Student First Name', st.LName AS 'Student Last Name'
FROM Student st, Payment pa
WHERE st.SID = pa.SSID
AND CheckNum BETWEEN 150 AND 156;





6) Which students have books in need of retrieval? 
SQL Query:
SELECT ub.ISBN,ub.SUID, st.Fname AS 'First Name', st.Lname AS 'Last Name'
FROM Unretrieved_Book ub, Student st, Book bo, book_copy bc, Seller se
WHERE ub.ISBN = bc.ISBN
AND ub.SUID=bc.SSID
AND bc.SSID = se.SSID
AND se.ssid = st.SID
AND (ub.DID=' ' or ub.DID IS NULL);







7) What is the least expensive copy of “C++ How to Program”? 
SQL Query: 
SELECT bo.Title, MIN(AskingPrice) AS ‘Price of Least Expensive Copy’
FROM Book_Copy bc, Book bo
WHERE bc.ISBN = bo.ISBN
AND bo.Title = ' C++ How to Program';
GROUP BY bo.Title;




8) List the average cost of the book copies for each book. 
SQL Query:
SELECT bc.ISBN, bo.Title, Round(AVG(AskingPrice),2) AS 'Average Asking Price'
FROM book_copy bc, book bo
WHERE bo.ISBN = bc.ISBN
GROUP BY bc.ISBN;




9) Which students have not sold any books? 
SQL Query:
SELECT DISTINCT SID, FName AS 'Student First Name', Lname AS 'Student Last Name'
FROM Student
WHERE SID NOT IN 
            (SELECT DISTINCT SSBID
              FROM Sold_Book sb);






10) Which students have purchased a copy of “Marketing Strategy ‐ A Primer” from us? 
SQL Query:
SELECT DISTINCT st.SID as 'Student ID', st.Fname AS 'Student Buyer First Name', st.Lname AS 'Student Buyer Last Name', st.Suffix AS ‘Student Buyer Suffix’, bo.title AS 'Book Title', bo.ISBN 
FROM student st,sale sa, sold_book sb, book bo
WHERE st.sid = sa.bsid
AND sa.SaleNum = sb.SaleNum
AND sb.ISBN = bo.ISBN
AND title = (' Marketing Strategy - A Primer');







11)List the books required for the “Industrial Relations” course, along with the number of available 
copies for each book
SQL Query:
SELECT x.Title AS ‘Book Title’,x.ISBN,COUNT(bc.ISBN) AS ‘No of Available Copies’
FROM book_copy bc RIGHT OUTER JOIN (SELECT title,isbn FROM book b JOIN Course c
                                                                           ON b.CourseNum=c.CourseNum
                                                                           WHERE courseTitle=’Industrial Relations’)x
ON x.ISBN=bc.ISBN
AND booktype=’A’ OR (booktype=’U’ AND bc.ISBN IN(SELECT DISTINCT ISBN FROM unretrived_book
                                                                                                 WHERE DID=’’ OR DID IS NULL))
GROUP BY bc.ISBN;




12) How many different students have tried to sell a copy of “Inside Outsourcing”? 
SQL Query:
SELECT COUNT(DISTINCT st.SID) AS 'Total no. of different students tried to sell Inside Outsourcing'
FROM student st, book_copy bc, book bo
WHERE st.SID = bc.SSID
AND bc.ISBN = bo.ISBN
AND bc.ISBN = (SELECT ISBN FROM Book WHERE title = ' Inside Outsourcing');






13) How much money have we made by selling books to distributors? 
SQL Query:
SELECT SUM(SellingPrice) AS 'Total sales made to distributor'
FROM unretrieved_book;





14) How many different book copies have been retrieved by sellers? 
SQL Query:
SELECT COUNT (ISBN) AS 'Total different book copies retrieved by sellers'
FROM retrieved_book;



15)List the first and last name of students who have both purchased a book from us and received  
payment from us for a sold book
SQL Query:
SELECT DISTINCT st.FName, st.Lname
FROM Student st, payment pa, sale sa
WHERE sa.BSID = SID
AND SID = pa.ssid;

