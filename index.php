<?php
// public/index.php

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../controllers/QuestController.php';

$controller = new QuestController($pdo);

$action = $_GET['action'] ?? null;

if ($action === 'start' && isset($_GET['quest_id'])) {
    $controller->startQuest((int)$_GET['quest_id']);
} elseif ($action === 'choose' && isset($_GET['choice_id'])) {
    $controller->handleChoice((int)$_GET['choice_id']);
} elseif ($action === 'reset') {
    $controller->reset();
} else {
    $controller->showStartOrStep();
}