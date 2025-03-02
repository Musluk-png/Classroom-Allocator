CREATE DATABASE classroom_allocation;
USE classroom_allocation;
CREATE TABLE department (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    hod_name VARCHAR(100),
    contact_email VARCHAR(255) UNIQUE
);
CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    department INT,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(15),
    designation VARCHAR(100),
    is_active BOOLEAN DEFAULT 1,
    FOREIGN KEY (department) REFERENCES department(dept_id) ON DELETE SET NULL
);
CREATE TABLE course (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(50) UNIQUE NOT NULL,
    course_name VARCHAR(150) NOT NULL,
    description TEXT,
    credits INT,
    semester INT NOT NULL,
    department INT,
    FOREIGN KEY (department) REFERENCES department(dept_id) ON DELETE CASCADE
);
CREATE TABLE student_group (
    group_id INT PRIMARY KEY AUTO_INCREMENT,
    batch_year INT NOT NULL,
    department INT,
    semester INT NOT NULL,
    section VARCHAR(10),
    student_count INT,
    FOREIGN KEY (department) REFERENCES department(dept_id) ON DELETE CASCADE
);
CREATE TABLE building (
    building_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255),
    total_floors INT,
    is_active BOOLEAN DEFAULT 1
);
CREATE TABLE classroom (
    classroom_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(50) UNIQUE NOT NULL,
    room_type VARCHAR(50),
    capacity INT NOT NULL,
    is_available BOOLEAN DEFAULT 1,
    floor INT NOT NULL,
    building_id INT,
    FOREIGN KEY (building_id) REFERENCES building(building_id) ON DELETE CASCADE
);
CREATE TABLE classroom_facilities (
    facility_id INT PRIMARY KEY AUTO_INCREMENT,
    facility_name VARCHAR(255) NOT NULL,
    description TEXT
);
CREATE TABLE time_slot (
    slot_id INT PRIMARY KEY AUTO_INCREMENT,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL
);
CREATE TABLE allocation (
    allocation_id INT PRIMARY KEY AUTO_INCREMENT,
    classroom_id INT,
    slot_id INT,
    group_id INT,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Scheduled', 'Cancelled', 'Completed') DEFAULT 'Scheduled',
    FOREIGN KEY (classroom_id) REFERENCES classroom(classroom_id) ON DELETE CASCADE,
    FOREIGN KEY (slot_id) REFERENCES time_slot(slot_id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES student_group(group_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES faculty(faculty_id) ON DELETE SET NULL
);
CREATE TABLE allocation (
    allocation_id INT PRIMARY KEY AUTO_INCREMENT,
    classroom_id INT,
    slot_id INT,
    group_id INT,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Scheduled', 'Cancelled', 'Completed') DEFAULT 'Scheduled',
    FOREIGN KEY (classroom_id) REFERENCES classroom(classroom_id) ON DELETE CASCADE,
    FOREIGN KEY (slot_id) REFERENCES time_slot(slot_id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES student_group(group_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES faculty(faculty_id) ON DELETE SET NULL
);
CREATE TABLE allocation_request (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_id INT,
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    remarks TEXT,
    priority_level ENUM('Low', 'Medium', 'High') DEFAULT 'Medium',
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id) ON DELETE CASCADE
);
INSERT INTO department (name, hod_name, contact_email) VALUES
('Computer Science', 'Ms. Renju K', 'renju.k@mccblr.edu.in'),
('Mathematics', 'Dr. B. Vijayalakshmi', 'math_hod@mccblr.edu.in'),
('Physics', 'Dr. K. S. Shamala', 'K.S.SHAMALA@mccblr.edu.in');
select*from department;

INSERT INTO faculty (name, department, email, phone, designation, is_active) VALUES
('Dr. P. Peter Jose', 3, 'peter.j@mccblr.edu.in', '8220908288', 'Assistant Professor', 1),
('Ms. Shirley Sheeba S', 3, 'shirley.s@mccblr.edu.in', '7411508345', 'Lecturer', 1),
('Dr. R. Denis', 3, 'denisr@mccblr.edu.in', '9787369928', 'Assistant Professor', 1);
select*from faculty;

INSERT INTO course (course_code, course_name, description, credits, semester, department) VALUES
('IBCADSC2-PSTC', 'Problem Solving Techniques Using C', 'Analytical and Logical Programming Skills.', 3, 1, 3),
('IBCADSC3-DMS', 'Database Management Systems', 'Fundamentals of Database Concepts', 3, 1, 3),
('IBCADSC2-PSTCL', 'C Programming Lab', 'Practicals', 2, 1, 3);
select*from course;

INSERT INTO student_group (batch_year, department, semester, section, student_count) VALUES
(2024, 3, 2, 'A', 50),
(2024, 3, 2, 'B', 55),
(2023, 3, 4, 'A', 60);
select*from student_group;

INSERT INTO building (name, location, total_floors, is_active) VALUES
('Golden Jubilee Block(GJB)', 'Nil', 3, 1),
('MCA Block', 'Nil', 3, 1),
('LSCB Block', 'Nil', 3, 1);
select*from building;

INSERT INTO classroom (room_number, room_type, capacity, is_available, floor, building_id) VALUES
('GJB 101', 'Lecture Hall', 60, 1, 1, 1),
('GJB 102', 'Lecture Hall', 60, 1, 1, 1),
('GJB 103', 'Lecture Hall', 60, 1, 1, 1);
select*from classroom;

INSERT INTO classroom_facilities (facility_name, description) VALUES
('Projector', 'Ceiling-mounted projector with HDMI support'),
('Blackboard', 'Large blackboard for teaching'),
('WiFi', 'High-speed internet access in classroom');
select*from classroom_facilities;

INSERT INTO time_slot (start_time, end_time, day_of_week) VALUES
('08:50:00', '09:40:00', 'Monday'),
('10:00:00', '10:50:00', 'Tuesday'),
('10:50:00', '11:40:00', 'Wednesday');
select*from time_slot;

INSERT INTO allocation (classroom_id, slot_id, group_id, created_by, status) VALUES
(3, 3, 3, 3, 'Scheduled'),
(3, 3, 3, 3, 'Scheduled'),
(3, 3, 3, 3, 'Scheduled');
select*from allocation;

INSERT INTO allocation_request (faculty_id, status, remarks, priority_level) VALUES
(1, 'Pending', 'Need extra classroom for seminar', 'High'),
(2, 'Approved', 'Extra class for revision', 'Medium'),
(3, 'Rejected', 'Classroom already booked', 'Low');
select*from allocation_request;



