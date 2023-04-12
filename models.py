from peewee import *
from playhouse.migrate import *
# from backend.defaults import default_books, default_users, default_reviews

db = SqliteDatabase('app.db')


class BaseModel(Model):
    class Meta:
        database = db

class User(BaseModel):
    name = TextField()
    role = TextField()
    pass

class Specification(BaseModel):
    name = TextField()
    code = TextField(unique=True, null=True)
    stage = TextField(null = True)
    developer = ForeignKeyField(User, backref='developed_specifications', null=True)
    verifier = ForeignKeyField(User, backref='verified_specifications', null=True)
    completed = DateTimeField(null = True)
    verified = DateTimeField(null = True)

class SpecificationSection(BaseModel):
    name = TextField()
    order = IntegerField(null=True)

class SpecificationItem(BaseModel):
    # specificationS
    specification = ForeignKeyField(Specification, backref='specification')
    section = ForeignKeyField(SpecificationSection, backref='section')
    position = IntegerField(null=True)
    item_specification = ForeignKeyField(Specification, backref='item_specification')
    count = IntegerField(null=True)
    note = TextField(null=True)

def create_tables():
    with db:
        db.create_tables([User, Specification, SpecificationSection, SpecificationItem])

# create_tables()
    
"""
# Требуется:
# - отпечатать спецификацию по коду изделия в порядке возрастания кода раздела и позиции);
# - отпечатать алфавитный список стандартных изделий.
# for s in SpecificationItem.select().where(SpecificationItem.specification == 2):
#     print(s.item_specification.name)

SELECT
    *
FROM
    "specificationitem" AS "t1"
    INNER JOIN "specification" AS "t2" ON ("t1"."specification_id" = "t2"."id" AND "t2"."id" = 2)
    INNER JOIN "specificationsection" AS "t3" ON ("t1"."section_id" = "t3"."id")
	ORDER BY "t3"."order" ASC, "t1"."position";
"""

def get_sql(code):
    return 'SELECT' + \
    '    "pspecification"."stage" as "stage",' + \
    '    "pspecification"."completed" as "completed",' + \
    '    "pspecification"."verified" as "verified",' + \
    '    "pspecification"."name" as "name",' + \
    '    "developer"."name" as "developer",' + \
    '    "verifier"."name" as "verifier",' + \
    '    "specificationitem"."position" as "item_position",' + \
    '    "specificationitem"."count" as "item_count",' + \
    '    "specificationitem"."note" as "item_note",' + \
    '    "cspecification"."code" as "item_code",' + \
    '    "cspecification"."name" as "item_name",' + \
    '    "specificationsection"."name" as "item_section"' + \
    'FROM' + \
    '    "specificationitem"' + \
    '    INNER JOIN "specification" as "pspecification" ON (' + \
    '        "specificationitem"."specification_id" = "pspecification"."id"' + \
    f'        AND "pspecification"."code" = "{code}"' + \
    '    )' + \
    '    INNER JOIN "specification" as "cspecification" ON (' + \
    '        "specificationitem"."item_specification_id" = "cspecification"."id"' + \
    '    )' + \
    '    INNER JOIN "user" AS "developer" ON (' + \
    '        "developer"."id" = "pspecification"."developer_id"' + \
    '    )' + \
    '    INNER JOIN "user" AS "verifier" ON (' + \
    '        "verifier"."id" = "pspecification"."verifier_id"' + \
    '    )' + \
    '    INNER JOIN "specificationsection" ON (' + \
    '        "specificationitem"."section_id" = "specificationsection"."id"' + \
    '    )' + \
    'ORDER BY' + \
    '    "specificationsection"."order" ASC,' + \
    '    "specificationitem"."position";'


def get_spec_by_code(code):
    try:
        cursor = db.execute_sql(get_sql(code))
        return cursor.fetchall()
        # print(db)
        # sql = f'"
        # return SpecificationItem.select()\
        #     .join(Specification, on=(SpecificationItem.specification == Specification.id and Specification.code == code))\
        #     .join(SpecificationSection, on=(SpecificationItem.section == SpecificationSection.id))\
        #     .order_by(+SpecificationSection.order)\
        #     .order_by(+SpecificationItem.position)
    except:
        return None

# print(get_spec_by_code("87.07.01.06.05.00.00"))
# for i in get_spec_by_code()

# for i in res:
#     print(res.name)

# https://docs.peewee-orm.com/en/latest/peewee/playhouse.html?highlight=ALTER%20TABLE#example-usage
# migrator = SqliteMigrator(db)
# migrate(
#     migrator.add_column('specificationsection', 'order', IntegerField(null=True)),
# )