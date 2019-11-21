CREATE TABLE `Students` (
  `id` int PRIMARY KEY,
  `fname` string,
  `lname` string,
  `email` string,
  `phone` int,
  `advisor` int,
  `start_semester` ENUM ('fall', 'spring'),
  `expected_grad` date,
  `pin` int,
  `major` string,
  `finaid_package` string,
  `classes` int,
  `completed_courses` int,
  `alumni` boolean
);

CREATE TABLE `Instructors` (
  `id` int PRIMARY KEY,
  `fname` string,
  `lname` string,
  `email` string,
  `advisees` int,
  `classes` int,
  `building` id,
  `room` int
);

CREATE TABLE `Courses` (
  `id` int PRIMARY KEY,
  `title` string,
  `crn` int,
  `subject` string,
  `course_num` int,
  `credits` float,
  `prerequisites` int
);

CREATE TABLE `Class` (
  `id` int PRIMARY KEY,
  `course` int,
  `section` int,
  `instructor` int,
  `students` int,
  `semester` ENUM ('fall', 'spring'),
  `year` int,
  `days` string,
  `time` time,
  `building` id,
  `room` int
);

CREATE TABLE `Programs` (
  `id` int PRIMARY KEY,
  `degree` ENUM ('undergraduate', 'graduate', 'doctorate', 'professional'),
  `title` string,
  `required_courses` string COMMENT 'Problem when it comes to electives'
);

CREATE TABLE `Buildings` (
  `id` int PRIMARY KEY,
  `name` string,
  `address_link` string COMMENT 'To be used for map'
);

ALTER TABLE `Students` ADD FOREIGN KEY (`advisor`) REFERENCES `Instructors` (`id`);

ALTER TABLE `Programs` ADD FOREIGN KEY (`id`) REFERENCES `Students` (`major`);

ALTER TABLE `Class` ADD FOREIGN KEY (`id`) REFERENCES `Students` (`classes`);

ALTER TABLE `Students` ADD FOREIGN KEY (`id`) REFERENCES `Instructors` (`advisees`);

ALTER TABLE `Instructors` ADD FOREIGN KEY (`building`) REFERENCES `Buildings` (`id`);

ALTER TABLE `Courses` ADD FOREIGN KEY (`id`) REFERENCES `Courses` (`prerequisites`);

ALTER TABLE `Class` ADD FOREIGN KEY (`course`) REFERENCES `Courses` (`id`);

ALTER TABLE `Class` ADD FOREIGN KEY (`instructor`) REFERENCES `Instructors` (`id`);

ALTER TABLE `Students` ADD FOREIGN KEY (`id`) REFERENCES `Class` (`students`);

ALTER TABLE `Class` ADD FOREIGN KEY (`building`) REFERENCES `Buildings` (`id`);

ALTER TABLE `Courses` ADD FOREIGN KEY (`id`) REFERENCES `Programs` (`required_courses`);
