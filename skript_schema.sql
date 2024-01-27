CREATE TABLE recipe_category (
    id_category INTEGER NOT NULL,
    name        VARCHAR(30) NOT NULL,
    description VARCHAR(200) NOT NULL
);
ALTER TABLE recipe_category ADD CONSTRAINT category_pk PRIMARY KEY (id_category);

CREATE TABLE cookingstep (
    id_step          INTEGER NOT NULL,
    step_number      INTEGER NOT NULL,
    step_description VARCHAR(250) NOT NULL,
    img_url          VARCHAR(255),
    created_at       DATE NOT NULL,
    updated_at       DATE NOT NULL,
    recipe_id_recipe INTEGER NOT NULL
);
ALTER TABLE cookingstep ADD CONSTRAINT cookingstep_pk PRIMARY KEY (id_step);

CREATE TABLE favorite (
    created_at       DATE NOT NULL,
    updated_at       DATE NOT NULL,
    user_id_user     INTEGER NOT NULL,
    recipe_id_recipe INTEGER NOT NULL
);
ALTER TABLE favorite ADD CONSTRAINT favorite_pk PRIMARY KEY (user_id_user, recipe_id_recipe);

CREATE TABLE ingredient (
    id_ingredient INTEGER NOT NULL,
    name          VARCHAR(30) NOT NULL,
    description   VARCHAR(200) NOT NULL
);
ALTER TABLE ingredient ADD CONSTRAINT ingredient_pk PRIMARY KEY (id_ingredient);

CREATE TABLE recipe (
    id_recipe            INTEGER NOT NULL,
    title                VARCHAR(30) NOT NULL,
    description          VARCHAR(250) NOT NULL,
    preparation_time     INTEGER NOT NULL,
    difficulty           INTEGER NOT NULL CHECK (difficulty BETWEEN 1 AND 3),
    created_at           DATE NOT NULL,
    updated_at           DATE NOT NULL,
    user_id_user         INTEGER NOT NULL,
    category_id_category INTEGER NOT NULL
);
ALTER TABLE recipe ADD CONSTRAINT recipe_pk PRIMARY KEY (id_recipe);


CREATE TABLE recipeingredientdetail (
    quantity                 VARCHAR(50) NOT NULL,
    recipe_id_recipe         INTEGER NOT NULL,
    ingredient_id_ingredient INTEGER NOT NULL
);
ALTER TABLE recipeingredientdetail ADD CONSTRAINT rid_pk PRIMARY KEY (recipe_id_recipe, ingredient_id_ingredient);


CREATE TABLE review (
    id_review        INTEGER NOT NULL,
    rating           INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment			 VARCHAR(200) NOT NULL,
    created_at       DATE NOT NULL,
    updated_at       DATE NOT NULL,
    user_id_user     INTEGER NOT NULL,
    recipe_id_recipe INTEGER NOT NULL
);
ALTER TABLE review ADD CONSTRAINT review_pk PRIMARY KEY (id_review);

CREATE TABLE "User" (
    id_user    INTEGER NOT NULL,
    email      VARCHAR(50) NOT NULL,
    name       VARCHAR(20) NOT NULL,
    surname    VARCHAR(20) NOT NULL,
    city       VARCHAR(20) NOT NULL,
    country    VARCHAR(30) NOT NULL,
    phone      VARCHAR(12),
    role       CHAR(1) NOT NULL CHECK (role IN ('A', 'R', 'U')),
    password   VARCHAR(16) NOT NULL,
    deleted_at DATE,
    created_at DATE NOT NULL,
    visited_at DATE NOT NULL
);
ALTER TABLE "User" ADD CONSTRAINT user_pk PRIMARY KEY (id_user);


ALTER TABLE cookingstep
    ADD CONSTRAINT cookingstep_recipe_fk FOREIGN KEY (recipe_id_recipe)
        REFERENCES recipe (id_recipe);

ALTER TABLE favorite
    ADD CONSTRAINT favorite_recipe_fk FOREIGN KEY (recipe_id_recipe)
        REFERENCES recipe (id_recipe);

ALTER TABLE favorite
    ADD CONSTRAINT favorite_user_fk FOREIGN KEY (user_id_user)
        REFERENCES "User" (id_user);

ALTER TABLE recipe
    ADD CONSTRAINT recipe_category_fk FOREIGN KEY (category_id_category)
        REFERENCES recipe_category (id_category);

ALTER TABLE recipe
    ADD CONSTRAINT recipe_user_fk FOREIGN KEY (user_id_user)
        REFERENCES "User" (id_user);

ALTER TABLE recipeingredientdetail
    ADD CONSTRAINT rid_ingredient_fk FOREIGN KEY (ingredient_id_ingredient)
        REFERENCES ingredient (id_ingredient);

ALTER TABLE recipeingredientdetail
    ADD CONSTRAINT rid_recipe_fk FOREIGN KEY (recipe_id_recipe)
        REFERENCES recipe (id_recipe);

ALTER TABLE review
    ADD CONSTRAINT review_recipe_fk FOREIGN KEY (recipe_id_recipe)
        REFERENCES recipe (id_recipe);

ALTER TABLE review
    ADD CONSTRAINT review_user_fk FOREIGN KEY (user_id_user)
        REFERENCES "User" (id_user);
