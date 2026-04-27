<?php
require_once 'config.php';

$user_id = $_POST['user_id'];
$target_dir = "uploads/";
if (!file_exists($target_dir)) mkdir($target_dir, 0777, true);

$file_name = "profile_" . $user_id . "_" . time() . ".jpg";
$target_file = $target_dir . $file_name;

if (move_uploaded_file($_FILES["foto"]["tmp_name"], $target_file)) {
    // Alamat IP Laptop Anda (Sesuaikan!)
    $url_foto = "http://192.168.1.6/bangsamb_api/" . $target_file;
    
    mysqli_query($conn, "UPDATE users SET foto = '$url_foto' WHERE id = '$user_id'");
    
    $q = mysqli_query($conn, "SELECT u.*, s.total_saldo as saldo FROM users u LEFT JOIN saldo s ON u.id = s.user_id WHERE u.id = '$user_id'");
    $user = mysqli_fetch_assoc($q);
    unset($user['password']);
    
    response(true, "Berhasil", $user);
} else {
    response(false, "Gagal simpan file");
}
?>