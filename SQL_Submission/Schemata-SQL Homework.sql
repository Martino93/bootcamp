-- Tables' schemata
CREATE TABLE "Departments" (
    "dept_num" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_num"
     )
);

CREATE TABLE "dept_emp" (
    "emp_num" int   NOT NULL,
    "dept_num" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_num"
     )
);

CREATE TABLE "department_manager" (
    "dept_num" VARCHAR   NOT NULL,
    "emp_num" int   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_num" int   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(100)   NOT NULL,
    "last_name" VARCHAR(100)   NOT NULL,
    "gender" VARCHAR(5)   NOT NULL,
    "hire_date" DATE   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_num" varchar   NOT NULL,
    "salary" NUMERIC   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_num" varchar   NOT NULL,
    "title" VARCHAR(50)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_num" FOREIGN KEY("dept_num")
REFERENCES "Departments" ("dept_num");

ALTER TABLE "department_manager" ADD CONSTRAINT "fk_department_manager_dept_num" FOREIGN KEY("dept_num")
REFERENCES "Departments" ("dept_num");

ALTER TABLE "department_manager" ADD CONSTRAINT "fk_department_manager_emp_num" FOREIGN KEY("emp_num")
REFERENCES "employees" ("emp_num");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_num" FOREIGN KEY("emp_num")
REFERENCES "dept_emp" ("emp_num");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_num" FOREIGN KEY("emp_num")
REFERENCES "dept_emp" ("emp_num");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_num" FOREIGN KEY("emp_num")
REFERENCES "dept_emp" ("emp_num");

