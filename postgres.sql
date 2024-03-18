-- Створення таблиці users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    fullname VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

-- Створення таблиці status
CREATE TABLE status (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE
);

-- Створення таблиці tasks
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    description TEXT,
    status_id INTEGER,
    user_id INTEGER,
    FOREIGN KEY (status_id) REFERENCES status(id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


SELECT * FROM tasks WHERE user_id = 1;
Оновити статус конкретного завдання
sql
Copy code
UPDATE tasks SET status_id = (SELECT id FROM status WHERE name = 'in progress') WHERE id = 5;
Додати нове завдання для конкретного користувача
sql
Copy code
INSERT INTO tasks (title, description, status_id, user_id) VALUES ('Нове завдання', 'Опис нового завдання', 1, 2);
Отримати список користувачів, які не мають жодного завдання
sql
Copy code
SELECT * FROM users WHERE id NOT IN (SELECT user_id FROM tasks);
Отримати кількість завдань для кожного статусу
sql
Copy code
SELECT status.name, COUNT(tasks.id) FROM status LEFT JOIN tasks ON status.id = tasks.
