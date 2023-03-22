CREATE TABLE account
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    email      VARCHAR(255) NOT NULL,
    password   VARCHAR(255),
    role       VARCHAR(31)  NOT NULL,
    last_login DATE,
    blocked    BOOL
);

CREATE TABLE token
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT          NOT NULL,
    expiration DATE         NOT NULL,
    content    VARCHAR(511) NOT NULL,
    FOREIGN KEY (account_id) REFERENCES account (id)
);

CREATE TABLE manager_employee
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    manager_id  INT NOT NULL,
    employee_id INT NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES account (id),
    FOREIGN KEY (employee_id) REFERENCES account (id)
);

CREATE TABLE work
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT  NOT NULL,
    begin      DATE NOT NULL,
    end        DATE,
    changed DATE NOT NULL,
    FOREIGN KEY (account_id) REFERENCES account (id)
);

CREATE TABLE vacation
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT  NOT NULL,
    begin      DATE NOT NULL,
    end        DATE,
    status VARCHAR(31),
    changed DATE NOT NULL,
    FOREIGN KEY (account_id) REFERENCES account (id)
) WITH SYSTEM VERSIONING;

CREATE TABLE profile
(
    account_id INT NOT NULL,
    work_time INT NOT NULL,
    begin_time DATE NOT NULL,
    end_time DATE NOT NULL,
    break_time INT NOT NULL,
    vacation_days INT NOT NULL,
    PRIMARY KEY (account_id),
    FOREIGN KEY (account_id) REFERENCES account(id)
)  WITH SYSTEM VERSIONING;