-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 27 Apr 2026 pada 09.38
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bangsamb_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_sampah`
--

CREATE TABLE `jenis_sampah` (
  `id` int(11) NOT NULL,
  `nama_sampah` varchar(50) NOT NULL,
  `harga_perkg` int(11) NOT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `jenis_sampah`
--

INSERT INTO `jenis_sampah` (`id`, `nama_sampah`, `harga_perkg`, `barcode`, `created_at`) VALUES
(1, 'Plastik PET', 3000, '899123456001', '2026-03-11 05:14:03'),
(2, 'Kertas/Kardus', 1500, '899123456002', '2026-03-11 05:14:03'),
(3, 'Logam/Besi', 5000, '899123456003', '2026-03-11 05:14:03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penarikan`
--

CREATE TABLE `penarikan` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `jumlah` int(11) NOT NULL,
  `status` enum('pending','success','failed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `qr_transaksi`
--

CREATE TABLE `qr_transaksi` (
  `id` int(11) NOT NULL,
  `kode_qr` varchar(50) DEFAULT NULL,
  `tipe` varchar(20) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `berat` int(11) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `status` varchar(20) DEFAULT 'aktif',
  `expired_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `qr_transaksi`
--

INSERT INTO `qr_transaksi` (`id`, `kode_qr`, `tipe`, `jumlah`, `berat`, `keterangan`, `status`, `expired_at`, `created_at`) VALUES
(1, 'TRX62842', 'setor', 10000, 1, 'kayu', 'aktif', '2026-03-11 13:03:38', '2026-03-11 11:58:38'),
(4, 'TRX97300', 'setor', 20000, 3, 'besi', 'aktif', '2026-03-11 13:18:18', '2026-03-11 12:13:18'),
(5, 'TRX52903', 'setor ', 15000, 3, 'plastik', 'dipakai', '2026-03-11 13:18:33', '2026-03-11 12:13:33'),
(6, 'TRX75178', 'setor ', 15000, 3, 'plastik', 'aktif', '2026-03-11 13:21:40', '2026-03-11 12:16:40'),
(7, 'TRX49683', 'setor ', 30000, 2, 'kayu', 'dipakai', '2026-03-11 13:21:53', '2026-03-11 12:16:53'),
(8, 'TRX36161', 'setor ', 10000, 2, 'kertas', 'aktif', '2026-03-11 18:18:02', '2026-03-11 17:13:02'),
(9, 'TRX90485', 'setor', 15000, 2, 'botol', 'dipakai', '2026-03-11 18:34:03', '2026-03-11 17:29:03'),
(10, 'TRX44992', 'setor', 5000, 2, 'lilin', 'dipakai', '2026-03-11 18:40:43', '2026-03-11 17:35:43'),
(11, 'TRX57523', 'setor', 10000, 1, 'plastik', 'dipakai', '2026-03-11 18:49:08', '2026-03-11 17:44:08'),
(12, 'TRX21822', 'setor', 50000, 2, 'besi', 'dipakai', '2026-03-11 18:51:53', '2026-03-11 17:46:53'),
(13, 'TRX87556', 'setor', 40000, 3, 'logam', 'dipakai', '2026-03-12 03:43:50', '2026-03-12 02:38:50'),
(14, 'TRX31444', 'setor', 25000, 3, 'besi', 'dipakai', '2026-03-12 05:24:17', '2026-03-12 04:19:17'),
(15, 'TRX68233', 'setor', 8000, 2, 'logam', 'aktif', '2026-04-23 07:06:25', '2026-04-23 05:01:25');

-- --------------------------------------------------------

--
-- Struktur dari tabel `saldo`
--

CREATE TABLE `saldo` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `total_saldo` int(11) DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `saldo`
--

INSERT INTO `saldo` (`id`, `user_id`, `total_saldo`, `updated_at`) VALUES
(1, 3, 0, '2026-03-11 08:25:01'),
(2, 4, 145000, '2026-03-12 04:19:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `setoran`
--

CREATE TABLE `setoran` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `jenis_sampah_id` int(11) DEFAULT NULL,
  `berat` float NOT NULL,
  `total` int(11) NOT NULL,
  `status` enum('pending','verified','rejected') DEFAULT 'pending',
  `petugas_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tipe` enum('setor','tarik') NOT NULL,
  `jumlah` int(11) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'berhasil',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `berat` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id`, `user_id`, `tipe`, `jumlah`, `keterangan`, `status`, `created_at`, `berat`) VALUES
(1, 4, 'setor', 30000, 'kayu', 'berhasil', '2026-03-11 12:16:55', 2),
(2, 4, 'setor', 15000, 'botol', 'berhasil', '2026-03-11 17:33:44', 2),
(3, 4, 'setor', 5000, 'lilin', 'berhasil', '2026-03-11 17:35:47', 2),
(4, 4, 'setor', 10000, 'plastik', 'berhasil', '2026-03-11 17:44:11', 1),
(5, 4, 'setor', 50000, 'besi', 'berhasil', '2026-03-11 17:46:58', 2),
(6, 4, 'setor', 40000, 'logam', 'berhasil', '2026-03-12 02:38:58', 3),
(7, 4, 'setor', 25000, 'besi', 'berhasil', '2026-03-12 04:19:24', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','petugas','nasabah') DEFAULT 'nasabah',
  `alamat` text DEFAULT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `qr_code` varchar(100) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `nama`, `email`, `password`, `role`, `alamat`, `no_hp`, `qr_code`, `foto`, `created_at`) VALUES
(1, 'Admin BangSamb', 'admin@mail.com', 'admin123', 'admin', NULL, NULL, NULL, NULL, '2026-03-11 05:14:03'),
(2, 'Petugas Satu', 'petugas@mail.com', 'petugas123', 'petugas', NULL, NULL, NULL, NULL, '2026-03-11 05:14:03'),
(3, 'Fari Kurniawan ', 'yuukaamalia@gmail.com', '$2y$10$nZzv3lHenpPAj.6JY1EVxONKX.ZCT746ne6Gh5UFx2RdjLAYi4wU6', 'nasabah', 'bantargebang ', '085659838069', NULL, NULL, '2026-03-11 08:25:01'),
(4, 'Fari Kurniawan ', 'farikurniawan201@gmail.com', 'fari123', 'nasabah', 'bekasi', '082129374933', NULL, 'http://178.128.10.209/bangsamb_api/uploads/profile_4_1773289442.jpg', '2026-03-11 08:29:12');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `penarikan`
--
ALTER TABLE `penarikan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `qr_transaksi`
--
ALTER TABLE `qr_transaksi`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `saldo`
--
ALTER TABLE `saldo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `setoran`
--
ALTER TABLE `setoran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `jenis_sampah_id` (`jenis_sampah_id`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `penarikan`
--
ALTER TABLE `penarikan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `qr_transaksi`
--
ALTER TABLE `qr_transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `saldo`
--
ALTER TABLE `saldo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `setoran`
--
ALTER TABLE `setoran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `penarikan`
--
ALTER TABLE `penarikan`
  ADD CONSTRAINT `penarikan_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `saldo`
--
ALTER TABLE `saldo`
  ADD CONSTRAINT `saldo_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `setoran`
--
ALTER TABLE `setoran`
  ADD CONSTRAINT `setoran_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `setoran_ibfk_2` FOREIGN KEY (`jenis_sampah_id`) REFERENCES `jenis_sampah` (`id`);

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
