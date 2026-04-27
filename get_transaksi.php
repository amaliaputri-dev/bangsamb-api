<?php
require_once 'config.php';
$user_id = $_GET['user_id'];

$query = mysqli_query($conn, "SELECT * FROM transaksi WHERE user_id = '$user_id' ORDER BY created_at DESC");
$list = [];
while($row = mysqli_fetch_assoc($query)) {
    $row['id'] = (int)$row['id'];
    $row['user_id'] = (int)$row['user_id'];
    $row['jumlah'] = (int)$row['jumlah'];
    $list[] = $row;
}
response(true, "Data transaksi ditemukan", $list);
?>