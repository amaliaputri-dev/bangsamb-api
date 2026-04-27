<?php
$conn = mysqli_connect("localhost", "root", "", "bangsamb_db");
header('Content-Type: application/json');

function response($status, $message, $data = null) {
    echo json_encode([
        "status" => (bool)$status,
        "message" => $message,
        "data" => $data
    ]);
    exit;
}
?>