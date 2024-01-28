/* 1;1;3;výpis všech receptů seřazených sestupně podle délky názvu */
SELECT id_recipe, title, LEN(title) AS title_length
FROM recipe
ORDER BY title_length DESC;

/* 1;2;3;výpis všech receptů seřazených vzestupně podle počtu ingrediencí */
SELECT r.id_recipe, r.title, COUNT(rid.ingredient_id_ingredient) AS ingredient_count
FROM recipe r
JOIN recipeingredientdetail rid ON r.id_recipe = rid.recipe_id_recipe
GROUP BY r.id_recipe, r.title
ORDER BY ingredient_count;

/* 1;3;3;výpis všech ingrediencí seřazených podle názvu */
SELECT id_ingredient, name
FROM ingredient
ORDER BY name;

/* 1;4;3;názvy receptů a čas přípravy, přičemž čas přípravy bude vydělen dvěma, seřazené od nejkratšího času */
SELECT title, preparation_time / 2 AS half_preparation_time
FROM recipe
ORDER BY half_preparation_time;

/* 2;1;2;výběr receptů s přípravným časem nad 30 minut a obtížností 2 nebo 3 */
SELECT id_recipe, title, preparation_time, difficulty
FROM recipe
WHERE preparation_time > 30 AND (difficulty = 2 OR difficulty = 3);

/* 2;2;2;výběr uživatelů, kteří nejsou z 'USA' */
SELECT id_user, name, surname, country
FROM "User"
WHERE NOT country = 'USA';

/* 2;3;1;výběr receptů, jejichž název obsahuje slovo 'Soup' */
SELECT id_recipe, title
FROM recipe
WHERE title LIKE '%Soup%';

/* 2;4;2;výběr receptů s výpočtem zvýšené obtížnosti o 1 */
SELECT id_recipe, title, difficulty, difficulty + 1 AS increased_difficulty
FROM recipe
WHERE difficulty < 3;

/* 3;1;1;výběr receptů přidaných uživatelem s ID 1 (IN) */
SELECT id_recipe, title
FROM recipe
WHERE user_id_user IN (SELECT id_user FROM "User" WHERE id_user = 1);

/* 3;2;1;výběr receptů přidaných uživatelem s ID 1 (EXISTS) */
SELECT id_recipe, title
FROM recipe r
WHERE EXISTS (SELECT 1 FROM "User" u WHERE u.id_user = r.user_id_user AND u.id_user = 1);

/* 3;3;1;výběr receptů přidaných uživatelem s ID 1 (ALL) */
SELECT id_recipe, title
FROM recipe
WHERE user_id_user = ALL (SELECT id_user FROM "User" WHERE id_user = 1);

/* 3;4;1;výběr receptů přidaných uživatelem s ID 1 (EXCEPT) */
SELECT id_recipe, title
FROM recipe
EXCEPT
SELECT id_recipe, title
FROM recipe
WHERE user_id_user != 1;

/* 4;1;3;průměrný čas přípravy receptů podle kategorie */
SELECT rc.name AS category_name, AVG(r.preparation_time) AS avg_preparation_time
FROM recipe r
JOIN recipe_category rc ON r.category_id_category = rc.id_category
GROUP BY rc.name;

/* 4;2;3;počet receptů pro každého uživatele */
SELECT u.id_user, u.name, COUNT(r.id_recipe) AS recipe_count
FROM "User" u
JOIN recipe r ON u.id_user = r.user_id_user
GROUP BY u.id_user, u.name;

/* 4;3;2;celkový počet kroků vaření pro každý recept */
SELECT r.id_recipe, r.title, COUNT(cs.id_step) AS total_steps
FROM recipe r
JOIN cookingstep cs ON r.id_recipe = cs.recipe_id_recipe
GROUP BY r.id_recipe, r.title;

/* 4;4;2;recepty s průměrným hodnocením vyšším než 4 */
SELECT r.id_recipe, r.title
FROM recipe r
JOIN review rv ON r.id_recipe = rv.recipe_id_recipe
GROUP BY r.id_recipe, r.title
HAVING AVG(rv.rating) > 4;

/* 5;1;1;průměrné hodnocení receptů přidaných uživatelem s ID 1 (JOIN) */
SELECT r.id_recipe, r.title, AVG(rv.rating) AS average_rating
FROM recipe r
JOIN review rv ON r.id_recipe = rv.recipe_id_recipe
WHERE r.user_id_user = 1
GROUP BY r.id_recipe, r.title;

/* 5;2;1;průměrné hodnocení receptů přidaných uživatelem s ID 1 (IN) */
SELECT r.id_recipe, r.title, (SELECT AVG(rating) FROM review WHERE recipe_id_recipe = r.id_recipe) AS average_rating
FROM recipe r
WHERE r.id_recipe IN (SELECT id_recipe FROM recipe WHERE user_id_user = 1)
GROUP BY r.id_recipe, r.title;

/* 5;3;3;počet recenzí pro každý recept s vnějším spojením */
SELECT r.id_recipe, r.title, COUNT(rv.id_review) AS review_count
FROM recipe r
LEFT JOIN review rv ON r.id_recipe = rv.recipe_id_recipe
GROUP BY r.id_recipe, r.title;

/* 5;4;1;recepty s průměrnou obtížností větší než 2 s vnějším spojením */
SELECT r.id_recipe, r.title, AVG(rv.rating) AS average_rating
FROM recipe r
LEFT JOIN review rv ON r.id_recipe = rv.recipe_id_recipe
WHERE r.difficulty > 2
GROUP BY r.id_recipe, r.title;

/* 6;1;3;recepty s nejvyšším průměrným hodnocením v každé kategorii */
SELECT rc.name AS category_name, r.id_recipe, r.title, MAX(avg_rating) AS average_rating
FROM recipe_category rc
JOIN recipe r ON rc.id_category = r.category_id_category
JOIN (
    SELECT recipe_id_recipe, AVG(rating) AS avg_rating
    FROM review
    GROUP BY recipe_id_recipe
) rv ON r.id_recipe = rv.recipe_id_recipe
GROUP BY rc.name, r.id_recipe, r.title;


/* 6;2;2;seznam uživatelů a počet jejich oblíbených receptů s průměrným hodnocením nad 4 */
SELECT u.id_user, u.name, COUNT(f.recipe_id_recipe) AS favorite_high_rated_recipes
FROM "User" u
JOIN favorite f ON u.id_user = f.user_id_user
JOIN (
    SELECT r.id_recipe
    FROM recipe r
    JOIN review rv ON r.id_recipe = rv.recipe_id_recipe
    GROUP BY r.id_recipe
    HAVING AVG(rv.rating) > 4
) AS high_rated_recipes ON f.recipe_id_recipe = high_rated_recipes.id_recipe
GROUP BY u.id_user, u.name;
