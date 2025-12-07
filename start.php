<h1>Выберите приключение</h1>
<p>Добро пожаловать в мир онлайн-квестов! Выберите один из доступных сюжетов:</p>

<?php foreach ($quests as $quest): ?>
    <p>
        <strong><?= htmlspecialchars($quest['title']) ?></strong><br>
        <?= htmlspecialchars($quest['description']) ?><br>
        <a href="/?action=start&quest_id=<?= (int)$quest['id'] ?>" class="btn">Начать</a>
    </p>
<?php endforeach; ?>