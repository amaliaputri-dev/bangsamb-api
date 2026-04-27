<?php
require_once 'config.php';
$email = $_POST['email'];
$password = $_POST['password'];

// Join dengan tabel saldo untuk mendapatkan total_saldo
$query = mysqli_query($conn, "SELECT u.*, IFNULL(s.total_saldo, 0) as saldo 
                             FROM users u 
                             LEFT JOIN saldo s ON u.id = s.user_id 
                             WHERE u.email = '$email'");
$user = mysqli_fetch_assoc($query);

if ($user) {
    // Mengecek password (mendukung plain text seperti di dump atau hash)
    if (password_verify($password, $user['password']) || $password == $user['password']) {
        unset($user['password']);
        $user['id'] = (int)$user['id'];
        $user['saldo'] = (int)$user['saldo'];
        response(true, "Login berhasil", $user);
    } else {
        response(false, "Password salah");
    }
} else {
    response(false, "Email tidak terdaftar");
}
?>