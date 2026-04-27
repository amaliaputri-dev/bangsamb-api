<?php
require_once 'config.php';

$user_id = $_POST['user_id'];
$sampah_id = $_POST['sampah_id'];
$berat = $_POST['berat'];

// Ambil harga sampah
$q_sampah = mysqli_query($conn, "SELECT * FROM sampah WHERE id = '$sampah_id'");
$sampah = mysqli_fetch_assoc($q_sampah);
$total_harga = $sampah['harga_perkg'] * $berat;

// Update saldo user
mysqli_query($conn, "UPDATE users SET saldo = saldo + $total_harga WHERE id = '$user_id'");

// Simpan transaksi
$ket = "Setor " . $sampah['nama_sampah'] . " ($berat kg)";
$query = "INSERT INTO transaksi (user_id, tipe, jumlah, keterangan) VALUES ('$user_id', 'setor', '$total_harga', '$ket')";

if (mysqli_query($conn, $query)) {
    response(true, "Setor sampah berhasil");
} else {
    response(false, "Gagal memproses transaksi");
}
?>