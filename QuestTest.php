<?php
// tests/QuestTest.php

use PHPUnit\Framework\TestCase;

// Подключаем зависимости
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../models/Quest.php';
require_once __DIR__ . '/../models/Step.php';
require_once __DIR__ . '/../models/Session.php';

class QuestTest extends TestCase
{
    private $pdo;

    protected function setUp(): void
    {
        // Используем глобальное подключение из config/database.php
        $this->pdo = $GLOBALS['pdo'];
    }

    /**
     * Тест: проверка, что загружаются оба квеста
     */
    public function testQuestsAreLoaded()
    {
        $questModel = new Quest($this->pdo);
        $quests = $questModel->getAll();

        $this->assertIsArray($quests);
        $this->assertCount(2, $quests);
        $this->assertEquals('Кольб и дракон', $quests[0]['title']);
        $this->assertEquals('Голос из подвала', $quests[1]['title']);
    }

    /**
     * Тест: загрузка первого шага квеста "Кольб и дракон"
     */
    public function testFirstStepOfKolbLoads()
    {
        $stepModel = new Step($this->pdo);
        $questModel = new Quest($this->pdo);
        $quest = $questModel->findById(1); // ID квеста "Кольб"

        $this->assertNotNull($quest);

        $step = $stepModel->findByQuestAndPage(1, 1); // quest_id=1, page=1
        $this->assertNotNull($step);
        $this->assertFalse($step['is_final']);
        $this->assertStringContainsString('Кольб был храбрым нордом', $step['content']);
    }

    /**
     * Тест: загрузка выборов для первого шага
     */
    public function testChoicesForFirstStepAreLoaded()
    {
        $stepModel = new Step($this->pdo);
        $choices = $stepModel->getChoices(1); // ID шага = 1

        $this->assertIsArray($choices);
        $this->assertCount(1, $choices);
        $this->assertEquals('Перейти на страницу (2)', $choices[0]['text']);
    }

    /**
     * Тест: создание игровой сессии
     */
    public function testSessionCreation()
    {
        $session_id = 'test_session_' . time();
        $sessionModel = new Session($this->pdo);

        // Создаём сессию: quest_id=1, step_id=1
        $sessionModel->create($session_id, 1, 1);

        // Проверяем, что сессия сохранена
        $saved = $sessionModel->findBySessionId($session_id);
        $this->assertNotNull($saved);
        $this->assertEquals(1, $saved['quest_id']);
        $this->assertEquals(1, $saved['current_step_id']);
    }

    /**
     * Тест: шаг "КОНЕЦ" помечен как финальный
     */
    public function testFinalStepIsMarkedCorrectly()
    {
        $stepModel = new Step($this->pdo);
        // Шаг 6 — финал Кольба
        $finalStep = $stepModel->findById(6);

        $this->assertNotNull($finalStep);
        $this->assertTrue($finalStep['is_final']);
        $this->assertStringContainsString('Кольб вернулся домой с победой', $finalStep['content']);
    }
}