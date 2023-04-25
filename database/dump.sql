CREATE TABLE account
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    email      VARCHAR(255)                        NOT NULL,
    password   VARCHAR(255)                        NOT NULL,
    role       ENUM ('Admin','Manager','Employee') NOT NULL,
    last_login DATETIME,
    blocked    BOOL DEFAULT false,
    work_time     TIME NOT NULL,
    begin_time    TIME NOT NULL,
    end_time      TIME NOT NULL,
    break_time    TIME NOT NULL,
    vacation_days INT  NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    changed    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE token
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT          NOT NULL,
    expiration DATETIME     NOT NULL,
    content    VARCHAR(511) NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    changed    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES account (id)
);

CREATE TABLE manager_employee
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    manager_id  INT NOT NULL,
    employee_id INT NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES account (id),
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    changed    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES account (id)
);

CREATE TABLE work
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT      NOT NULL,
    begin      DATETIME NOT NULL,
    end        DATETIME,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    changed    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES account (id)
);

CREATE TABLE sick_leave
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT  NOT NULL,
    begin      DATE NOT NULL,
    end        DATE NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    changed    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES account (id)
);

CREATE TABLE vacation
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT  NOT NULL,
    begin      DATE NOT NULL,
    end        DATE NOT NULL,
    status     ENUM ('Pending','Approved','Declined','Canceled'),
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    changed    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES account (id)
);

# Integrity Checks

# Keine Arbeit während Urlaub eintragen
#ALTER TABLE work
#    ADD CHECK ( NOT EXISTS(SELECT id
#                           FROM vacation
#                           WHERE vacation.begin <= work.begin
#                              OR vacation.end >= work.begin AND vacation.account_id = work.account_id) );

#Keine Arbeit vor Arbeitszeitbeginn anfangen
#ALTER TABLE work
#    ADD CHECK ( (SELECT HOUR(begin_time)
#                 FROM profile
#                 WHERE profile.account_id = work.account_id) <= HOUR(work.begin));

#Urlaub mind. 1 Tag lang 
#ALTER TABLE vacation
#    ADD CHECK ( HOUR(end - begin) >= 24);
