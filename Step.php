<?php
class Step {
    private $pdo;

    public function __construct($pdo) {
        $this->pdo = $pdo;
    }

    public function findById($id) {
        $stmt = $this->pdo->prepare("SELECT * FROM steps WHERE id = ?");
        $stmt->execute([$id]);
        return $stmt->fetch();
    }

    public function findByQuestAndPage($quest_id, $page_number) {
        $stmt = $this->pdo->prepare("SELECT * FROM steps WHERE quest_id = ? AND page_number = ?");
        $stmt->execute([$quest_id, $page_number]);
        return $stmt->fetch();
    }

    public function getChoices($step_id) {
        $stmt = $this->pdo->prepare("
            SELECT c.*, s.page_number AS to_page
            FROM choices c
            JOIN steps s ON c.to_step_id = s.id
            WHERE c.from_step_id = ?
            ORDER BY c.id
        ");
        $stmt->execute([$step_id]);
        return $stmt->fetchAll();
    }
}