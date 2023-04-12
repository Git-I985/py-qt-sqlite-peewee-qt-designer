SELECT
    "pspecification"."code" as "code",
    "pspecification"."stage" as "stage",
    "pspecification"."completed" as "completed",
    "pspecification"."verified" as "verified",
    "pspecification"."name" as "name",
    "developer"."name" as "developer",
    "verifier"."name" as "verifier",
    "specificationitem"."position" as "item_position",
    "specificationitem"."count" as "item_count",
    "specificationitem"."note" as "item_note",
    "cspecification"."code" as "item_code",
    "cspecification"."name" as "item_name",
    "specificationsection"."name" as "item_section"
FROM
    "specificationitem"
    INNER JOIN "specification" as "pspecification" ON (
        "specificationitem"."specification_id" = "pspecification"."id"
        AND "pspecification"."code" = "87.07.01.06.05.00.00"
    )
    INNER JOIN "specification" as "cspecification" ON (
        "specificationitem"."item_specification_id" = "cspecification"."id"
    )
    INNER JOIN "user" AS "developer" ON (
        "developer"."id" = "pspecification"."developer_id"
    )
    INNER JOIN "user" AS "verifier" ON (
        "verifier"."id" = "pspecification"."verifier_id"
    )
    INNER JOIN "specificationsection" ON (
        "specificationitem"."section_id" = "specificationsection"."id"
    )
ORDER BY
    "specificationsection"."order" ASC,
    "specificationitem"."position";