<?php
class Quest {
    private $pdo;

    public function __construct($pdo) {
        $this->pdo = $pdo;
    }

    public function getAll() {
        $stmt = $this->pdo->query("SELECT * FROM quests ORDER BY id");
        return $stmt->fetchAll();
    }

    public function findById($id) {
        $stmt = $this->pdo->prepare("SELECT * FROM quests WHERE id = ?");
        $stmt->execute([$id]);
        return $stmt->fetch();
    }
}