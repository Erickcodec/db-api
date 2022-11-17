CREATE TYPE "course_level" AS ENUM (
  'basic',
  'intermediate',
  'advanced'
);

CREATE TYPE "role_name" AS ENUM (
  'student',
  'teacher',
  'admin'
);

CREATE TABLE "users" (
  "id" serial PRIMARY KEY,
  "email" varchar(255) UNIQUE NOT NULL,
  "password" varchar(8) NOT NULL,
  "age" int8 NOT NULL,
  "role_id" int,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "courses" (
  "id" serial PRIMARY KEY,
  "title" varchar NOT NULL,
  "description" text DEFAULT '',
  "level" course_level NOT NULL,
  "teacher" varchar
);

CREATE TABLE "course_user" (
  "course_id" int,
  "user_id" int,
  "progress" float DEFAULT 0,
  "review" varchar DEFAULT ''
);

CREATE TABLE "course_videos" (
  "id" serial PRIMARY KEY,
  "title" varchar NOT NULL,
  "url" varchar NOT NULL,
  "course_id" int
);

CREATE TABLE "categories" (
  "id" serial PRIMARY KEY,
  "name" varchar UNIQUE NOT NULL
);

CREATE TABLE "course_video_category" (
  "course_video_id" int,
  "category_id" int
);

CREATE TABLE "roles" (
  "id" serial PRIMARY KEY,
  "name" role_name NOT NULL
);

ALTER TABLE "course_user" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "course_user" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "course_videos" ADD FOREIGN KEY ("course_id") REFERENCES "courses" ("id");

ALTER TABLE "course_video_category" ADD FOREIGN KEY ("course_video_id") REFERENCES "course_videos" ("id");

ALTER TABLE "course_video_category" ADD FOREIGN KEY ("category_id") REFERENCES "categories" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("role_id") REFERENCES "roles" ("id");


INSERT INTO courses (title, description, level, teacher) VALUES ('React From Scratch', '', 'basic', 'Mario Dom');
INSERT INTO courses (title, description, level, teacher) VALUES ('Backend API with Javascript and Node', '', 'advanced', 'Michael Fuller');
INSERT INTO courses (title, description, level, teacher) VALUES ('Flask With Python from Scratch', '', 'basic', 'Mario Dom');

INSERT INTO categories (name) VALUES ('Web');
INSERT INTO categories (name) VALUES ('Mobile');
INSERT INTO categories (name) VALUES ('Network');

INSERT INTO roles (name) VALUES ('student');
INSERT INTO roles (name) VALUES ('teacher');

INSERT INTO users (email, password, age, role_id, created_at) VALUES ( 'erick.medina@gmail.com', '123456', 24, 1, '2022-11-14 22:08:25.943688');
INSERT INTO users (email, password, age, role_id, created_at) VALUES ('gian.carlos.perez@gmail.com', '12345678', 25, 1, '2022-11-14 22:09:08.50817');
INSERT INTO users (email, password, age, role_id, created_at) VALUES ('yamile.perez', '1234567', 25, 2, '2022-11-14 22:09:47.825165');

INSERT INTO course_user (course_id, user_id, progress, review) VALUES (1, 1, 0, '');
INSERT INTO course_user (course_id, user_id, progress, review) VALUES (2, 1, 0, '');

INSERT INTO course_videos (title, url, course_id) VALUES ('React Installation', 'http://videos.com', 1);
INSERT INTO course_videos (title, url, course_id) VALUES ('Downloading express in node', 'http://video.com', 2);

INSERT INTO course_video_category ( course_video_id , category_id) VALUES (1, 1);
INSERT INTO course_video_category (course_video_id , category_id) VALUES (2, 1);


select c.teacher, cv.title from courses c inner join course_videos cv on cv.course_id = c.id order by cv.title; 