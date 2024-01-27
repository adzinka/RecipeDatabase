INSERT INTO recipe_category (id_category, name, description) VALUES
    (1, 'Soups', 'Warm and comforting'),
    (2, 'Main Courses', 'Hearty central dishes'),
    (3, 'Desserts', 'Sweet and delicious treats');

INSERT INTO ingredient (id_ingredient, name, description) VALUES
    (1, 'Tomato', 'Red and juicy tomatoes'),
    (2, 'Chicken', 'Fresh and tender chicken'),
    (3, 'Chocolate', 'Rich and dark chocolate');

INSERT INTO "User" (id_user, email, name, surname, city, country, phone, role, password, deleted_at, created_at, visited_at) VALUES
    (1, 'alice@example.com', 'Alice', 'Wonderland', 'New York', 'USA', '123456789', 'A', 'alicepass', NULL, '2020-10-04', '2023-09-08'),
    (2, 'bob@example.com', 'Bob', 'Builder', 'London', 'UK', '987654321', 'R', 'bobpass', NULL, '2019-12-04', '2023-12-04'),
    (3, 'carol@example.com', 'Carol', 'Singer', 'Sydney', 'Australia', '555666777', 'U', 'carolpass', NULL, '2018-12-11', '2023-04-08');

select *
from "User";

INSERT INTO recipe (id_recipe, title, description, preparation_time, difficulty, created_at, updated_at, user_id_user, category_id_category) VALUES
    (1, 'Tomato Soup', 'A classic tomato soup', 30, 1, '2023-01-15', '2023-01-15', 1, 1),
    (2, 'Grilled Chicken', 'Delicious grilled chicken with herbs', 45, 2, '2023-02-20', '2023-02-20', 2, 2),
    (3, 'Chocolate Cake', 'Decadent chocolate cake', 60, 3, '2023-03-25', '2023-03-25', 3, 3);

INSERT INTO cookingstep (id_step, step_number, step_description, img_url, created_at, updated_at, recipe_id_recipe) VALUES
    (1, 1, 'Chop the tomatoes', 'http://example.com/tomato.jpg', '2023-01-15', '2023-01-15', 1),
    (2, 2, 'Boil the tomatoes', 'http://example.com/boil.jpg', '2023-01-16', '2023-01-16', 1),
    (3, 1, 'Marinate the chicken', 'http://example.com/marinate.jpg', '2023-02-21', '2023-02-21', 2);


INSERT INTO favorite (created_at, updated_at, user_id_user, recipe_id_recipe) VALUES
    ('2023-01-15', '2023-01-15', 1, 1),
    ('2023-02-20', '2023-02-20', 2, 2),
    ('2023-03-25', '2023-03-25', 3, 3);

INSERT INTO recipeingredientdetail (quantity, recipe_id_recipe, ingredient_id_ingredient) VALUES
    ('2 cups', 1, 1),
    ('1 kg', 2, 2),
    ('200 g', 3, 3);

INSERT INTO review (id_review, rating, "comment", created_at, updated_at, user_id_user, recipe_id_recipe) VALUES
    (1, 5, 'Loved the soup!', '2023-01-16', '2023-01-16', 2, 1),
    (2, 4, 'Chicken was great', '2023-02-21', '2023-02-21', 3, 2),
    (3, 5, 'Best cake ever!', '2023-03-26', '2023-03-26', 1, 3);
