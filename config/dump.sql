/* This file is divided in several parts. They are here described
 1) Cleaning of the database 
 2) Creation of the table 
 3) Creation of the primary keys 
 4) Creation of the unique constaints 
 5) Creation of the foreign keys 

Except for the first part, in every part, the creation of elements is made in alphabetic order 
*/

/* PART 1 : Cleaning */
DROP TABLE IF EXISTS PermissionQuizzes;
DROP TABLE IF EXISTS PermissionCourses;
DROP TABLE IF EXISTS UserAnswers;
DROP TABLE IF EXISTS Answers;
DROP TABLE IF EXISTS UserQuestions;
DROP TABLE IF EXISTS Questions;
DROP TABLE IF EXISTS QuizSessions;
DROP TABLE IF EXISTS Quizzes;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Users;


/* PART 2 : Creation of the tables */
CREATE TABLE IF NOT EXISTS Answers(
id integer,
question_id integer NOT NULL,
number integer NOT NULL,
value varchar(255) NOT NULL,
correct boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS Courses(
id integer,
name varchar(255) NOT NULL,
user_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS PermissionCourses(
course_id integer NOT NULL,
user_id integer NOT NULL,
permission integer NOT NULL
);

CREATE TABLE IF NOT EXISTS PermissionQuizzes(
quiz_id integer NOT NULL,
user_id integer NOT NULL,
permission integer NOT NULL
);

CREATE TABLE IF NOT EXISTS Questions(
id integer,
number integer NOT NULL,
quiz_id integer NOT NULL,
type integer NOT NULL,
question varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS QuizSessions(
id integer,
quiz_id integer NOT NULL,
user_id integer NOT NULL,
date_begin date NOT NULL,
status integer NOT NULL
);

CREATE TABLE IF NOT EXISTS Quizzes(
id integer,
name varchar(255) NOT NULL,
course_id integer NOT NULL,
parentquiz integer,
user_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS UserAnswers(
id integer NOT NULL,
userquestion_id integer NOT NULL,
answer_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS UserQuestions(
id integer NOT NULL,
quizsession_id integer NOT NULL,
user_id integer NOT NULL,
question_id integer
);

CREATE TABlE IF NOT EXISTS Users(
id integer,
email varchar(255) NOT NULL,
firstname varchar(255),
lastname varchar(255)
);


/* PART 3 : Creation of the PRIMARY KEYS */
ALTER TABLE Answers ADD CONSTRAINT pk_Answers_id PRIMARY KEY (id);
ALTER TABLE Courses ADD CONSTRAINT pk_Courses_id PRIMARY KEY (id);
ALTER TABLE PermissionCourses ADD CONSTRAINT pk_PermissionCourses_id PRIMARY KEY (course_id, user_id, permission);
ALTER TABLE PermissionQuizzes ADD CONSTRAINT pk_PermissionQuiz_id PRIMARY KEY (quiz_id, user_id, permission);
ALTER TABLE Questions ADD CONSTRAINT pk_Questions_id PRIMARY KEY (id);
ALTER TABLE QuizSessions ADD CONSTRAINT pk_QuizSessions_id PRIMARY KEY (id);
ALTER TABLE Quizzes ADD CONSTRAINT pk_Quizzes_id PRIMARY KEY (id);
ALTER TABLE UserAnswers ADD CONSTRAINT pk_UserAnswers_id PRIMARY KEY (id);
ALTER TABLE UserQuestions ADD CONSTRAINT pk_UserQuestions_id PRIMARY KEY (id);
ALTER TABLE Users ADD CONSTRAINT pk_Users_id PRIMARY KEY (id);


/* PART 3 : Creation of the UNIQUE constaints */
ALTER TABLE Answers ADD CONSTRAINT uk_Answers_number UNIQUE (id, number);
ALTER TABLE Questions ADD CONSTRAINT uk_Questions_number UNIQUE (id, number);
ALTER TABLE Users ADD CONSTRAINT uk_Users_email UNIQUE (email);

/* PART 4 : Creation of the FOREIGN KEYS */
ALTER TABLE Answers ADD CONSTRAINT fk_Answers_question FOREIGN KEY (question_id) REFERENCES Questions(id);
ALTER TABLE Courses ADD CONSTRAINT fk_Courses_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE PermissionCourses ADD CONSTRAINT fk_PermissionCourses_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE PermissionCourses ADD CONSTRAINT fk_PermissionCourses_course FOREIGN KEY (course_id) REFERENCES Courses(id);
ALTER TABLE PermissionQuizzes ADD CONSTRAINT fk_PermissionQuizzes_quiz FOREIGN KEY (quiz_id) REFERENCES Quizzes(id);
ALTER TABLE PermissionQuizzes ADD CONSTRAINT fk_PermissionQuizzes_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE Questions ADD CONSTRAINT fk_Questions_quiz FOREIGN KEY (quiz_id) REFERENCES Quizzes(id);
ALTER TABLE QuizSessions ADD CONSTRAINT fk_QuizSessions_quiz FOREIGN KEY (quiz_id) REFERENCES Quizzes(id);
ALTER TABLE QuizSessions ADD CONSTRAINT fk_QuizSessions_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE Quizzes ADD CONSTRAINT fk_Quizzes_course FOREIGN KEY (course_id) REFERENCES Courses(id);
ALTER TABLE Quizzes ADD CONSTRAINT fk_Quizzes_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE UserAnswers ADD CONSTRAINT fk_UserAnswers_answer FOREIGN KEY (answer_id) REFERENCES Answers(id);
ALTER TABLE UserAnswers ADD CONSTRAINT fk_UserAnswers_userquestion FOREIGN KEY (userquestion_id) REFERENCES UserQuestions(id);
ALTER TABLE UserQuestions ADD CONSTRAINT fk_UserQuestions_question FOREIGN KEY (question_id) REFERENCES Questions(id);
ALTER TABLE UserQuestions ADD CONSTRAINT fk_UserQuestions_quizsession FOREIGN KEY (quizsession_id) REFERENCES QuizSessions(id);
ALTER TABLE UserQuestions ADD CONSTRAINT fk_UserQuestions_user FOREIGN KEY (user_id) REFERENCES Users(id);
