CREATE TABLE `spotify_system` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `url` varchar(90) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `spotify_system`
ADD PRIMARY KEY (`id`);

ALTER TABLE `spotify_system`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;
