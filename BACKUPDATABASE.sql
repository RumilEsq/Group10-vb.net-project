CREATE DATABASE IF NOT EXISTS onlinedonation_charity;
USE onlinedonation_charity;

CREATE TABLE roles (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    role_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(200) NOT NULL,
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE TABLE beneficiaries (
    beneficiary_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    bio TEXT,
    needs TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE campaigns (
    campaign_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    goal_amount DECIMAL(10, 2) NOT NULL,
    current_amount DECIMAL(10, 2) DEFAULT 0,
    start_date DATE,
    end_date DATE,
    is_active BIT DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE payment_methods (
    payment_method_id INT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL
);

CREATE TABLE donations (
    donation_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    campaign_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method_id INT NOT NULL,
    donation_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_methods(payment_method_id)
);


CREATE TABLE campaign_updates (
    update_id INT PRIMARY KEY,
    campaign_id INT NOT NULL,
    update_text TEXT,
    update_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id)
);


CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    campaign_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    feedback_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id)
);
