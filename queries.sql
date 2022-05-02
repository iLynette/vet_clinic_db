/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT * from animals WHERE `date_of_birth` between '2016-01-01'  and '2019-01-01';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE `neutered` = true AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu"
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';


