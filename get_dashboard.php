<?php
require_once 'config.php';

$user_id = isset($_GET['user_id']) ? (int)$_GET['user_id'] : 0;

if ($user_id <= 0) {
    response(false, "User ID tidak valid");
    exit;
}

// 1. Ambil Saldo
$q_saldo = mysqli_query($conn, "SELECT total_saldo FROM saldo WHERE user_id = $user_id");
$total_saldo = 0;
if ($q_saldo && mysqli_num_rows($q_saldo) > 0) {
    $s = mysqli_fetch_assoc($q_saldo);
    $total_saldo = (int)$s['total_saldo'];
}

// 2. Ambil Statistik User (Total Transaksi & Berat)
$q_stats = mysqli_query($conn, "SELECT COUNT(*) as total_trans, COALESCE(SUM(berat),0) as total_berat FROM transaksi WHERE user_id = $user_id AND tipe = 'setor'");
$stats = mysqli_fetch_assoc($q_stats);

// 3. Ambil Data Chart (7 Hari Terakhir)
$chart_data = [];
$q_chart = mysqli_query($conn, "SELECT DATE(created_at) as tgl, SUM(berat) as total FROM transaksi WHERE user_id = $user_id AND tipe = 'setor' GROUP BY DATE(created_at) ORDER BY tgl ASC LIMIT 7");
while($row = mysqli_fetch_assoc($q_chart)) {
    $chart_data[] = ["tgl" => $row['tgl'], "total" => (float)$row['total']];
}

// 4. Ambil Top 5 Ranking Nasabah
$ranking_nasabah = [];
$q_rank_list = mysqli_query($conn, "SELECT u.nama, SUM(t.berat) as total_berat FROM users u JOIN transaksi t ON u.id = t.user_id WHERE t.tipe = 'setor' GROUP BY u.id ORDER BY total_berat DESC LIMIT 5");
while($row = mysqli_fetch_assoc($q_rank_list)) {
    $ranking_nasabah[] = ["nama" => $row['nama'], "total_berat" => (float)$row['total_berat']];
}

// 5. Hitung Rank User Saat Ini
$q_rank = mysqli_query($conn, "SELECT posisi FROM (SELECT user_id, RANK() OVER (ORDER BY SUM(berat) DESC) as posisi FROM transaksi WHERE tipe = 'setor' GROUP BY user_id) as lb WHERE user_id = $user_id");
$rank = 0;
if ($q_rank && mysqli_num_rows($q_rank) > 0) {
    $r = mysqli_fetch_assoc($q_rank);
    $rank = (int)$r['posisi'];
}
if ($rank == 0) {
    $q_total = mysqli_query($conn, "SELECT COUNT(*) as total FROM users WHERE role='nasabah'");
    $rank = (int)mysqli_fetch_assoc($q_total)['total'];
}

$data = [
    "saldo" => $total_saldo,
    "total_transaksi" => (int)$stats['total_trans'],
    "total_sampah_kg" => (float)$stats['total_berat'],
    "rank" => $rank,
    "poin" => (int)($total_saldo / 100),
    "chart_data" => $chart_data,
    "ranking_nasabah" => $ranking_nasabah
];

response(true, "Data dashboard berhasil diambil", $data);
?>