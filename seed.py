from faker import Faker
import psycopg2
import random

faker = Faker()

# Підключення до вашої PostgreSQL бази даних
conn = psycopg2.connect(dbname="ave", user="postgres", password="pass")
cur = conn.cursor()

# Створення випадкових статусів
status_names = ['new', 'in progress', 'completed']
for name in status_names:
    cur.execute("INSERT INTO status (name) VALUES (%s)", (name,))

# Створення випадкових користувачів
for _ in range(10):
    fullname = faker.name()
    email = faker.email()
    cur.execute("INSERT INTO users (fullname, email) VALUES (%s, %s)", (fullname, email))

# Створення випадкових завдань
for _ in range(20):
    title = faker.sentence()
    description = faker.text()
    status_id = random.randint(1, 3)
    user_id = random.randint(1, 10)
    cur.execute("INSERT INTO tasks (title, description, status_id, user_id) VALUES (%s, %s, %s, %s)", (title, description, status_id, user_id))

conn.commit()
cur.close()
conn.close()
