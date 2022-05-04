/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg NUMERIC
);

-- Add species column to the animals table
ALTER TABLE animals
ADD species VARCHAR(50);

-- Create a table named owners
CREATE TABLE owners (
   id INT PRIMARY KEY,
   full_name VARCHAR(100),
   age INT
);

-- Create a table named species
CREATE TABLE species (
   id INT PRIMARY KEY,
   name VARCHAR(100)
);

-- Remove column species
ALTER TABLE animals
DROP COLUMN species;
