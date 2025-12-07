<h1><?= htmlspecialchars($quest['title']) ?></h1>
<div class="content">
    <p><?= nl2br(htmlspecialchars($step['content'])) ?></p>
</div>

<h2>КОНЕЦ</h2>

<p>
    <a href="/?action=reset" class="btn">Начать заново</a>
</p>