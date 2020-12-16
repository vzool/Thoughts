-- NFLR (Node, Field, Lang, Ref)
CREATE TABLE node(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT UNIQUE NOT NULL
);

CREATE TABLE field(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT UNIQUE NOT NULL
);

CREATE TABLE lang(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	code TEXT UNIQUE NOT NULL,
	UNIQUE(id, code)
);

CREATE TABLE dict(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	node_id INTEGER NOT NULL REFERENCES node(id),
	field_id INTEGER NOT NULL REFERENCES field(id),
	lang_id INTEGER NOT NULL REFERENCES lang(id),
	ref_id INTEGER NOT NULL,
	value TEXT NOT NULL,
	UNIQUE(node_id, field_id, lang_id, ref_id)
);

CREATE TABLE category(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	category_id NOT NULL REFERENCES category(id),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO node(name) VALUES('lang'); 		-- 1
INSERT INTO node(name) VALUES('category'); 	-- 2
INSERT INTO node(name) VALUES('product'); 	-- 3

INSERT INTO field(name) VALUES('name'); -- 1
INSERT INTO field(name) VALUES('desc'); -- 2

INSERT INTO lang VALUES(1, 'ar'); -- 1
INSERT INTO lang VALUES(2, 'en'); -- 2

INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(1, 1, 1, 1, '##Arabic Language##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(1, 2, 1, 1, '##Arabic Description##');

INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(1, 1, 2, 1, 'English Language');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(1, 2, 2, 1, 'Description');

-- First Category
INSERT INTO category(id) VALUES(1); -- 1
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(2, 1, 1, 1, '##Arabic Clothes##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(2, 1, 2, 1, 'English Clothes');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(2, 2, 1, 1, '##Arabic Clothes - Description##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(2, 2, 2, 1, 'English Clothes - Description');

-- Second Category
INSERT INTO category(id) VALUES(2); -- 2
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(2, 1, 1, 2, '##Arabic TOYS##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(2, 1, 2, 2, 'English TOYS');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(2, 2, 1, 2, '##Arabic TOYS - Description##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(2, 2, 2, 2, 'English TOYS - Description');

-- SELECT ARABIC
SELECT 	category.id, dict_name.value AS name, dict_desc.value AS desc, category.created_at
FROM	category
JOIN	node AS node_category ON node_category.name = 'category'
JOIN	field AS field_name ON field_name.name = 'name'
JOIN	field AS field_desc ON field_desc.name = 'desc'
JOIN	dict AS dict_name ON dict_name.node_id = node_category.id AND dict_name.field_id = field_name.id AND dict_name.ref_id = category.id
JOIN	dict AS dict_desc ON dict_desc.node_id = node_category.id AND dict_desc.field_id = field_desc.id AND dict_desc.ref_id = category.id
JOIN	lang AS lang_name ON dict_name.lang_id = lang_name.id AND lang_name.code = 'ar'
JOIN	lang AS lang_desc ON dict_desc.lang_id = lang_desc.id AND lang_desc.code = 'ar';

-- SELECT English
SELECT 	category.id, dict_name.value AS name, dict_desc.value AS desc, category.created_at
FROM	category
JOIN	node AS node_category ON node_category.name = 'category'
JOIN	field AS field_name ON field_name.name = 'name'
JOIN	field AS field_desc ON field_desc.name = 'desc'
JOIN	dict AS dict_name ON dict_name.node_id = node_category.id AND dict_name.field_id = field_name.id AND dict_name.ref_id = category.id
JOIN	dict AS dict_desc ON dict_desc.node_id = node_category.id AND dict_desc.field_id = field_desc.id AND dict_desc.ref_id = category.id
JOIN	lang AS lang_name ON dict_name.lang_id = lang_name.id AND lang_name.code = 'en'
JOIN	lang AS lang_desc ON dict_desc.lang_id = lang_desc.id AND lang_desc.code = 'en';

-- First Product in First Category
INSERT INTO product(category_id) VALUES(1); -- 1
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 1, 1, 1, '##Arabic Pants##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 1, 2, 1, 'English Pants');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 2, 1, 1, '##Arabic Pants - Description##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 2, 2, 1, 'English Pants - Description');

-- Second Product in First Category
INSERT INTO product(category_id) VALUES(1); -- 2
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 1, 1, 2, '##Arabic Shirts##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 1, 2, 2, 'English Shirts');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 2, 1, 2, '##Arabic Shirts - Description##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 2, 2, 2, 'English Shirts - Description');

-- First Product in Second Category
INSERT INTO product(category_id) VALUES(2); -- 3
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 1, 1, 3, '##Arabic Ball##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 1, 2, 3, 'English Ball');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 2, 1, 3, '##Arabic Ball - Description##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 2, 2, 3, 'English Ball - Description');

-- Second Product in Second Category
INSERT INTO product(category_id) VALUES(2); -- 4
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 1, 1, 4, '##Arabic Plastic Car##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 1, 2, 4, 'English Plastic Car');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 2, 1, 4, '##Arabic Plastic Car - Description##');
INSERT INTO dict(node_id, field_id, lang_id, ref_id, value) VALUES(3, 2, 2, 4, 'English Plastic Car - Description');

-- SELECT Category with Product in ARABIC
SELECT	category.id, category_name.value AS category_name, category_desc.value AS category_desc, category.created_at AS category_created_at, product.id, product_name.value AS product_name, product_desc.value AS product_desc, product.created_at AS product_created_at
FROM	product
JOIN	category ON product.category_id = category.id
JOIN	node AS node_category ON node_category.name = 'category'
JOIN	node AS node_product ON node_product.name = 'product'
JOIN	field AS field_name ON field_name.name = 'name'
JOIN	field AS field_desc ON field_desc.name = 'desc'
JOIN	dict AS category_name ON category_name.node_id = node_category.id AND category_name.field_id = field_name.id AND category_name.ref_id = category.id
JOIN	dict AS category_desc ON category_desc.node_id = node_category.id AND category_desc.field_id = field_desc.id AND category_desc.ref_id = category.id
JOIN	lang AS category_lang_name ON category_name.lang_id = category_lang_name.id AND category_lang_name.code = 'ar'
JOIN	lang AS category_lang_desc ON category_desc.lang_id = category_lang_desc.id AND category_lang_desc.code = 'ar'
JOIN	dict AS product_name ON product_name.node_id = node_product.id AND product_name.field_id = field_name.id AND product_name.ref_id = product.id
JOIN	dict AS product_desc ON product_desc.node_id = node_product.id AND product_desc.field_id = field_desc.id AND product_desc.ref_id = product.id
JOIN	lang AS product_lang_name ON product_name.lang_id = product_lang_name.id AND product_lang_name.code = 'ar'
JOIN	lang AS product_lang_desc ON product_desc.lang_id = product_lang_desc.id AND product_lang_desc.code = 'ar';

-- SELECT Category with Product in ENGLISH
SELECT	category.id, category_name.value AS category_name, category_desc.value AS category_desc, category.created_at AS category_created_at, product.id, product_name.value AS product_name, product_desc.value AS product_desc, product.created_at AS product_created_at
FROM	product
JOIN	category ON product.category_id = category.id
JOIN	node AS node_category ON node_category.name = 'category'
JOIN	node AS node_product ON node_product.name = 'product'
JOIN	field AS field_name ON field_name.name = 'name'
JOIN	field AS field_desc ON field_desc.name = 'desc'
JOIN	dict AS category_name ON category_name.node_id = node_category.id AND category_name.field_id = field_name.id AND category_name.ref_id = category.id
JOIN	dict AS category_desc ON category_desc.node_id = node_category.id AND category_desc.field_id = field_desc.id AND category_desc.ref_id = category.id
JOIN	lang AS category_lang_name ON category_name.lang_id = category_lang_name.id AND category_lang_name.code = 'en'
JOIN	lang AS category_lang_desc ON category_desc.lang_id = category_lang_desc.id AND category_lang_desc.code = 'en'
JOIN	dict AS product_name ON product_name.node_id = node_product.id AND product_name.field_id = field_name.id AND product_name.ref_id = product.id
JOIN	dict AS product_desc ON product_desc.node_id = node_product.id AND product_desc.field_id = field_desc.id AND product_desc.ref_id = product.id
JOIN	lang AS product_lang_name ON product_name.lang_id = product_lang_name.id AND product_lang_name.code = 'en'
JOIN	lang AS product_lang_desc ON product_desc.lang_id = product_lang_desc.id AND product_lang_desc.code = 'en';