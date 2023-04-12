BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "user" (
	"id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	"role"	TEXT NOT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "specificationsection" (
	"id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	"order"	INTEGER,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "specificationitem" (
	"id"	INTEGER NOT NULL,
	"specification_id"	INTEGER NOT NULL,
	"section_id"	INTEGER NOT NULL,
	"position"	INTEGER,
	"item_specification_id"	INTEGER NOT NULL,
	"count"	INTEGER,
	"note"	TEXT,
	PRIMARY KEY("id"),
	FOREIGN KEY("specification_id") REFERENCES "specification"("id"),
	FOREIGN KEY("section_id") REFERENCES "specificationsection"("id"),
	FOREIGN KEY("item_specification_id") REFERENCES "specification"("id")
);
CREATE TABLE IF NOT EXISTS "specification" (
	"id"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	"code"	TEXT,
	"stage"	TEXT,
	"developer_id"	INTEGER,
	"verifier_id"	INTEGER,
	"completed"	DATETIME,
	"verified"	DATETIME,
	PRIMARY KEY("id"),
	FOREIGN KEY("developer_id") REFERENCES "user"("id"),
	FOREIGN KEY("verifier_id") REFERENCES "user"("id")
);
INSERT INTO "user" ("id","name","role") VALUES (1,'Л.Б. Гусятинер','Старший конструктор'),
 (2,'Шнейдер Алина','Младший конструктор'),
 (3,'Коновалов Эдуард','Младший конструктор');
INSERT INTO "specificationsection" ("id","name","order") VALUES (1,'Документация',1),
 (2,'Сборочный чертеж',8),
 (3,'Сборочные единицы',3),
 (4,'Детали',4),
 (5,'комплексы',2),
 (6,'стандартные изделия',5),
 (7,'прочие изделия',6),
 (8,'материалы',7);
INSERT INTO "specificationitem" ("id","specification_id","section_id","position","item_specification_id","count","note") VALUES (1,2,2,NULL,2,NULL,NULL),
 (2,2,3,1,11,1,NULL),
 (3,2,3,2,12,1,NULL),
 (4,2,3,3,16,1,NULL),
 (5,2,3,4,17,1,NULL),
 (6,2,4,7,1,NULL,'3,6 кг.'),
 (7,2,4,8,3,2,'1,5 кг.'),
 (8,2,4,9,4,2,NULL),
 (9,2,4,10,14,1,NULL),
 (10,2,4,11,5,2,NULL),
 (11,2,4,12,6,2,NULL),
 (12,2,4,14,15,12,NULL),
 (13,2,4,5,13,4,NULL),
 (14,2,4,NULL,25,NULL,NULL),
 (15,2,4,16,7,2,'15,6 кг.'),
 (16,2,4,17,8,2,'19,3 кг.'),
 (17,2,4,18,9,2,'15 кг.'),
 (18,2,4,19,10,2,'9,6 кг.'),
 (19,2,4,4,19,NULL,NULL),
 (20,2,4,20,23,4,NULL),
 (21,2,4,21,20,1,'75,3 кг.'),
 (22,2,4,4,21,NULL,NULL),
 (23,2,4,22,24,2,NULL),
 (24,2,4,23,22,NULL,'64 кг.');
INSERT INTO "specification" ("id","name","code","stage","developer_id","verifier_id","completed","verified") VALUES (1,'Уголок В-32 х 32 х 4 ГОСТ 8509-93 СТ ГОСТ 535-2005',NULL,NULL,NULL,NULL,NULL,NULL),
 (2,'Загрузочная секция','87.07.01.06.05.00.00',NULL,2,1,'2022-01-01 12:01:01','2022-01-02 12:01:01'),
 (3,'Уголок L = 1928','87.07.01.06.05.00.01',NULL,NULL,NULL,NULL,NULL),
 (4,'Уголок L = 790','87.07.01.06.05.00.02',NULL,NULL,NULL,NULL,NULL),
 (5,'Уголок','87.07.01.06.05.00.03',NULL,NULL,NULL,NULL,NULL),
 (6,'Уголок','87.07.01.06.05.00.04',NULL,NULL,NULL,NULL,NULL),
 (7,'Боковина верхняя 250 к 1992','87.07.01.06.05.00.05',NULL,NULL,NULL,NULL,NULL),
 (8,'Стенка 310 x 1992','87.07.01.06.05.00.06',NULL,NULL,NULL,NULL,NULL),
 (9,'Карниз','87.07.01.06.05.00.07',NULL,NULL,NULL,NULL,NULL),
 (10,'Боковина нижняя','87.07.01.06.05.00.08',NULL,NULL,NULL,NULL,NULL),
 (11,'Направляющая верхняя','87.07.01.06.05.01.00',NULL,NULL,NULL,NULL,NULL),
 (12,'Направляющая верхняя','87.07.01.06.05.02.00',NULL,NULL,NULL,NULL,NULL),
 (13,'Ребро','87.07.03.01.0.04',NULL,NULL,NULL,NULL,NULL),
 (14,'Уголок','87.07.03.010.01',NULL,NULL,NULL,NULL,NULL),
 (15,'Ребро','87.07.03.010.03',NULL,NULL,NULL,NULL,NULL),
 (16,'Направляющая нижняя','87.07.03.013.00',NULL,NULL,NULL,NULL,NULL),
 (17,'Направляющая нижняя','87.07.03.014.00',NULL,NULL,NULL,NULL,NULL),
 (18,'Onopa','87.07.03.010.09',NULL,NULL,NULL,NULL,NULL),
 (19,'Лист верхний','87.07.01.06.05.00.09',NULL,NULL,NULL,NULL,NULL),
 (20,'Уголок','87.07.03.010.11',NULL,NULL,NULL,NULL,NULL),
 (21,'Уголок','87.07.01.06.05.00.10',NULL,NULL,NULL,NULL,NULL),
 (22,'Днище','87.07.01.06.05.00.11',NULL,NULL,NULL,NULL,NULL),
 (23,'Лист Б-ПН-6 ГОСТ 19903-74 См3 ГOCT 14637-89 804x1998',NULL,NULL,NULL,NULL,NULL,NULL),
 (24,'Лист Б-ПH-4 TOCT 19903-74  См3 TOCT 14637-89 1025x1992',NULL,NULL,NULL,NULL,NULL,NULL),
 (25,'Лист Б-ПH-4 TOCT 19903-74  См3 TOCT 14637-89',NULL,NULL,NULL,NULL,NULL,NULL);
CREATE INDEX IF NOT EXISTS "specificationitem_specification_id" ON "specificationitem" (
	"specification_id"
);
CREATE INDEX IF NOT EXISTS "specificationitem_section_id" ON "specificationitem" (
	"section_id"
);
CREATE INDEX IF NOT EXISTS "specificationitem_item_specification_id" ON "specificationitem" (
	"item_specification_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "specification_code" ON "specification" (
	"code"
);
CREATE INDEX IF NOT EXISTS "specification_developer_id" ON "specification" (
	"developer_id"
);
CREATE INDEX IF NOT EXISTS "specification_verifier_id" ON "specification" (
	"verifier_id"
);
COMMIT;
