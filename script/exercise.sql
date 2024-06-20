DROP DATABASE IF EXISTS mybd;
CREATE DATABASE mybd;
\c mybd;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    login VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
		name TEXT
);

CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    text TEXT
);

INSERT INTO users (login, password, name) VALUES ('user1', 'user1pas', 'Jhon'), ('user2', 'user2pas', NULL); 

INSERT INTO messages (user_id, text) VALUES (1, 'Message 1 from user 1'),(1, 'Message 2 from user 1'),(1, 'Message 3 from user 1'),(2, 'Message 1 from user 2'),(2, 'Message 2 from user 2');

UPDATE users SET password = 'newpas' WHERE login = 'user1';

DELETE FROM messages WHERE id = 1;

SELECT * FROM messages m
JOIN users u ON u.id=m.user_id
WHERE login= 'user2';

DELETE FROM users WHERE login = 'user1';

EXPLAIN SELECT * FROM messages m
JOIN users u ON u.id=m.user_id
WHERE login= 'user2';


CREATE INDEX user_id_index ON messages(user_id);
CREATE INDEX login_index ON users(login);

EXPLAIN SELECT * FROM messages m
JOIN users u ON u.id=m.user_id
WHERE login= 'user2';