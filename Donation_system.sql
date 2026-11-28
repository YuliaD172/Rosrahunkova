CREATE DATABASE IF NOT EXISTS Rosrahunkova;
Use Rosrahunkova;

create table Users(
id int auto_increment primary key,
login_ varchar(8) not null unique,
password_ varchar(8) not null,
full_name varchar(70) not null,
role_ enum('Admin', 'Doctor', 'Storage_facility') not null
);

create table Personality(
id int auto_increment primary key,
name_ varchar(50) not null,
surname varchar(50) not null,
middle_name varchar(50) not null,
nationality varchar(40) not null,
birth_date date not null,
weight_ decimal(5, 2) not null,
sex enum('Male', 'Famale') not null,
blood_type varchar(5) not null,
role_ enum('Donor', 'Recipient') not null
);

create table Responsible_person(
id int auto_increment primary key,
full_name varchar(150) not null,
position varchar(100) not null,
phone varchar(30),
email varchar(100)
);

create table Biomaterial_types(
id int auto_increment primary key,
name_ varchar(30) not null,
category varchar(50) not null,
specifics varchar(150),
temperature decimal(5, 2) not null
);

create table Contact_information(
id int auto_increment primary key,
email varchar(50),
phone varchar(30),
personality_id int not null,
foreign key (personality_id) references Personality(id) on delete cascade
);

create table Reference_(
id int auto_increment primary key,
personality_id int not null,
presence_of_diseases boolean default false,
accounting boolean default false,
taking_medication boolean default false,
chronic_diseases boolean default false,
contraindication boolean default false,
suspencion boolean default false,
medical_exam boolean default false,
organ_size decimal(5,2) not null,
blood_test_status enum('Perfect', 'Normal', 'Dangerous') not null,
certificate_photo varchar(400),
foreign key (personality_id) references Personality(id) on delete cascade
);

create table Place(
id int auto_increment primary key,
address_ varchar(200) not null,
name_ varchar(200) not null,
id_responsible_person int,
status_ enum('Registration', 'Storage') not null,
foreign key (id_responsible_person) references Responsible_person(id) on delete set null
);

create table Submission_request(
id int auto_increment primary key,
personality_id int not null,
doctor_id int,
diet varchar(150),
date_of_last_donation date not null,
type_donation enum('Bloode donation', 'Plasma donation') not null,
status_ varchar(50) default 'None' not null,
foreign key (personality_id) references Personality(id) on delete cascade,
foreign key (doctor_id) references Users(id) on delete set null
);

create table Submission(
id int auto_increment primary key,
personality_id int not null,
id_place int,
id_biomaterial_types int not null,
amount int not null,
status_ varchar(50) not null,
volume varchar(50),
foreign key (personality_id) references Personality(id) on delete cascade,
foreign key (id_place) references Place(id) on delete cascade,
foreign key (id_biomaterial_types) references Biomaterial_types(id) on delete cascade
);

create table Stocks_and_storage(
id int auto_increment primary key,
biomaterial_types_id int,
place_id int,
amount int not null,
expirity_date date not null,
storage_ varchar(100) not null,
temperature decimal(5, 2) not null,
filled int,
foreign key (biomaterial_types_id) references Biomaterial_types(id) on delete cascade,
foreign key (place_id) references Place(id) on delete cascade
);

INSERT INTO Users(login_, password_, full_name, role_)
VALUES('admin01', 'adm12345', 'Ковальчук Олександр Петрович', 'Admin'),
('doc_ivan', 'doc98765', 'Мельник Ірина Василівна', 'Doctor'),
('doc_oleh', 'oleg2026', 'Бойко Олег Сергійович', 'Doctor'),
('stor_01', 'str11223', 'Ткаченко Наталія Ігорівна', 'Storage_facility'),
('stor_02', 'str44556', 'Савченко Дмитро Андрійович', 'Storage_facility');

INSERT INTO Personality(name_, surname, middle_name, nationality, birth_date, weight_, sex, blood_type, role_)
VALUE('Андрій', 'Шевченко', 'Миколайович', 'Ukraine', '1992-05-14', 82.50, 'Male', '1+', 'Donor'),
('Олена', 'Бондаренко', 'Вікторівна', 'Ukraine', '1998-11-23', 58.00, 'Famale', '2-', 'Donor'),
('Максим', 'Кравченко', 'Олександрович', 'Ukraine', '1985-02-08', 91.20, 'Male', '3+', 'Donor'),
('Марія', 'Лисенко', 'Юріївна', 'Ukraine', '2001-07-30', 51.40, 'Famale', '4+', 'Donor'),
('Ігор', 'Мороз', 'Володимирович', 'Ukraine', '1979-09-12', 76.80, 'Male', '1-', 'Recipient'),
('Софія', 'Поліщук', 'Романівна', 'Ukraine', '2010-03-19', 42.00, 'Famale', '2+', 'Recipient');

INSERT INTO Responsible_person(full_name, position, phone, email)
VALUE('Захарченко Віталій Степанович', 'Завідувач відділення забору крові', '+380671234567', 'zakharchenko@medcenter.ua'),
('Романенко Світлана Олегівна', 'Головний спеціаліст кріосховища', '+380509876543', 'romanenko.storage@medcenter.ua'),
('Гриценко Тарас Павлович', 'Координатор мобільної бригади', '+380635554433', NULL);

INSERT INTO Biomaterial_types(name_, category, specifics, temperature)
VALUES('Цільна кров', 'Кров', 'Консервована з антикоагулянтом CPDA-1', 4.00),
('Плазма', 'Плазма', 'Заморожена протягом 6 годин після забору', -30.00),
('Еритроцитарна маса', 'Компоненти крові', 'Збіднена на лейкоцити', 4.50),
('Тромбоцитарний концентрат', 'Компоненти крові', 'Потребує постійного перемішування', 22.00),
('Стовбурові клітини', 'Клітинний матеріал', 'Кріоконсервація у рідкому азоті', -80.00);

INSERT INTO Contact_information(email, phone, personality_id)
VALUES('a.shevchenko@example.com', '+380671112233', 1),
('olena.bond@example.com', '+380932223344', 2),
(NULL, '+380503334455', 3),
('maria.lysenko@example.com', '+380684445566', 4),
('i.moroz@example.com', '+380975556677', 5),
('parent.polishchuk@example.com', '+380667778899', 6);

INSERT INTO Reference_(personality_id, presence_of_diseases, accounting, taking_medication, chronic_diseases, contraindication, suspencion, medical_exam, organ_size, blood_test_status)
VALUES(1, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, 12.50, 'Perfect'),
(2, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE, 11.20, 'Normal'),
(3, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, 13.00, 'Normal'),
(4, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, 10.80, 'Dangerous'),
(5, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE, 14.10, 'Dangerous'),
(6, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, 9.50, 'Normal');

INSERT INTO Place(address_, name_, status_, id_responsible_person)
VALUES
('м. Київ, вул. Максима Берлинського, 12', 'Київський міський центр крові (Реєстратура)', 'Registration', 1),
('м. Львів, вул. Пекарська, 65', 'Львівський обласний центр служби крові', 'Registration', 3),
('м. Київ, вул. Академіка Заболотного, 150', 'Центральне кріосховище №1', 'Storage', 2),
('м. Дніпро, просп. Богдана Хмельницького, 17', 'Резервний банк крові Схід', 'Storage', NULL);

INSERT INTO Submission_request(personality_id, doctor_id, diet, date_of_last_donation, type_donation, status_)
VALUES(1, 2, 'Дотримувався дієти 48 годин, без жирного та алкоголю', '2026-08-10', 'Bloode donation', 'Approved'),
(2, 3, 'Легкий сніданок, багато води', '2026-10-01', 'Plasma donation', 'Approved'),
(3, 2, 'Порушення дієти (вживав смажену їжу)', '2026-05-15', 'Bloode donation', 'Rejected'),
(4, NULL, 'Не вказано', '2025-12-20', 'Plasma donation', 'None'),
(1, 3, 'Без обмежень', '2026-11-01', 'Plasma donation', 'Pending');


INSERT INTO Submission(personality_id, id_place, id_biomaterial_types, amount, status_, volume)
VALUES(1, 1, 1, 1, 'Completed', '450 мл'),
(2, 2, 2, 1, 'Completed', '600 мл'),
(1, 1, 4, 1, 'In_progress', '250 мл'),
(3, 2, 1, 1, 'Cancelled', '0 мл'),
(5, 3, 3, 2, 'Issued_to_recipient', '500 мл');


INSERT INTO Stocks_and_storage(biomaterial_types_id, place_id, amount, expirity_date, storage_, temperature, filled)
VALUES(1, 3, 45, '2026-12-25', 'Холодильна камера А-1', 4.00, 75),
(2, 3, 120, '2027-11-20', 'Морозильний бокс М-4', -30.00, 60),
(3, 4, 30, '2026-12-15', 'Холодильник Б-2', 4.50, 50),
(4, 3, 10, '2026-11-30', 'Тромбоміксер Т-1', 22.00, 90),
(5, 3, 15, '2031-05-01', 'Кріогенний танк К-01', -80.00, 30),
(1, 4, 5, '2026-11-10', 'Карантинний холодильник К-9', 4.00, 10);

-- Вхід в систему Log In

SELECT id, full_name, role_
FROM Users
WHERE login_ = 'admin01'  
  AND password_ = 'adm12345';

-- User: Doctor

-- Request dashboard

INSERT INTO Submission_request (personality_id, doctor_id, diet, date_of_last_donation, type_donation, status_)
SELECT id, (SELECT id FROM Users WHERE full_name LIKE '%Бойко%' LIMIT 1), 'Легкий сніданок, багато води', '2026-10-01', 'Plasma donation', 'Approved'
FROM Personality 
WHERE surname = 'Бондаренко' AND name_ = 'Олена';


-- По пошуку

select Users.full_name AS 'User', Users.role_ AS 'Position',Submission_request.status_ as 'Status', DATE_FORMAT(CASE
  WHEN Submission_request.type_donation = 'Bloode donation' THEN DATE_ADD(Submission_request.date_of_last_donation, INTERVAL 60 day)
  WHEN Submission_request.type_donation = 'Plasma donation' THEN DATE_ADD(Submission_request.date_of_last_donation, INTERVAL 14 day)
  Else DATE_ADD(Submission_request.date_of_last_donation, INTERVAL 60 DAY)
END, '%d.%m.%Y') AS 'Future donation date',
 CONCAT(Personality.surname, " ", Personality.name_, " ", Personality.middle_name) AS 'Person full name'
 FROM Personality
 LEFT JOIN Submission_request ON Personality.id = Submission_request.personality_id
 LEFT JOIN Users ON Users.id = 3
 WHERE concat(Personality.surname, " ", Personality.name_, " ", Personality.middle_name) LIKE '%Бонд%' ;

-- Фільтр по статусу на донорстві
SELECT Users.full_name AS 'User', 
       Users.role_ AS 'Position',
       Submission_request.status_ AS 'Status', 
       DATE_FORMAT(CASE
           WHEN Submission_request.type_donation = 'Bloode donation' AND Personality.sex = 'Male' THEN DATE_ADD(Submission_request.date_of_last_donation, INTERVAL 60 DAY)
           WHEN Submission_request.type_donation = 'Bloode donation' AND Personality.sex = 'Famale' THEN DATE_ADD(Submission_request.date_of_last_donation, INTERVAL 90 DAY)
           WHEN Submission_request.type_donation = 'Plasma donation' THEN DATE_ADD(Submission_request.date_of_last_donation, INTERVAL 14 DAY)
           ELSE DATE_ADD(Submission_request.date_of_last_donation, INTERVAL 60 DAY)
       END, '%d.%m.%Y') AS 'Future donation date',
       CONCAT(Personality.surname, " ", Personality.name_, " ", Personality.middle_name) AS 'Person full name'
FROM Personality
JOIN Submission_request ON Personality.id = Submission_request.personality_id
LEFT JOIN Users ON Users.id = (SELECT id FROM Users WHERE role_ = 'Doctor' LIMIT 1)
WHERE Submission_request.status_ = 'Approved';

-- Редагування

 UPDATE Submission_request
 SET
    status_ = 'On rest'
WHERE personality_id = 1;

 -- Submission_request
SELECT Users.full_name AS 'User', 
       Users.role_ AS 'Position', 
       Personality.id AS 'ID', 
       Submission_request.diet AS 'Diet', 
       DATE_FORMAT(Submission_request.date_of_last_donation, '%d.%m.%Y') AS 'Date of last donation', 
       Submission_request.type_donation AS 'Type donation'
FROM Submission_request 
JOIN Personality ON personality_id = Personality.id 
LEFT JOIN Users ON Users.id = Submission_request.doctor_id
WHERE CONCAT(Personality.surname, " ", Personality.name_, " ", Personality.middle_name) LIKE '%Шевченко%'
  AND Submission_request.type_donation = 'Bloode donation';

-- Редагування

 UPDATE Submission_request
 SET
    diet = 'No diet'
WHERE personality_id = 1;

-- Personality


-- З фільтром на роль донора

SELECT Users.full_name AS 'User', 
       Users.role_ AS 'Position', 
       Personality.id AS 'ID', 
       Personality.name_ AS 'Name', 
       Personality.surname AS 'Surname',
       Personality.middle_name AS 'Middle name', 
       Personality.nationality AS 'Nationality', 
       Personality.birth_date AS 'Birth date',
       Personality.weight_ AS 'Weight', 
       Personality.sex AS 'Sex', 
       Personality.blood_type AS 'Bloode type', 
       Personality.role_ AS 'Role'
FROM Personality
LEFT JOIN Submission_request ON Submission_request.personality_id = Personality.id
LEFT JOIN Users ON Users.id = Submission_request.doctor_id
WHERE Personality.role_ = 'Donor' 
  AND CONCAT(Personality.surname, " ", Personality.name_, " ", Personality.middle_name) LIKE '%Бондаренко%';

 -- Редагування

 UPDATE Personality
 SET
    blood_type = '1+',
    weight_ = 57.20,
    role_ = 'Recipient'
WHERE id = 1;


 -- Reference
SELECT Users.full_name AS 'User', 
       Users.role_ AS 'Position', 
       Reference_.presence_of_diseases AS 'Preference of diseases', 
       Reference_.accounting AS 'Accounting',
       Reference_.taking_medication AS 'Taking medication', 
       Reference_.chronic_diseases AS 'Chronic diseases', 
       Reference_.contraindication AS 'Contraindication',
       Reference_.suspencion AS 'Suspencion', 
       Reference_.medical_exam AS 'Medical exam'
FROM Reference_
LEFT JOIN Personality ON Personality.id = Reference_.personality_id
LEFT JOIN Submission_request ON Submission_request.personality_id = Personality.id
LEFT JOIN Users ON Users.id = Submission_request.doctor_id
WHERE CONCAT(Personality.surname, " ", Personality.name_, " ", Personality.middle_name) LIKE '%Кравченко%';

 -- Редагування

 UPDATE Reference_
 SET
    presence_of_diseases = 1,
    accounting = 0,
    taking_medication = 0,
    chronic_diseases = 0,
    contraindication = 0,
    suspencion = 0,
    medical_exam = 1
WHERE personality_id = 1;


-- Compability

-- Для крові

SELECT recipient.blood_type AS 'Bloode type', 
       CONCAT(donor.surname, " ", donor.name_, " ", donor.middle_name) AS 'Donor full name',
       CASE
           WHEN donor.blood_type = recipient.blood_type THEN 'Perfectly compatible'
           WHEN donor.blood_type = '4-' AND recipient.blood_type IN('1-', '2-', '3-') THEN 'compatible'
           WHEN donor.blood_type = '2+' AND recipient.blood_type IN('2-', '1+', '1-') THEN 'compatible'
           WHEN donor.blood_type = '2-' AND recipient.blood_type IN('1-') THEN 'compatible'
           WHEN donor.blood_type = '3+' AND recipient.blood_type IN('3-', '1+', '1-') THEN 'compatible'
           WHEN donor.blood_type = '3-' AND recipient.blood_type IN('1-') THEN 'compatible'
           WHEN donor.blood_type = '1+' AND recipient.blood_type IN('1-') THEN 'compatible'
           WHEN donor.blood_type = '1-' THEN 'compatible'
           ELSE 'Incompatible'
       END AS Compatibility
FROM Personality recipient 
JOIN Personality donor ON recipient.id != donor.id
WHERE recipient.id = 5 AND recipient.role_ = 'Recipient' AND donor.role_ = 'Donor'
ORDER BY CASE Compatibility 
    WHEN 'Perfectly compatible' THEN 1
    WHEN 'compatible' THEN 2
    ELSE 3 
END;


-- Для органів

SELECT recipient.blood_type AS 'Bloode type', CONCAT(donor.surname, " ", donor.name_, " ", donor.middle_name) AS 'Donor full name',
donor.weight_ AS 'Size', Reference_.blood_test_status AS 'Blood test',
CASE
  WHEN donor.blood_type = recipient.blood_type AND (ABS(donor.weight_ - recipient.weight_) / donor.weight_) <=0.15 AND Reference_.blood_test_status ='Perfect' THEN 'Perfectly compatible'
  WHEN donor.blood_type = '4-' AND recipient.blood_type IN('1-', '2-', '3-') AND (ABS(donor.weight_ - recipient.weight_) / donor.weight_) <=0.20 AND Reference_.blood_test_status IN ('Perfect', 'Normal') THEN 'compatible'
  WHEN donor.blood_type = '2+' AND recipient.blood_type IN('2-', '1+', '1-') AND (ABS(donor.weight_ - recipient.weight_) / donor.weight_) <=0.20 AND Reference_.blood_test_status IN ('Perfect', 'Normal') THEN 'compatible'
  WHEN donor.blood_type = '2-' AND recipient.blood_type IN('1-') AND (ABS(donor.weight_ - recipient.weight_) / donor.weight_) <=0.20 AND Reference_.blood_test_status IN ('Perfect', 'Normal') THEN 'compatible'
  WHEN donor.blood_type = '3+' AND recipient.blood_type IN('3-', '1+', '1-') AND (ABS(donor.weight_ - recipient.weight_) / donor.weight_) <=0.20 AND Reference_.blood_test_status IN ('Perfect', 'Normal') THEN 'compatible'
  WHEN donor.blood_type = '3-' AND recipient.blood_type IN('1-') AND (ABS(donor.weight_ - recipient.weight_) / donor.weight_) <=0.20 AND Reference_.blood_test_status IN ('Perfect', 'Normal') THEN 'compatible'
  WHEN donor.blood_type = '1+' AND recipient.blood_type IN('1-') AND (ABS(donor.weight_ - recipient.weight_) / donor.weight_) <=0.20 AND Reference_.blood_test_status IN ('Perfect', 'Normal') THEN 'compatible'
  WHEN donor.blood_type = '1-' THEN 'compatible'
ELSE 'Incompatible'
END AS 'Compatibility'
FROM Personality recipient JOIN Personality donor ON recipient.id != donor.id LEFT JOIN Reference_ ON donor.id = Reference_.personality_id
WHERE recipient.id = 1 AND recipient.role_ = 'Recipient' AND donor.role_ = 'Donor'
ORDER BY CASE 'Compatibility' WHEN 'perfectly compatible' THEN 1
WHEN 'compatible' THEN 2
ELSE 3 END;


-- Contact information

SELECT id AS 'ID', email AS 'Email', phone AS 'Phone'
FROM Contact_information;


-- Storage facility
-- Submission

SELECT Users.full_name AS 'User', 
       Users.role_ AS 'Position',
       Submission.id AS 'ID', 
       Submission.amount AS 'Amount',
       Submission.status_ AS 'Status', 
       Submission.volume AS 'Volume'
FROM Submission
JOIN Personality ON Personality.id = Submission.personality_id
LEFT JOIN Submission_request ON Submission_request.personality_id = Personality.id
LEFT JOIN Users ON Users.id = 4 -- працівник сховища
WHERE Submission.volume LIKE '%450%' 
  AND Submission.status_ = 'Completed';

-- Place of Registration

SELECT Users.full_name AS `User`,
       Users.role_ AS `Position`,
       Place.id AS `ID`,
       Place.address_ AS `Address`,
       Place.name_ AS `Name`
FROM Place
JOIN Users ON Users.id = 4 -- працівник сховища
WHERE Place.status_ = 'Registration' 
  AND Place.name_ LIKE '%Київський%';

-- Biomaterial types

SELECT Users.full_name AS `User`, 
       Users.role_ AS `Position`,
       Biomaterial_types.id AS 'ID', 
       Biomaterial_types.name_ AS 'Name',
       Biomaterial_types.category AS 'Category', 
       Biomaterial_types.specifics AS 'Specifics',
       Biomaterial_types.temperature AS 'Temperature'
FROM Biomaterial_types
JOIN Users ON Users.id = 4
WHERE Biomaterial_types.name_ LIKE '%Кров%' AND Biomaterial_types.temperature = 4.00;

-- Stocks and storage

SELECT Users.full_name AS 'User',
       Users.role_ AS 'Position',
       Stocks_and_storage.id AS 'ID',
       Stocks_and_storage.amount AS 'Amount',
       Biomaterial_types.name_ AS 'Type',
       DATE_FORMAT(Stocks_and_storage.expirity_date, '%d.%m.%Y') AS 'Expiry date',
       Stocks_and_storage.storage_ AS 'Storage',
       Stocks_and_storage.temperature AS 'Temperature',
       CONCAT(Stocks_and_storage.filled, '%') AS 'Filled'
FROM Stocks_and_storage
JOIN Biomaterial_types ON Stocks_and_storage.biomaterial_types_id = Biomaterial_types.id
JOIN Users ON Users.id = 4
WHERE Biomaterial_types.name_ LIKE '%Кров%' -- поле Search
  AND Stocks_and_storage.expirity_date >= '2026-11-27' -- фільтр All / Актуальні
ORDER BY Stocks_and_storage.expirity_date ASC;

-- Кнопка EDIT

UPDATE Stocks_and_storage
SET amount = 40,
    filled = 70
WHERE id = 1;

-- Storage place

SELECT Users.full_name AS 'User',
       Users.role_ AS 'Position',
       Place.id AS 'ID',
       Place.address_ AS 'Address',
       Place.name_ AS 'Name'
FROM Place
JOIN Users ON Users.id = 4
WHERE Place.status_ = 'Storage'
  AND Place.name_ LIKE '%кріосховище%'; -- поле Search
  
-- Edit
  
  UPDATE Place
SET address_ = 'м. Київ, вул. Академіка Заболотного, 152',
    name_ = 'Центральне кріосховище №1 (Оновлене)'
WHERE id = 3;

-- Responcible person

SELECT Users.full_name AS 'User',
       Users.role_ AS 'Position',
       Responsible_person.id AS 'ID',
       Responsible_person.full_name AS 'Full name',
       Responsible_person.position AS 'Position',
       Responsible_person.phone AS 'Phone',
       Responsible_person.email AS 'Email'
FROM Responsible_person
JOIN Place ON Place.id_responsible_person = Responsible_person.id
JOIN Users ON Users.id = 4
WHERE Place.id = 3;

-- Role: Admin
-- Submission 

SELECT Users.full_name AS 'User',
       Users.role_ AS 'Position',
       Submission.id AS 'ID',
       DATE_FORMAT(Submission_request.date_of_last_donation, '%d.%m.%Y') AS 'Date',
       Submission.amount AS 'Amount',
       Submission.status_ AS 'Status',
       Submission.volume AS 'Volume'
FROM Submission
JOIN Personality ON Submission.personality_id = Personality.id
LEFT JOIN Submission_request ON Submission_request.personality_id = Personality.id
JOIN Users ON Users.id = 1 -- Admin
WHERE Submission.status_ != 'Deleted'
  AND CONCAT(Personality.surname, ' ', Personality.name_) LIKE '%Шевченко%'; -- пошук за Personality
  
-- Add
  
INSERT INTO Submission(personality_id, id_place, id_biomaterial_types, amount, status_, volume)
VALUES (1, 1, 1, 1, 'In_progress', '450 мл');

-- Delete

UPDATE Submission
SET status_ = 'Deleted'
WHERE id = 3;

-- Перевірка де видалення заборонено

SELECT Users.full_name AS 'User',
       Users.role_ AS 'Position',
       Place.id AS 'ID',
       Place.address_ AS 'Address',
       Place.name_ AS 'Name',
       Place.status_ AS 'Type'
FROM Place
JOIN Users ON Users.id = 1;