<?php
require_once 'config.php';

$nama = $_POST['nama'];
$email = $_POST['email'];
$password = password_hash($_POST['password'], PASSWORD_DEFAULT);
$alamat = $_POST['alamat'];
$no_hp = $_POST['no_hp'];

$checkEmail = mysqli_query($conn, "SELECT * FROM users WHERE email = '$email'");

if (mysqli_num_rows($checkEmail) > 0) {
    echo json_encode(["status" => "error", "message" => "Email sudah terdaftar"]);
} else {
    $query = "INSERT INTO users (nama, email, password, alamat, no_hp, saldo) VALUES ('$nama', '$email', '$password', '$alamat', '$no_hp', 0)";
    if (mysqli_query($conn, $query)) {
        echo json_encode(["status" => "success", "message" => "Registrasi berhasil"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Registrasi gagal"]);
    }
}
?>