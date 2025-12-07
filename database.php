<?php
// config/database.php

// В Docker переменные окружения заданы, но на случай локального запуска — дефолты
$host = $_ENV['DB_HOST'] ?? 'db';      // ← КРИТИЧНО: 'db', а не 'localhost'
$db   = $_ENV['DB_NAME'] ?? 'online_quest';
$user = $_ENV['DB_USER'] ?? 'postgres';
$pass = $_ENV['DB_PASS'] ?? 'quest123';

$dsn = "pgsql:host=$host;dbname=$db";

$pdo = new PDO($dsn, $user, $pass, [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
    PDO::PGSQL_ATTR_DISABLE_PREPARES => true
]);