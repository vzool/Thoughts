CREATE TABLE city(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	bone INTEGER NOT NULL,
	version INTEGER NOT NULL,
	archived_at TIMESTAMP DEFAULT NULL,
	UNIQUE(bone, version, archived_at),
	UNIQUE(bone, archived_at)
);

CREATE TABLE person(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	city_id INTEGER NOT NULL REFERENCES city(id),
	name TEXT NOT NULL
);

INSERT INTO city(name, bone, version) VALUES('Arar', 111, 1); -- 1
INSERT INTO city(name, bone, version) VALUES('Riyadh', 222, 1); -- 2

INSERT INTO person(name, city_id) VALUES('Aziz', 1); -- 1
INSERT INTO person(name, city_id) VALUES('Omer', 2); -- 1

-- Update city name


UPDATE city SET archived_at = CURRENT_TIMESTAMP WHERE id = 1;
INSERT INTO city(name, bone, version) VALUES("Ar'ar", 111, 2); -- 3

UPDATE city SET archived_at = CURRENT_TIMESTAMP WHERE id = 3;
INSERT INTO city(name, bone, version) VALUES("Ar'ar City", 111, 3); -- 4

SELECT *FROM city;

SELECT 	person.id, person.city_id, person.name, current_city.name, new_city.name, current_city.version, new_city.version
FROM 	person
LEFT JOIN city current_city ON person.city_id = current_city.id 
LEFT JOIN city new_city ON current_city.bone = new_city.bone AND new_city.archived_at IS NULL;