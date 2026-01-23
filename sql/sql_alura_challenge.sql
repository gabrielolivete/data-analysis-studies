-- ============================================
-- Project: SQLite Data Analysis Challenge
-- Source: Alura Platform
-- Description:
-- Database structure for an academic management system
-- including students, teachers, subjects, classes and enrollments.
-- ============================================

-- ============================================
-- STUDENTS TABLE
-- ============================================
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR (100),
  student_birth_date DATE,
  student_gender VARCHAR (50),
  student_adress VARCHAR (150),
  student_contact VARCHAR (20),
  student_email VARCHAR (50)
  );
  
-- ============================================
-- TEACHERS TABLE
-- ============================================
CREATE TABLE teachers (
  teacher_id INT PRIMARY KEY,
  teacher_name VARCHAR (100),
  teacher_birth_date DATE,
  teacher_gender VARCHAR (50),
  teacher_contact VARCHAR (20),
  teacher_email VARCHAR (50)
  );  
    
    
-- ============================================
-- SUBJECTS TABLE
-- ============================================
CREATE TABLE subjects (
  subject_id INT PRIMARY KEY,
  subject_name VARCHAR (50),
  subject_description TEXT,
  subject_workload INT,
  teacher_id INT,
  FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id)
  );
  
-- ============================================
-- CLASSES TABLE
-- ============================================
CREATE TABLE classes (
  class_id INT PRIMARY KEY,
  class_name VARCHAR (100),
  academic_year INT,
  advisor_teacher_id INT,
  FOREIGN KEY (advisor_teacher_id) REFERENCES teachers (teacher_id)
  );
  
-- ============================================
-- CLASS-SUBJECT RELATION TABLE
-- ============================================
CREATE TABLE class_subjects (
  class_id INT,
  subject_id INT,
  PRIMARY KEY (class_id, subject_id),
  FOREIGN KEY (class_id) REFERENCES classes (class_id),
  FOREIGN KEY (subject_id) REFERENCES subjects (subject_id)
  );
  
-- ============================================
-- CLASS-STUDENTS RELATION TABLE
-- ============================================
CREATE TABLE class_students (
  class_id INT,
  student_id INT,
  PRIMARY key (class_id, student_id),
  FOREIGN key (class_id) REFERENCES classes (class_id),
  FOREIGN key (student_id) REFERENCES students (student_id)
  );
  
-- ============================================
-- GRADES TABLE
-- ============================================
CREATE TABLE grades (
  grade_id INT PRIMARY KEY,
  student_id INT,
  subject_id INT,
  grade_value DECIMAL (5, 2),
  evaluation_date DATE,
  FOREIGN KEY (student_id) REFERENCES stuednts (student_id),
  FOREIGN KEY (subject_id) REFERENCES subjects (subject_id)
  );
  
-- ============================================
-- SAMPLE DATA INSERTION
-- ============================================
-- This section contains sample data used for
-- testing and practicing SQL queries.

INSERT INTO 'students' ('student_id','student_name','student_birth_date','student_gender','student_adress','student_contact','student_email') VALUES 
 ('1','João Silva','2005-03-15','Male','Flowers Street, 123','(11) 9876-5432','joao@email.com'), 
 ('2','Maria Santos','2006-06-20','Female','Main Avenue, 456','(11) 8765-4321','maria@email.com'), 
 ('3','Pedro Soares','2004-01-10','Male','Central Street, 789','(11) 7654-3210','pedro@email.com'), 
 ('4','Ana Lima','2005-04-02','Female','School Street, 56','(11) 8765-4321','ana@email.com'), 
 ('5','Mariana Fernandes','2005-08-12','Female','Peace Avenue, 789','(11) 5678-1234','mariana@email.com'), 
 ('6','Lucas Costa','2003-11-25','Male','Main Street, 456','(11) 1234-5678','lucas@email.com'), 
 ('7','Isabela Santos','2006-09-10','Female','Friendship Street, 789','(11) 9876-5432','isabela@email.com'), 
 ('8','Gustavo Pereira','2004-05-15','Male','Dreams Avenue, 123','(11) 7654-3210','gustavo@email.com'), 
 ('9','Carolina Oliveira','2005-02-20','Female','Joyce Street, 456','(11) 8765-4321','carolina@email.com'), 
 ('10','Daniel Silva','2003-10-05','Male','Central Avenue, 789','(11) 1234-5678','daniel@email.com'), 
 ('11','Larissa Souza','2004-12-08','Female','Joyce Street, 123','(11) 9876-5432','larissa@email.com'), 
 ('12','Bruno Costa','2005-07-30','Male','Main Avenue, 456','(11) 7654-3210','bruno@email.com'), 
 ('13','Camila Rodrigues','2006-03-22','Female','Stars Street, 789','(11) 8765-4321','camila@email.com'), 
 ('14','Rafael Fernandes','2004-11-18','Male','Dreams Avenue, 123','(11) 1234-5678','rafael@email.com'), 
 ('15','Letícia Oliveira','2005-01-05','Female','Joyce Street, 456','(11) 9876-5432','leticia@email.com'), 
 ('16','Fernanda Lima','2004-02-12','Female','Hope Street, 789','(11) 4567-8901','fernanda@email.com'), 
 ('17','Vinícius Santos','2003-07-28','Male','Friendship Street, 123','(11) 8901-2345','vinicius@email.com'), 
 ('18','Juliana Pereira','2006-09-01','Female','Roses Avenue, 789','(11) 3456-7890','juliana@email.com');
SELECT * FROM students;

INSERT INTO 'teachers' ('teacher_id','teacher_name','teacher_birth_date','teacher_gender','teacher_contact','teacher_email') VALUES 
 ('1','Ana Oliveira','1980-05-25','Female','(11) 1234-5678','ana@email.com'), 
 ('2','Carlos Ferreira','1975-09-12','Male','(11) 2345-6789','carlos@email.com'), 
 ('3','Mariana Santos','1982-03-15','Female','(11) 3456-7890','mariana@email.com'), 
 ('4','Ricardo Silva','1978-08-20','Male','(11) 7890-1234','ricardo@email.com'), 
 ('5','Fernanda Lima','1985-01-30','Female','(11) 4567-8901','fernanda@email.com');
SELECT * FROM teachers;

INSERT INTO 'subjects' ('subject_id','subject_name','subject_description','subject_workload','teacher_id') VALUES 
 ('1','Mathematics','Advanced mathematical concepts','60','1'), 
 ('2','History','World and local history','45','2'), 
 ('3','Physics','Fundamentals principles od physics','60','1'), 
 ('4','Chemistry','Chemistry and its applications','45','3'), 
 ('5','English','English for beginners','45','4'), 
 ('6','Arts','Exploration of artistic creativity','30','5');
SELECT * FROM subjects;

INSERT INTO 'classes' ('class_id','class_name','academic_year','advisor_teacher_id') VALUES 
 ('1','Class A','2023','1'), 
 ('2','Class B','2023','2'), 
 ('3','Class C','2023','3'), 
 ('4','Class D','2023','4'), 
 ('5','Class E','2023','5');
SELECT * FROM classes;

INSERT INTO 'class_subjects' ('class_id','subject_id') VALUES 
 ('1','1'), 
 ('2','2'), 
 ('3','3'), 
 ('4','4'), 
 ('5','5'), 
 ('1','3'), 
 ('2','1'), 
 ('3','2');
 SELECT * FROM class_subjects;

INSERT INTO 'class_students' ('class_id','student_id') VALUES 
 ('1','1'), 
 ('2','2'), 
 ('3','3'), 
 ('4','4'), 
 ('5','5'), 
 ('1','6'), 
 ('2','7'), 
 ('3','8'), 
 ('4','9'), 
 ('5','10');
 SELECT * FROM class_students;

INSERT INTO 'grades' ('grade_id','student_id','subject_id','grade_value','evaluation_date') VALUES 
(2,1,1,6.19,'07/07/2023'),
(3,1,2,7.18,'07/07/2023'),
(4,1,3,7.47,'07/07/2023'),
(5,1,4,7.46,'07/07/2023'),
(6,1,5,4.35,'07/07/2023'),
(7,1,6,4.43,'07/07/2023'),
(8,2,1,0.76,'07/07/2023'),
(9,2,2,9.22,'07/07/2023'),
(10,2,3,9.04,'07/07/2023'),
(11,2,4,3.28,'07/07/2023'),
(12,2,5,1.34,'07/09/2023'),
(13,2,6,3.1,'07/09/2023'),
(14,3,1,1.66,'07/09/2023'),
(15,3,2,0.03,'07/09/2023'),
(16,3,3,4.34,'07/09/2023'),
(17,3,4,4.02,'07/09/2023'),
(18,3,5,8.79,'07/09/2023'),
(19,3,6,1.17,'07/09/2023'),
(20,4,1,8.26,'07/09/2023'),
(21,4,2,3.41,'07/09/2023'),
(22,4,3,6.82,'07/27/2023'),
(23,4,4,8.21,'07/27/2023'),
(24,4,5,1.3,'07/27/2023'),
(25,4,6,4.01,'07/27/2023'),
(26,5,1,0.25,'07/27/2023'),
(27,5,2,6.63,'07/27/2023'),
(28,5,3,9.74,'07/27/2023'),
(29,5,4,3.77,'07/27/2023'),
(30,5,5,0.58,'07/27/2023'),
(31,5,6,8.52,'07/27/2023'),
(32,6,1,8.37,'08/08/2023'),
(33,6,2,0.26,'08/08/2023'),
(34,6,3,5.95,'08/08/2023'),
(35,6,4,6.98,'08/08/2023'),
(36,6,5,6.18,'08/08/2023'),
(37,6,6,4.79,'08/08/2023'),
(38,7,1,7.96,'08/08/2023'),
(39,7,2,0.62,'08/08/2023'),
(40,7,3,7.77,'08/08/2023'),
(41,7,4,5.81,'08/08/2023'),
(42,7,5,2.25,'08/15/2023'),
(43,7,6,5.82,'08/15/2023'),
(44,8,1,4.11,'08/15/2023'),
(45,8,2,7.99,'08/15/2023'),
(46,8,3,3.23,'08/15/2023'),
(47,8,4,8.09,'08/15/2023'),
(48,8,5,8.24,'08/15/2023'),
(49,8,6,3.33,'08/15/2023');

-- ============================================
-- DATA ANALYSIS QUERIES
-- ============================================
-- This section contains SQL queries used to
-- explore and analyze the data.


-- --------------------------------------------
-- Query 1: Retrieve all grades recorded
-- --------------------------------------------
SELECT * FROM grades;

-- --------------------------------------------
-- Query 2: List students ordered alphabetically
-- --------------------------------------------
SELECT * FROM students ORDER BY student_name;

-- --------------------------------------------
-- Query 3: Identify subjects with workload above 40 hours
-- --------------------------------------------
SELECT * FROM subjects WHERE subject_workload > 40;

-- --------------------------------------------
-- Query 4: Retrieve grades between 6 and 8
-- --------------------------------------------
SELECT * FROM grades WHERE grade_value > 6 AND grade_value < 8;
