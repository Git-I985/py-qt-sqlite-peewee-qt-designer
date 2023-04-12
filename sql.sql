-- INSERT INTO
--     "main"."specification" (
--         "name",
--         "code",
--         "stage",
--         "developer_id",
--         "verifier_id",
--         "completed",
--         "verified"
--     )
-- VALUES
--     (
--         "Загрузочная секция",
--         "87.07.01.06.05.00.00",
--         "",
--         2,
--         1,
--         "2022-01-01 12:01:01",
--         "2022-01-02 12:01:01"
--     );
-- Секции
-- INSERT INTO
--     "main"."specificationsection" ("name")
-- VALUES
--     ("Документация"),
--     ("Сборочный чертеж"),
--     ("Сборочные единицы"),
--     ("Детали"),
--     ("комплексы"),
--     ("стандартные изделия"),
--     ("прочие изделия"),
--     ("материалы");
-- SELECT
--     *
-- FROM
--     specification;
-- 1	Документация
-- 2	Сборочный чертеж
-- 3	Сборочные единицы
-- 4	Детали
-- 5	комплексы
-- 6	стандартные изделия
-- 7	прочие изделия
-- 8	материалы
-- INSERT INTO
--     "main"."specificationitem" (
--         "specification_id",
--         "section_id",
--         -- nullable
--         "position",
--         "item_specification_id",
--         -- nullable
--         "count",
--         -- nullable
--         "note"
--     )
-- VALUES
--     -- 
--     (2, 2, NULL, 2, NULL, NULL),
--     (2, 3, 1, 11, 1, NULL),
--     (2, 3, 2, 12, 1, NULL),
--     (2, 3, 3, 16, 1, NULL),
--     (2, 3, 4, 17, 1, NULL),
--     -- детали
--     (2, 4, 7, 1, NULL, "3,6 кг."),
--     (2, 4, 8, 3, 2, "1,5 кг."),
--     (2, 4, 9, 4, 2, NULL),
--     (2, 4, 10, 14, 1, NULL),
--     (2, 4, 11, 5, 2, NULL),
--     (2, 4, 12, 6, 2, NULL),
--     (2, 4, 14, 15, 12, NULL),
--     (2, 4, 5, 13, 4, NULL),
--     -- лист
--     (2, 4, NULL, 25, NULL, NULL),
--     (2, 4, 16, 7, 2, "15,6 кг."),
--     (2, 4, 17, 8, 2, "19,3 кг."),
--     (2, 4, 18, 9, 2, "15 кг."),
--     (2, 4, 19, 10, 2, "9,6 кг."),
--     (2, 4, 4, 19, NULL, NULL),
--     (2, 4, 20, 23, 4, NULL),
--     (2, 4, 21, 20, 1, "75,3 кг."),
--     (2, 4, 4, 21, NULL, NULL),
--     (2, 4, 22, 24, 2, NULL),
--     (2, 4, 23, 22, NULL, "64 кг."),
--     (2, 4, 4, 0, NULL, NULL);
-- SELECT
--     "t1"."id",
--     "t1"."specification_id",
--     "t1"."section_id",
--     "t1"."position",
--     "t1"."item_specification_id",
--     "t1"."count",
--     "t1"."note",
--     "t2"."name",
--     "t3"."name"
-- FROM
--     "specificationitem" AS "t1"
--     INNER JOIN "specification" AS "t2" ON ("t1"."specification_id" = "t2"."id")
--     INNER JOIN "specificationsection" AS "t3" ON ("t1"."section_id" = "t3"."id")
SELECT
    -- 	#SI
    -- 	"specificationitem"."specification_id" as "specificationitem_specification_id",
    -- 	"specificationitem"."section_id" as "specificationitem_section_id",
    "specificationitem"."position" as "position",
    -- 	"specificationitem"."item_specification_id" as "specificationitem_specification_id",
    "specificationitem"."count" as "count",
    "specificationitem"."note" as "note",
    -- 	#specification
    "specification"."name" as "name",
    "specification"."code" as "code",
    "specification"."stage" as "stage",
    -- "specification"."developer_id" as "specification_developer",
    -- "specification"."verifier_id" as "specification_verifier",
    "specification"."completed" as "completed",
    "specification"."verified" as "verified",
    "developer"."name" as "developer",
    "verifier"."name" as "verifier",
    "specificationsection"."name" as "section"
FROM
    "specificationitem"
    INNER JOIN "specification" ON (
        "specificationitem"."specification_id" = "specification"."id"
        AND "specification"."id" = 2
    )
    INNER JOIN "user" AS "developer" ON (
        "developer"."id" = "specification"."developer_id"
    )
    INNER JOIN "user" AS "verifier" ON (
        "verifier"."id" = "specification"."verifier_id"
    )
    INNER JOIN "specificationsection" ON (
        "specificationitem"."section_id" = "specificationsection"."id"
    )
ORDER BY
    "specificationsection"."order" ASC,
    "specificationitem"."position";