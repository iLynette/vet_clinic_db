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

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD species_id INT;
ALTER TABLE animals
ADD FOREIGN KEY (species_id) REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD owner_id INT;
ALTER TABLE animals
ADD FOREIGN KEY (owner_id) REFERENCES owners(id);


-- Create a table named vets with the following columns:
CREATE TABLE vets (
   id INT PRIMARY KEY,
   name VARCHAR(100),
   age INT,
   date_of_graduation DATE
);

-- There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations (
   vet_id INT,
   species_id INT,
   FOREIGN KEY (vet_id) REFERENCES vets (id),
   FOREIGN KEY (species_id) REFERENCES species (id)
);