<?php
require_once __DIR__ . '/../models/Quest.php';
require_once __DIR__ . '/../models/Step.php';
require_once __DIR__ . '/../models/Session.php';

class QuestController {
    private $pdo;
    private $questModel;
    private $stepModel;
    private $sessionModel;

    public function __construct($pdo) {
        $this->pdo = $pdo;
        $this->questModel = new Quest($pdo);
        $this->stepModel = new Step($pdo);
        $this->sessionModel = new Session($pdo);
    }

    // Главная страница: список квестов или текущий шаг
    public function showStartOrStep() {
        $session_id = $_COOKIE['session_id'] ?? null;

        if ($session_id) {
            // Есть активная сессия — показываем текущий шаг
            $session = $this->sessionModel->findBySessionId($session_id);
            if ($session) {
                $step = $this->stepModel->findById($session['current_step_id']);
                $choices = $this->stepModel->getChoices($step['id']);
                $quest = $this->questModel->findById($session['quest_id']);

                // Рендерим шаг
                require_once __DIR__ . '/../views/layout.php';
                return;
            }
        }

        // Нет сессии — показываем выбор квеста
        $quests = $this->questModel->getAll();
        require_once __DIR__ . '/../views/layout.php';
    }

    // Начать новый квест
    public function startQuest($quest_id) {
        $quest = $this->questModel->findById($quest_id);
        if (!$quest) {
            http_response_code(404);
            echo "Квест не найден";
            return;
        }

        // Находим начальный шаг (page_number = 1)
        $startStep = $this->stepModel->findByQuestAndPage($quest_id, 1);
        if (!$startStep) {
            http_response_code(500);
            echo "Начальный шаг не найден";
            return;
        }

        // Генерируем session_id
        $session_id = bin2hex(random_bytes(16));
        setcookie('session_id', $session_id, time() + 3600 * 24 * 30, '/');

        // Сохраняем в БД
        $this->sessionModel->create($session_id, $quest_id, $startStep['id']);

        // Редирект на текущий шаг
        header('Location: /');
        exit();
    }

    // Обработать выбор игрока
    public function handleChoice($choice_id) {
        $session_id = $_COOKIE['session_id'] ?? null;
        if (!$session_id) {
            header('Location: /');
            exit();
        }

        $session = $this->sessionModel->findBySessionId($session_id);
        if (!$session) {
            header('Location: /');
            exit();
        }

        // Получаем выбор по ID
        $stmt = $this->pdo->prepare("
            SELECT * FROM choices WHERE id = ?
        ");
        $stmt->execute([$choice_id]);
        $choice = $stmt->fetch();

        if (!$choice || $choice['from_step_id'] != $session['current_step_id']) {
            // Некорректный выбор — игнорируем
            header('Location: /');
            exit();
        }

        // Обновляем текущий шаг
        $this->sessionModel->updateCurrentStep($session_id, $choice['to_step_id']);

        header('Location: /');
        exit();
    }

    // Сброс сессии
    public function reset() {
        $session_id = $_COOKIE['session_id'] ?? null;
        if ($session_id) {
            // Удаляем сессию из БД (опционально)
            $stmt = $this->pdo->prepare("DELETE FROM sessions WHERE id = ?");
            $stmt->execute([$session_id]);
            setcookie('session_id', '', time() - 3600, '/');
        }
        header('Location: /');
        exit();
    }
}