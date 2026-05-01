-- Добавление полей для авторизации в существующую таблицу application
-- (игнорирует ошибку, если поле уже существует)

ALTER TABLE application 
  ADD COLUMN IF NOT EXISTS login VARCHAR(32) UNIQUE AFTER agreement;

ALTER TABLE application 
  ADD COLUMN IF NOT EXISTS password_hash VARCHAR(255) AFTER login;

-- Создание таблицы языков программирования (если нет)
CREATE TABLE IF NOT EXISTS programming_language (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Создание связующей таблицы (если нет)
CREATE TABLE IF NOT EXISTS application_language (
    id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT NOT NULL,
    language_id INT NOT NULL,
    FOREIGN KEY (application_id) REFERENCES application(id) ON DELETE CASCADE,
    FOREIGN KEY (language_id) REFERENCES programming_language(id) ON DELETE CASCADE,
    UNIQUE KEY unique_app_lang (application_id, language_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Заполнение списка языков (игнорирует дубликаты)
INSERT IGNORE INTO programming_language (name) VALUES
('PHP'), ('Python'), ('Java'), ('JavaScript'), ('C++'), ('C#'), ('Ruby'), ('Go');
