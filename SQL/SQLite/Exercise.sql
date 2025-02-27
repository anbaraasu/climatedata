-- Need SQLite Scenario Based Exercise involving four tables w.r.t Cooking Receipe Database

-- Table 1: Recipe
-- Fields: RecipeID, RecipeName, RecipeDescription, RecipeType, RecipeCuisine, RecipePreparationTime, RecipeCookingTime, RecipeServings, RecipeCalories, RecipeRating
CREATE TABLE RECIPE (
    RecipeID INT PRIMARY KEY,
    RecipeName TEXT NOT NULL,
    RecipeDescription TEXT NOT NULL,
    RecipeType TEXT NOT NULL,
    RecipeCuisine TEXT NOT NULL,
    RecipePreparationTime INT NOT NULL,
    RecipeCookingTime INT NOT NULL,
    RecipeServings INT NOT NULL,
    RecipeCalories INT NOT NULL,
    RecipeRating INT NOT NULL,
    ReceipeCategory CHAR(1) NOT NULL CHECK (ReceipeCategory IN ('V', 'N'))
);

-- Table 2: Ingredient
-- Fields: IngredientID, IngredientName, IngredientType, IngredientCalories
CREATE TABLE INGREDIENT (
    IngredientID INT PRIMARY KEY,
    IngredientName TEXT NOT NULL,
    IngredientType TEXT NOT NULL,
    IngredientCalories INT NOT NULL
);

-- Table 3: RecipeIngredient
-- Fields: RecipeID, IngredientID, IngredientQuantity
CREATE TABLE RECIPE_INGREDIENT (
    RecipeID INT,
    IngredientID INT,
    IngredientQuantity INT,
    PRIMARY KEY (RecipeID, IngredientID),
    FOREIGN KEY (RecipeID) REFERENCES RECEIPE(RecipeID),
    FOREIGN KEY (IngredientID) REFERENCES INGREDIENT(IngredientID)
);

-- Table 4: RecipeSteps
-- Fields: RecipeID, StepNumber, StepDescription
CREATE TABLE RECIPE_STEPS (
    RecipeID INT,
    StepNumber INT,
    StepDescription TEXT NOT NULL,
    StepDuration INT,
    PRIMARY KEY (RecipeID, StepNumber),
    FOREIGN KEY (RecipeID) REFERENCES RECEIPE(RecipeID)
);

-- Sample Data

-- Insert into RECIPE
INSERT INTO RECIPE (RecipeID, RecipeName, RecipeDescription, RecipeType, RecipeCuisine, RecipePreparationTime, RecipeCookingTime, RecipeServings, RecipeCalories, RecipeRating, ReceipeCategory) VALUES
(1, 'Vegetarian Lasagna', 'Delicious layers of pasta, cheese, and vegetables', 'Main Course', 'Italian', 30, 60, 4, 600, 5, 'V'),
(2, 'Chicken Curry', 'Spicy and flavorful chicken curry', 'Main Course', 'Indian', 20, 40, 4, 500, 4, 'N'),
(3, 'Beef Stroganoff', 'Creamy beef and mushroom dish', 'Main Course', 'Russian', 15, 45, 4, 700, 5, 'N'),
(4, 'Chocolate Cake', 'Rich and moist chocolate cake', 'Dessert', 'American', 20, 30, 8, 400, 5, 'V'),
(5, 'Fruit Salad', 'Fresh and healthy fruit salad', 'Dessert', 'Global', 10, 0, 4, 150, 4, 'V'),
(6, 'Apple Pie', 'Classic apple pie with a flaky crust', 'Dessert', 'American', 30, 60, 8, 350, 5, 'V'),
(7, 'Mango Pudding', 'Sweet and creamy mango pudding', 'Dessert', 'Asian', 15, 0, 4, 200, 4, 'V');

-- Insert into INGREDIENT
INSERT INTO INGREDIENT (IngredientID, IngredientName, IngredientType, IngredientCalories) VALUES
(1, 'Pasta', 'Grain', 200),
(2, 'Cheese', 'Dairy', 100),
(3, 'Vegetables', 'Vegetable', 50),
(4, 'Chicken', 'Meat', 250),
(5, 'Beef', 'Meat', 300),
(6, 'Mushrooms', 'Vegetable', 20),
(7, 'Chocolate', 'Sweet', 150),
(8, 'Fruits', 'Fruit', 50),
(9, 'Apples', 'Fruit', 80),
(10, 'Mango', 'Fruit', 60);

-- Insert into RECIPE_INGREDIENT
INSERT INTO RECIPE_INGREDIENT (RecipeID, IngredientID, IngredientQuantity) VALUES
(1, 1, 200),
(1, 2, 100),
(1, 3, 150),
(2, 4, 300),
(3, 5, 400),
(3, 6, 100),
(4, 7, 200),
(5, 8, 300),
(6, 9, 400),
(7, 10, 200);

-- Insert into RECIPE_STEPS
INSERT INTO RECIPE_STEPS (RecipeID, StepNumber, StepDescription, StepDuration) VALUES
(1, 1, 'Boil pasta', 10),
(1, 2, 'Layer pasta with cheese and vegetables', 20),
(1, 3, 'Bake in oven', 30),
(2, 1, 'Cook chicken with spices', 20),
(2, 2, 'Add sauce and simmer', 20),
(3, 1, 'Cook beef with mushrooms', 20),
(3, 2, 'Add cream and simmer', 25),
(4, 1, 'Mix ingredients', 10),
(4, 2, 'Bake in oven', 20),
(5, 1, 'Chop fruits', 10),
(6, 1, 'Prepare pie crust', 20),
(6, 2, 'Fill with apples and bake', 40),
(7, 1, 'Blend mangoes', 10),
(7, 2, 'Chill in refrigerator', 5);

-- Query 1: List all recipes with their ingredients for Indian Main Course and Thai Dessert
SELECT R.RecipeName, I.IngredientName, I.IngredientType, I.IngredientCalories
FROM RECIPE R
JOIN RECIPE_INGREDIENT RI ON R.RecipeID = RI.RecipeID
JOIN INGREDIENT I ON RI.IngredientID = I.IngredientID
WHERE (R.RecipeCuisine = 'Indian' AND R.ReceipeCategory = 'N') OR (R.RecipeCuisine = 'Thai' AND R.ReceipeCategory = 'V');

