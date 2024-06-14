
CREATE TABLE professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL
);


CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES professors(professor_id)
);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    enrollment_date DATE
);


CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO professors (first_name, last_name, department) VALUES
('John', 'Doe', 'Computer Science'),
('Jane', 'Smith', 'Mathematics'),
('Albert', 'Einstein', 'Physics');

INSERT INTO students (first_name, last_name, enrollment_date) VALUES
('Alice', 'Johnson', '2023-09-01'),
('Bob', 'Smith', '2023-09-01'),
('Carol', 'Taylor', '2023-09-01');

INSERT INTO courses (course_name, professor_id) VALUES
('Algorithms', 1),
('Calculus', 2),
('Quantum Mechanics', 3);

INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'B'),
(2, 3, 'A'),
(3, 1, 'C'),
(3, 2, 'B'),
(3, 3, 'A');

-- Find the Total Number of Students Enrolled in Each Course
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- List the Courses Taught by Professors in the 'Computer Science' Department
SELECT c.course_id, c.course_name
FROM courses c
JOIN professors p ON c.professor_id = p.professor_id
WHERE p.department = 'Computer Science';

-- Calculate the Average Grade for Each Course
SELECT c.course_id, c.course_name, AVG(CASE 
    WHEN e.grade = 'A' THEN 4.0
    WHEN e.grade = 'B' THEN 3.0
    WHEN e.grade = 'C' THEN 2.0
    WHEN e.grade = 'D' THEN 1.0
    WHEN e.grade = 'F' THEN 0.0
    ELSE NULL
END) AS average_grade
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- Find Students Who Are Enrolled in More Than Three Courses
SELECT s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING total_courses > 3;


