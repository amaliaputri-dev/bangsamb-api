<?php
require_once 'config.php';
$user_id = $_POST['user_id'];
$kode_qr = $_POST['kode_qr'];

// 1. Cari QR yang aktif
$q_qr = mysqli_query($conn, "SELECT * FROM qr_transaksi WHERE kode_qr = '$kode_qr' AND status = 'aktif'");
$qr = mysqli_fetch_assoc($q_qr);

if ($qr) {
    $jumlah = (int)$qr['jumlah'];
    $berat = (int)$qr['berat'];
    $ket = $qr['keterangan'];
    $tipe = trim($qr['tipe']); // Trim karena di dump ada spasi 'setor '

    // 2. Tandai QR sudah dipakai
    mysqli_query($conn, "UPDATE qr_transaksi SET status = 'dipakai' WHERE id = " . $qr['id']);

    // 3. Update Saldo (tabel saldo)
    mysqli_query($conn, "UPDATE saldo SET total_saldo = total_saldo + $jumlah WHERE user_id = $user_id");

    // 4. Catat Transaksi
    mysqli_query($conn, "INSERT INTO transaksi (user_id, tipe, jumlah, berat, keterangan, status) 
                         VALUES ($user_id, 'setor', $jumlah, $berat, '$ket', 'berhasil')");

    response(true, "Setor $ket senilai Rp $jumlah berhasil!");
} else {
    response(false, "QR Code tidak valid atau sudah kadaluarsa");
}
?>