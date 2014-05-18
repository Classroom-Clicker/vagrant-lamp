/* This file is divided in several parts. They are here described
 1) Cleaning of the database
 2) Creation of the table
 3) Creation of the primary keys
 4) Creation of the unique constaints
 5) Creation of the foreign keys
 6) Populate the database for initial testing

Except for the first and the last part, in each part the creation of elements is made in alphabetic order
*/

/* PART 1 : Cleaning */
/* Clean old version of the tables */
DROP TABLE IF EXISTS UsersRoles;
DROP TABLE IF EXISTS RolesPermissions;
DROP TABLE IF EXISTS SpecialsPermissions;
DROP TABLE IF EXISTS Permissions;
DROP TABLE IF EXISTS UserAnswers;
DROP TABLE IF EXISTS Answers;
DROP TABLE IF EXISTS UserQuestions;
DROP TABLE IF EXISTS Questions;
DROP TABLE IF EXISTS QuizSessions;
DROP TABLE IF EXISTS Quizzes;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Secrets;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Roles;


/* PART 2 : Creation of the tables */
CREATE TABLE IF NOT EXISTS Answers(
id integer NOT NULL,
question_id integer NOT NULL,
number integer NOT NULL,
value varchar(255) NOT NULL,
correct boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS Courses(
id integer NOT NULL,
name varchar(255) NOT NULL,
user_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS Permissions(
id integer NOT NULL,
name varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Questions(
id integer NOT NULL,
number integer NOT NULL,
quiz_id integer NOT NULL,
type integer NOT NULL,
question varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS QuizSessions(
id integer NOT NULL,
quiz_id integer NOT NULL,
unique_id varchar(10) NOT NULL,
user_id integer NOT NULL,
date_begin date NOT NULL,
status integer NOT NULL,
question integer NOT NULL
);

CREATE TABLE IF NOT EXISTS Quizzes(
id integer NOT NULL,
name varchar(255) NOT NULL,
course_id integer NOT NULL,
parentquiz integer,
user_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS Roles(
id integer NOT NULL,
name varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS RolesPermissions(
role_id integer NOT NULL,
permission_id integer NOT NULL
);

CREATE TABLE IF NOT EXISTS Secrets(
apikey varchar(64) NOT NULL,
user_id integer NOT NULL,
secret varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS SpecialsPermissions(
user_id integer NOT NULL,
permission_id integer NOT NULL,
object_id integer NOT NULL
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
id integer NOT NULL,
username varchar(255) NOT NULL,
email varchar(255),
firstname varchar(255),
lastname varchar(255)
);

CREATE TABLE IF NOT EXISTS UsersRoles(
user_id integer NOT NULL,
role_id integer NOT NULL
);

/* PART 3 : Creation of the PRIMARY KEYS and AUTO_INCREMENT */
ALTER TABLE Answers ADD CONSTRAINT pk_Answers_id PRIMARY KEY (id);
ALTER TABLE Answers MODIFY id integer AUTO_INCREMENT;
ALTER TABLE Courses ADD CONSTRAINT pk_Courses_id PRIMARY KEY (id);
ALTER TABLE Courses MODIFY id integer AUTO_INCREMENT;
ALTER TABLE Questions ADD CONSTRAINT pk_Questions_id PRIMARY KEY (id);
ALTER TABLE Questions MODIFY id integer AUTO_INCREMENT;
ALTER TABLE QuizSessions ADD CONSTRAINT pk_QuizSessions_id PRIMARY KEY (id);
ALTER TABLE QuizSessions MODIFY id integer AUTO_INCREMENT;
ALTER TABLE Quizzes ADD CONSTRAINT pk_Quizzes_id PRIMARY KEY (id);
ALTER TABLE Quizzes MODIFY id integer AUTO_INCREMENT;
ALTER TABLE Permissions ADD CONSTRAINT pk_Permissions_id PRIMARY KEY (id);
ALTER TABLE Permissions MODIFY id integer AUTO_INCREMENT;
ALTER TABLE Roles ADD CONSTRAINT pk_Roles_id PRIMARY KEY (id);
ALTER TABLE Roles MODIFY id integer AUTO_INCREMENT;
ALTER TABLE RolesPermissions ADD CONSTRAINT pk_RolesPermissions_id PRIMARY KEY (role_id,permission_id);
ALTER TABLE Secrets ADD CONSTRAINT pk_Secrets_id PRIMARY KEY (apikey);
ALTER TABLE SpecialsPermissions ADD CONSTRAINT pk_SpecialsPermissions_id PRIMARY KEY (user_id,permission_id,object_id);
ALTER TABLE UserAnswers ADD CONSTRAINT pk_UserAnswers_id PRIMARY KEY (id);
ALTER TABLE UserAnswers MODIFY id integer AUTO_INCREMENT;
ALTER TABLE UserQuestions ADD CONSTRAINT pk_UserQuestions_id PRIMARY KEY (id);
ALTER TABLE UserQuestions MODIFY id integer AUTO_INCREMENT;
ALTER TABLE Users ADD CONSTRAINT pk_Users_id PRIMARY KEY (id);
ALTER TABLE Users MODIFY id integer AUTO_INCREMENT;
ALTER TABLE UsersRoles ADD CONSTRAINT pk_UsersRoles_id PRIMARY KEY (user_id,role_id);

/* PART 3 : Creation of the UNIQUE constaints */
ALTER TABLE Answers ADD CONSTRAINT uk_Answers_number UNIQUE (question_id, number);
ALTER TABLE Questions ADD CONSTRAINT uk_Questions_number UNIQUE (quiz_id, number);
ALTER TABLE Secrets ADD CONSTRAINT uk_Secrets_number UNIQUE (user_id);
ALTER TABLE Users ADD CONSTRAINT uk_Users_username UNIQUE (username);

/* PART 4 : Creation of the FOREIGN KEYS */
ALTER TABLE Answers ADD CONSTRAINT fk_Answers_question FOREIGN KEY (question_id) REFERENCES Questions(id);
ALTER TABLE Courses ADD CONSTRAINT fk_Courses_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE Questions ADD CONSTRAINT fk_Questions_quiz FOREIGN KEY (quiz_id) REFERENCES Quizzes(id);
ALTER TABLE QuizSessions ADD CONSTRAINT fk_QuizSessions_quiz FOREIGN KEY (quiz_id) REFERENCES Quizzes(id);
ALTER TABLE QuizSessions ADD CONSTRAINT fk_QuizSessions_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE Quizzes ADD CONSTRAINT fk_Quizzes_course FOREIGN KEY (course_id) REFERENCES Courses(id);
ALTER TABLE Quizzes ADD CONSTRAINT fk_Quizzes_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE RolesPermissions ADD CONSTRAINT fk_RolesPermissions_role FOREIGN KEY (role_id) REFERENCES Roles(id) ON DELETE CASCADE;
ALTER TABLE RolesPermissions ADD CONSTRAINT fk_RolesPermissions_permission FOREIGN KEY (permission_id) REFERENCES Permissions(id) ON DELETE CASCADE;
ALTER TABLE Secrets ADD CONSTRAINT fk_Secrets_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE SpecialsPermissions ADD CONSTRAINT fk_SpecialsPermissions_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE SpecialsPermissions ADD CONSTRAINT fk_SpecialsPermissions_role FOREIGN KEY (permission_id) REFERENCES Permissions(id);
ALTER TABLE UserAnswers ADD CONSTRAINT fk_UserAnswers_answer FOREIGN KEY (answer_id) REFERENCES Answers(id);
ALTER TABLE UserAnswers ADD CONSTRAINT fk_UserAnswers_userquestion FOREIGN KEY (userquestion_id) REFERENCES UserQuestions(id);
ALTER TABLE UserQuestions ADD CONSTRAINT fk_UserQuestions_question FOREIGN KEY (question_id) REFERENCES Questions(id);
ALTER TABLE UserQuestions ADD CONSTRAINT fk_UserQuestions_quizsession FOREIGN KEY (quizsession_id) REFERENCES QuizSessions(id);
ALTER TABLE UserQuestions ADD CONSTRAINT fk_UserQuestions_user FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE UsersRoles ADD CONSTRAINT fk_UsersRoles_user FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE;
ALTER TABLE UsersRoles ADD CONSTRAINT fk_UsersRoles_role FOREIGN KEY (role_id) REFERENCES Roles(id);

/* Part 5 : populate databases for tests */
INSERT INTO Users (id, username, email, firstname, lastname ) VALUES
(1, 'gattazr', 'gattazr@students.wwu.edu', 'Remi', 'GATTAZ'),
(2, 'shiplem3', 'shiplem3@students.wwu.edu', 'Mark', 'SHIPLEEY'),
(3, 'klionsk', 'klionsk@students.wwu.edu', 'Katie', 'KLIONS'),
(4, 'thomas92', 'thomas92@students.wwu.edu', 'Cody', 'THOMAS');
INSERT INTO Roles (id, name) VALUES
(1, 'admninistrator'),
(2, 'professor'),
(3, 'student');
INSERT INTO Permissions (id,name) VALUES
(1, 'edit_users'),
(2, 'edit_roles'),
(3, 'delete_roles'),
(4, 'edit_others_courses'),
(5, 'delete_others_courses'),
(6, 'edit_others_quizzes'),
(7, 'delete_others_quizzes'),
(8, 'edit_courses'),
(9, 'edit_quizzes');
INSERT INTO UsersRoles (user_id, role_id) VALUES
(1,3),
(2,3),
(3,3),
(4,3);
INSERT INTO RolesPermissions (role_id, permission_id) VALUES 
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(2,8),
(2,9);
INSERT INTO Secrets (apikey, user_id, secret ) VALUES
('nufNixPhWpPxanqeLVJZvJaYKrdmXxuH', 1, 'dpUgrjuxtiQCiVqlQZZAqrBFnglKnaSE'),
('kfKDdoZxpytjxOYOwEvZEuitsTMlBTsr', 2, 'wHVFQjqbbrfJjaaHJVwsbIsiTdymYiYP'),
('mjpKwflqsYNBOvEBhzspVGlGnRHcWoyl', 3, 'qngaZgniKCvbYebZXUnsbnHsdYSNdEbE'),
('iQUREatQuYsWVqqqrWbeRhYauhBexcyF', 4, 'aenWftyEqQURIAhjUbeEpvFykrWxYwPu');
INSERT INTO Courses(id, name, user_id) VALUES
(1, 'CS 442', 1),
(2, 'CS 352', 4);
INSERT INTO Quizzes(id, name, course_id, parentquiz, user_id) VALUES
(1, 'Quizz 1', 1, null, 2),
(2, 'First quizz', 2, null, 4);
INSERT INTO Questions (id, number, quiz_id, type, question) VALUES
(1, 1, 1, 1, 'What is Javac ?'),
(2, 2, 1, 1, 'Thread is the name of a class.'),
(3, 1, 2, 1, 'Why are function calls preferred to systems call ?'),
(4, 2, 2, 1, 'What does fork return to the child process ?');
INSERT INTO Answers (id, question_id, number, value, correct) VALUES
(1, 1, 1, 'The new name of java', false),
(2, 1, 2, 'The name of a java executable', false),
(3, 1, 3, 'The name of the java compiler', true),
(4, 1, 4, 'Nothing from this world', false),
(5, 2, 1, 'False', false),
(6, 2, 2, 'True', true),
(7, 2, 3, 'Obiwan Kenobi', false),
(8, 2, 4, 'The answer D', false),
(9, 3, 1, 'System calls are more expensive', true),
(10, 3, 2, 'System calls are complicated to use', false),
(11, 3, 3, 'No particular reson', false),
(12, 3, 4, 'Because they can be modified more easily', false),
(13, 4, 1, 'The pid of the parent process', false),
(14, 4, 2, 'The pid of the child process', false),
(15, 4, 3, '0', true),
(16, 4, 4, '-1', false);
INSERT INTO QuizSessions (id, quiz_id, unique_id, user_id, date_begin, status, question) VALUES
(1, 1, 'QWERT12', 1, '2014-04-10', 0, 2),
(2, 2, 'AZERT34', 4, '2007-04-11', 1, 1);
INSERT INTO UserQuestions (id, quizsession_id, user_id, question_id) VALUES
(1, 1, 2, 1),
(2, 1, 2, 2),
(3, 2, 3, 1);
INSERT INTO UserAnswers (id, userquestion_id, answer_id) VALUES
(1, 1, 3),
(2, 2, 7),
(3, 3, 1);
