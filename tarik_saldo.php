<?php
require_once 'config.php';

$user_id = $_POST['user_id'];
$jumlah = $_POST['jumlah'];

$q_user = mysqli_query($conn, "SELECT saldo FROM users WHERE id = '$user_id'");
$user = mysqli_fetch_assoc($q_user);

if ($user['saldo'] < $jumlah) {
    response(false, "Saldo tidak mencukupi");
} else {
    mysqli_query($conn, "UPDATE users SET saldo = saldo - $jumlah WHERE id = '$user_id'");
    mysqli_query($conn, "INSERT INTO transaksi (user_id, tipe, jumlah, keterangan) VALUES ('$user_id', 'tarik', '$jumlah', 'Penarikan saldo')");
    response(true, "Penarikan saldo berhasil");
}
?>