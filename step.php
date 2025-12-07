<h1><?= htmlspecialchars($quest['title']) ?></h1>
<div class="content">
    <p><?= nl2br(htmlspecialchars($step['content'])) ?></p>
</div>

<div class="choices">
    <?php foreach ($choices as $choice): ?>
        <a href="/?action=choose&choice_id=<?= (int)$choice['id'] ?>" class="btn">
            <?= htmlspecialchars($choice['text']) ?>
        </a>
    <?php endforeach; ?>
</div>

<p>
    <a href="/?action=reset" class="btn" style="background:#ffecec; border-color:#c00;">Начать заново</a>
</p>