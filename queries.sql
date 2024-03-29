/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT * from animals WHERE `date_of_birth` between '2016-01-01'  and '2019-01-01';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE `neutered` = true AND `escape_attempts` < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu"
SELECT `date_of_birth` FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT `name`, `escape_attempts` FROM animals WHERE weight_kg > '10.5kg';

-- Find all animals that are neutered.
SELECT * FROM animals WHERE `neutered` = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name <> 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE `weight_kg` >= '10.4kg' AND `weight_kg` <= '17.3kg';

-- Update animals table by setting the species to unspecified
BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE from animals;
ROLLBACK;
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT SP1;

-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint, Update all animals' weights that are negative to be their weight multiplied by -1. commit
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*)
FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts)
FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg)
FROM animals;

-- escapes the most, neutered or not neutered animals?
SELECT neutered, COUNT(escape_attempts) 
from animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg)
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) from animals
WHERE date_of_birth >= '1990-01-01' and date_of_birth <= '2000-12-31'
GROUP BY species;


-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
SELECT name FROM owners
JOIN animals ON owners.id= animals.owner_id 
WHERE full_name='Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT P.name AS animal_names FROM animals P
JOIN species S ON S.id = P.species_id
WHERE S.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name 
FROM owners S
LEFT JOIN animals P on S.id = P.owner_id;

-- How many animals are there per species?
SELECT COUNT(animal.name), S.name AS species_name from animals animal
JOIN species S ON S.id = animal.species_id
GROUP BY S.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animal.name from animals animal
JOIN owners O ON O.id = animal.owner_id
WHERE O.full_name = 'Jennifer Orwell' AND animal.species_id = (SELECT id FROM species WHERE id = 2);

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animal.name from animals animal
JOIN owners O ON O.id = animal.owner_id
WHERE O.full_name = 'Dean Winchester' AND animal.escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name FROM owners 
JOIN animals ON  owners.id = animals.owner_id 
GROUP BY full_name 
ORDER BY COUNT(name) DESC;


-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name)
FROM animals
JOIN visits on animals.id = visits.animal_id
JOIN vets on vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(animals.name) FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
GROUP BY animals.name
ORDER BY animals.name DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id 
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.*, visits.visit_date, vets.* FROM animals
JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.visit_date DESC 
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(vets.name) AS number_of_visits FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN visits ON visits.vet_id = specializations.vet_id
WHERE specializations.species_id IS NULL
GROUP BY vets.name, specializations.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT COUNT(A.name) AS animal_visited, S.name as animal_type FROM animals A
JOIN visits ON A.name = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
JOIN species S ON S.id = A.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY S.name
ORDER BY COUNT(A.name) DESC;