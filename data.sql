/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Agumon', '2020-02-03', 10.23, TRUE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Gabumon', '2018-15-11', 8, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Pikachu', '2021-01-07', 15.04, FALSE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Devimon', '2017-05-12', 11, TRUE, 5);

-- Day two project
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Charmander', '2020-02-03', -11, FALSE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Plantmon', '2020-11-15', -5.7, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Squirtle', '1993-04-02', -12.13, FALSE, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Angemon', '2005-06-12', -45, TRUE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Boarmon', '2005-06-07', 20.4, TRUE, 7);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Blossom', '1998-08-13', 17, TRUE, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Ditto', '2022-05-14', 22, TRUE, 4);

-- Insert data into owners table:
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- Insert the following data into the species table:
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
BEGIN;
UPDATE animals
SET species_id = CASE
	WHEN NAME LIKE '%mon'
    THEN (SELECT id FROM species WHERE name = 'Digimon')
	ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END;

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
update animals
set owner_id = (
    SELECT id from owners WHERE full_name = 'Sam Smith'
)
WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu.
update animals
set owner_id = (
    SELECT id from owners WHERE full_name = 'Jennifer Orwell'
)
WHERE name IN ('Gabumon', 'Pikachu');

-- Bob owns Devimon and Plantmon.
update animals
set owner_id = (
    SELECT id from owners WHERE full_name = 'Bob'
)
WHERE name IN ('Devimon', 'Plantmon');

-- Melody Pond owns Charmander, Squirtle, and Blossom.
update animals
set owner_id = (
    SELECT id from owners WHERE full_name = 'Melody Pond'
)
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Dean Winchester owns Angemon and Boarmon.
update animals
set owner_id = (
    SELECT id from owners WHERE full_name = 'Dean Winchester'
)
WHERE name IN ('Angemon', 'Boarmon');


-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
INSERT INTO vets(name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-4-23');

-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
INSERT INTO vets(name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');

-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
INSERT INTO vets(name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');

-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
INSERT INTO vets(name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');



