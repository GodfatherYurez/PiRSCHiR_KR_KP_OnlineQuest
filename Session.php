<?php
class Session {
    private $pdo;

    public function __construct($pdo) {
        $this->pdo = $pdo;
    }

    public function create($session_id, $quest_id, $step_id) {
        $stmt = $this->pdo->prepare("
            INSERT INTO sessions (id, quest_id, current_step_id)
            VALUES (?, ?, ?)
        ");
        $stmt->execute([$session_id, $quest_id, $step_id]);
    }

    public function findBySessionId($session_id) {
        $stmt = $this->pdo->prepare("SELECT * FROM sessions WHERE id = ?");
        $stmt->execute([$session_id]);
        return $stmt->fetch();
    }

    public function updateCurrentStep($session_id, $new_step_id) {
        $stmt = $this->pdo->prepare("
            UPDATE sessions
            SET current_step_id = ?, updated_at = NOW()
            WHERE id = ?
        ");
        $stmt->execute([$new_step_id, $session_id]);
    }
}