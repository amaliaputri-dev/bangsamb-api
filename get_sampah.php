<?php
require_once 'config.php';
$query = mysqli_query($conn, "SELECT * FROM jenis_sampah ORDER BY nama_sampah ASC");
$list = [];
while($row = mysqli_fetch_assoc($query)) {
    $row['id'] = (int)$row['id'];
    $row['harga_perkg'] = (int)$row['harga_perkg'];
    $list[] = $row;
}
response(true, "Berhasil", $list);
?>