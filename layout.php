<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Онлайн-квест</title>
    <link rel="stylesheet" href="/style.css">
</head>
<body>

<?php
// Определяем, какой шаблон подключить
if (isset($quests)) {
    // Стартовая страница: выбор квеста
    include __DIR__ . '/start.php';
} elseif (isset($step)) {
    // Игровой процесс
    if ($step['is_final']) {
        include __DIR__ . '/final.php';
    } else {
        include __DIR__ . '/step.php';
    }
} else {
    echo "<p>Произошла ошибка. Вернитесь на <a href='/'>главную</a>.</p>";
}
?>

</body>
</html>