-- phpMyAdmin SQL Dump
-- version 4.2.9
-- http://www.phpmyadmin.net
--
-- Время создания: Ноя 26 2014 г., 12:37
-- Версия сервера: 5.5.40
-- Версия PHP: 5.6.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `javatask2`
--
CREATE DATABASE IF NOT EXISTS `javatask2` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `javatask2`;

-- --------------------------------------------------------

--
-- Структура таблицы `affair`
--

DROP TABLE IF EXISTS `affair`;
CREATE TABLE IF NOT EXISTS `affair` (
`idAffair` int(10) NOT NULL,
  `idEmployee` int(10) NOT NULL,
  `idTechnology` int(10) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `affair`
--

INSERT INTO `affair` (`idAffair`, `idEmployee`, `idTechnology`) VALUES
(8, 2, 4),
(9, 2, 1),
(10, 2, 2),
(12, 3, 1),
(21, 10, 1),
(22, 5, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
`idEmployee` int(10) NOT NULL,
  `surname` varchar(30) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `marital_status` enum('single','married','divorced') DEFAULT NULL,
  `salary` int(10) DEFAULT NULL,
  `dob` date DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `employees`
--

INSERT INTO `employees` (`idEmployee`, `surname`, `name`, `gender`, `marital_status`, `salary`, `dob`) VALUES
(1, 'Абрамов', 'ААРОН', 'male', 'single', 10, '1889-01-01'),
(2, 'Авдеев', 'АБАЙ', 'male', 'married', 20, '1901-02-02'),
(3, 'Агафонов', 'АББАС', 'male', 'divorced', 30, '1902-03-03'),
(4, 'Аксёнов', 'АБДУЛЛА', 'male', 'single', 40, '1903-04-04'),
(5, 'Александров', 'АБЕЛЬ', 'male', 'married', 50, '1904-05-05'),
(6, 'Алексеев', 'АБЕЛЬ', 'male', 'divorced', 60, '1905-06-06'),
(7, 'Андреев', 'АБОВ', 'male', 'single', 70, '1906-07-07'),
(8, 'Анисимов', 'АБРАМ', 'male', 'married', 80, '1907-08-08'),
(9, 'Антонов', 'АБРЕК', 'male', 'divorced', 90, '1908-09-09'),
(10, 'Артемьев', 'АВАЗ', 'male', 'single', 100, '1909-10-10'),
(11, 'Архипов', 'АВВАКУМ', 'male', 'married', 110, '1910-11-11'),
(12, 'Афанасьев', 'АВГУСТ', 'male', 'divorced', 120, '1911-12-12'),
(13, 'Баранов', 'АВДЕЙ', 'male', 'single', 130, '1912-01-13'),
(14, 'Белов', 'АВДИЕВС', 'male', 'married', 140, '1913-02-14'),
(15, 'Белозёров', 'АВДИЙ', 'male', 'divorced', 150, '1914-03-15'),
(16, 'Белоусов', 'АВДОН', 'male', 'single', 160, '1915-04-16'),
(17, 'Беляев', 'АВЕНИР', 'male', 'married', 170, '1916-05-17'),
(18, 'Беляков', 'АВЕРКИЙ', 'male', 'divorced', 180, '1917-06-18'),
(19, 'Беспалов', 'АВЕРЬЯН', 'male', 'single', 190, '1918-07-19'),
(20, 'Бирюков', 'АВЕРЬЯН', 'male', 'married', 200, '1919-08-20'),
(21, 'Блинов', 'АВИВ', 'male', 'divorced', 210, '1920-09-21'),
(22, 'Блохин', 'АВИМ', 'male', 'single', 220, '1921-10-22'),
(23, 'Бобров', 'АВКСЕНТИЙ', 'male', 'married', 230, '1922-11-23'),
(24, 'Бобылёв', 'АВРЕЛИАН', 'male', 'divorced', 240, '1923-12-24'),
(25, 'Богданов', 'АВСЕЙ', 'male', 'single', 250, '1924-01-25'),
(26, 'Большаков', 'АВТАНДИЛ', 'male', 'married', 260, '1925-02-26'),
(27, 'Борисов', 'АВТОНОМ', 'male', 'divorced', 270, '1926-03-27'),
(28, 'Брагин', 'АВУНДИЙ', 'male', 'single', 280, '1927-04-28'),
(29, 'Буров', 'АГАП', 'male', 'married', 290, '1928-05-29'),
(30, 'Быков', 'АГАПИТ', 'male', 'divorced', 300, '1929-06-01'),
(31, 'Васильев', 'АГАТИЙ', 'male', 'single', 310, '1930-07-02'),
(32, 'Веселов', 'АГАФАНГЕЛ', 'male', 'married', 320, '1931-08-03'),
(33, 'Виноградов', 'АГАФОДОР', 'male', 'divorced', 330, '1932-09-04'),
(34, 'Вишняков', 'АГАФОН', 'male', 'single', 340, '1933-10-05'),
(35, 'Владимиров', 'АГАФОНИК', 'male', 'married', 350, '1934-11-06'),
(36, 'Власов', 'АГГЕЙ', 'male', 'divorced', 360, '1935-12-07'),
(37, 'Волков', 'АГЗАМ', 'male', 'single', 370, '1936-01-08'),
(38, 'Воробьёв', 'АГЛАИЙ', 'male', 'married', 380, '1937-02-09'),
(39, 'Воронов', 'АГЛЯМ', 'male', 'divorced', 390, '1938-03-10'),
(40, 'Воронцов', 'АГН', 'male', 'single', 400, '1939-04-11'),
(41, 'Гаврилов', 'АГЫР', 'male', 'married', 410, '1940-05-12'),
(42, 'Галкин', 'АДАМ', 'male', 'divorced', 420, '1941-06-13'),
(43, 'Герасимов', 'АДАТ', 'male', 'single', 430, '1942-07-14'),
(44, 'Голубев', 'АДИЛЬ', 'male', 'married', 440, '1943-08-15'),
(45, 'Горбачёв', 'АДИП', 'male', 'divorced', 450, '1944-09-16'),
(46, 'Горбунов', 'АДИС', 'male', 'single', 460, '1945-10-17'),
(47, 'Гордеев', 'АДОЛЬФ', 'male', 'married', 470, '1946-11-18'),
(48, 'Горшков', 'АДОНИС', 'male', 'divorced', 480, '1947-12-19'),
(49, 'Григорьев', 'АДРИАН', 'male', 'single', 490, '1948-01-20'),
(50, 'Гришин', 'АЗАД', 'male', 'married', 500, '1949-02-21'),
(51, 'Громов', 'АЗАЛЬ', 'male', 'divorced', 510, '1950-03-22'),
(52, 'Гуляев', 'АЗАМ', 'male', 'single', 520, '1951-04-23'),
(53, 'Гурьев', 'АЗАМАТ', 'male', 'married', 530, '1952-05-24'),
(54, 'Гусев', 'АЗАРИЙ', 'male', 'divorced', 540, '1953-06-25'),
(55, 'Гущин', 'АЗАТ', 'male', 'single', 550, '1954-07-26'),
(56, 'Давыдов', 'АЗИЗ', 'male', 'married', 560, '1955-08-27'),
(57, 'Данилов', 'АЗИМ', 'male', 'divorced', 570, '1956-09-28'),
(58, 'Дементьев', 'АЗХАР', 'male', 'single', 580, '1957-10-29'),
(59, 'Денисов', 'АЙБАТ', 'male', 'married', 590, '1958-11-01'),
(60, 'Дмитриев', 'АЙДАН', 'male', 'divorced', 600, '1959-12-02'),
(61, 'Доронин', 'АЙДАР', 'male', 'single', 610, '1960-01-03'),
(62, 'Дорофеев', 'АЙНУР', 'male', 'married', 620, '1961-02-04'),
(63, 'Дроздов', 'АЙРАМ', 'male', 'divorced', 630, '1962-03-05'),
(64, 'Дьячков', 'АЙРАТ', 'male', 'single', 640, '1963-04-06'),
(65, 'Евдокимов', 'АЙТУГАН', 'male', 'married', 650, '1964-05-07'),
(66, 'Евсеев', 'АКАКИЙ', 'male', 'divorced', 660, '1965-06-08'),
(67, 'Егоров', 'АКБАР', 'male', 'single', 670, '1966-07-09'),
(68, 'Елисеев', 'АКБАРС', 'male', 'married', 680, '1967-08-10'),
(69, 'Емельянов', 'АКДАМ', 'male', 'divorced', 690, '1968-09-11'),
(70, 'Ермаков', 'АКИЛА', 'male', 'single', 700, '1969-10-12'),
(71, 'Ершов', 'АКИМ', 'male', 'married', 710, '1970-11-13'),
(72, 'Ефимов', 'АКИМФИЙ', 'male', 'divorced', 720, '1971-12-14'),
(73, 'Ефремов', 'АКИНДИН', 'male', 'single', 730, '1972-01-15'),
(74, 'Жданов', 'АКИНФИЙ', 'male', 'married', 740, '1973-02-16'),
(75, 'Жуков', 'АКОП', 'male', 'divorced', 750, '1974-03-17'),
(76, 'Журавлёв', 'АКРАМ', 'male', 'single', 760, '1975-04-18'),
(77, 'Зайцев', 'АКСАЙ', 'male', 'married', 770, '1976-05-19'),
(78, 'Захаров', 'АКСЕНТИЙ', 'male', 'divorced', 780, '1977-06-20'),
(79, 'Зимин', 'АКУТИОН', 'male', 'single', 790, '1978-07-21'),
(80, 'Зиновьев', 'АЛАДДИН', 'male', 'married', 800, '1979-08-22'),
(81, 'Зуев', 'АЛАН', 'male', 'divorced', 810, '1980-09-23'),
(82, 'Зыков', 'АЛАР', 'male', 'single', 820, '1981-10-24'),
(83, 'Иванков', 'АЛЕКСАНДР', 'male', 'married', 830, '1982-11-25'),
(84, 'Иванов', 'АЛЕКСЕЙ', 'male', 'divorced', 840, '1983-12-26'),
(85, 'Игнатов', 'АЛЕН', 'male', 'single', 850, '1984-01-27'),
(86, 'Игнатьев', 'АЛИ', 'male', 'married', 860, '1985-02-28'),
(87, 'Ильин', 'АЛИМ', 'male', 'divorced', 870, '1986-03-29'),
(88, 'Исаев', 'АЛЛАР', 'male', 'single', 880, '1987-04-01'),
(89, 'Исаков', 'АЛМАЗ', 'male', 'married', 890, '1988-05-02'),
(90, 'Кабанов', 'АЛМАС', 'male', 'divorced', 900, '1989-06-03'),
(91, 'Казаков', 'АЛМОН', 'male', 'single', 910, '1990-07-04'),
(92, 'Калашников', 'АЛМОЧ', 'male', 'married', 920, '1991-08-05'),
(93, 'Калинин', 'АЛОНСО', 'male', 'divorced', 930, '1992-09-06'),
(94, 'Капустин', 'АЛЬБЕРТ', 'male', 'single', 940, '1993-10-07'),
(95, 'Карпов', 'АЛЬВАРЕС', 'male', 'married', 950, '1994-11-08'),
(96, 'Кириллов', 'АЛЬФАР', 'male', 'divorced', 960, '1995-12-09'),
(97, 'Киселёв', 'АЛЬФИНУР', 'male', 'single', 970, '1996-01-10'),
(98, 'Князев', 'АЛЬФИР', 'male', 'married', 980, '1997-02-11'),
(99, 'Ковалёв', 'АЛЬФОНСО', 'male', 'divorced', 990, '1998-03-12'),
(100, 'Козлов', 'АЛЬФРЕД', 'male', 'single', 1000, '1999-04-13'),
(101, 'Колесников', 'АМАДЕЙ', 'male', 'married', 1010, '2000-05-14'),
(102, 'Колобов', 'АМАДЕУС', 'male', 'divorced', 1020, '2001-06-15'),
(103, 'Комаров', 'АМАДИС', 'male', 'single', 1030, '2002-07-16'),
(104, 'Комиссаров', 'АМАЛЬ', 'male', 'married', 1040, '2003-08-17'),
(105, 'Кондратьев', 'АМАН', 'male', 'divorced', 1050, '2004-09-18'),
(106, 'Коновалов', 'АМАНДИН', 'male', 'single', 1060, '2005-10-19'),
(107, 'Кононов', 'АМАЯК', 'male', 'married', 1070, '2006-11-20'),
(108, 'Константинов', 'АМБРОСИЙ', 'male', 'divorced', 1080, '2007-12-21'),
(109, 'Копылов', 'АМВРОСИЙ', 'male', 'single', 1090, '2008-01-22'),
(110, 'Корнилов', 'АМИН', 'male', 'married', 1100, '2009-02-23'),
(111, 'Королёв', 'АМИР', 'male', 'divorced', 1110, '2010-03-24'),
(112, 'Костин', 'АМИРХАН', 'male', 'single', 1120, '2011-04-25'),
(113, 'Котов', 'АМОС', 'male', 'married', 1130, '2012-05-26'),
(114, 'Кошелев', 'АНАНИЙ', 'male', 'divorced', 1140, '2013-06-27'),
(115, 'Красильников', 'АНАС', 'male', 'single', 1150, '2014-07-28'),
(116, 'Крылов', 'АНАСТАСИЙ', 'male', 'married', 1160, '2015-08-29'),
(117, 'Крюков', 'АНАТОЛИЙ', 'male', 'divorced', 1170, '2016-09-01'),
(118, 'Кудрявцев', 'АНВАР', 'male', 'single', 1180, '2017-10-02'),
(119, 'Кудряшов', 'АНГЕЛ', 'male', 'married', 1190, '2018-11-03'),
(120, 'Кузнецов', 'АНДОИМ', 'male', 'divorced', 1200, '2019-12-04'),
(121, 'Кузьмин', 'АНДРЕЙ', 'male', 'single', 1210, '2020-01-05'),
(122, 'Кулагин', 'АНДРОНИК', 'male', 'married', 1220, '2021-02-06'),
(123, 'Кулаков', 'АНЕМПОДИСТ', 'male', 'divorced', 1230, '2022-03-07'),
(124, 'Куликов', 'АНЗОР', 'male', 'single', 1240, '2023-04-08'),
(125, 'Лаврентьев', 'АНИС', 'male', 'married', 1250, '2024-05-09'),
(126, 'Лазарев', 'АНИСИМ', 'male', 'divorced', 1260, '2025-06-10'),
(127, 'Лапин', 'АНСАР', 'male', 'single', 1270, '2026-07-11'),
(128, 'Ларионов', 'АНТЕЙ', 'male', 'married', 1280, '2027-08-12'),
(129, 'Лебедев', 'АНТИП', 'male', 'divorced', 1290, '2028-09-13'),
(130, 'Лихачёв', 'АНТОН', 'male', 'single', 1300, '2029-10-14'),
(131, 'Лобанов', 'АНФИМ', 'male', 'married', 1310, '2030-11-15'),
(132, 'Логинов', 'АПОЛЛИНАРИЙ', 'male', 'divorced', 1320, '2031-12-16'),
(133, 'Лукин', 'АПОЛЛОН', 'male', 'single', 1330, '2032-01-17'),
(134, 'Лыткин', 'АРАМ', 'male', 'married', 1340, '2033-02-18'),
(135, 'Макаров', 'АРЕСТ', 'male', 'divorced', 1350, '2034-03-19'),
(136, 'Максимов', 'АРИЙ', 'male', 'single', 1360, '2035-04-20'),
(137, 'Мамонтов', 'АРИСТАРХ', 'male', 'married', 1370, '2036-05-21'),
(138, 'Марков', 'АРКАДИЙ', 'male', 'divorced', 1380, '2037-06-22'),
(139, 'Мартынов', 'АРМАН', 'male', 'single', 1390, '2038-07-23'),
(140, 'Маслов', 'АРМЕН', 'male', 'married', 1400, '2039-08-24'),
(141, 'Матвеев', 'АРНО', 'male', 'divorced', 1410, '2040-09-25'),
(142, 'Медведев', 'АРНОЛЬД', 'male', 'single', 1420, '2041-10-26'),
(143, 'Мельников', 'АРОН', 'male', 'married', 1430, '2042-11-27'),
(144, 'Меркушев', 'АРСЕНИЙ', 'male', 'divorced', 1440, '2043-12-28'),
(145, 'Миронов', 'АРСЛАН', 'male', 'single', 1450, '2044-01-29'),
(146, 'Михайлов', 'АРТАМОН', 'male', 'married', 1460, '2045-02-01'),
(147, 'Михеев', 'АРТЕМ', 'male', 'divorced', 1470, '2046-03-02'),
(148, 'Мишин', 'АРТЕМИЙ', 'male', 'single', 1480, '2047-04-03'),
(149, 'Моисеев', 'АРТУР', 'male', 'married', 1490, '2048-05-04'),
(150, 'Молчанов', 'АРХИМЕД', 'male', 'divorced', 1500, '2049-06-05'),
(151, 'Морозов', 'АРХИП', 'male', 'single', 1510, '2050-07-06'),
(152, 'Муравьёв', 'АСАД', 'male', 'married', 1520, '2051-08-07'),
(153, 'Мухин', 'АСАДУЛЛА', 'male', 'divorced', 1530, '2052-09-08'),
(154, 'Мышкин', 'АСАН', 'male', 'single', 1540, '2053-10-09'),
(155, 'Мясников', 'АСАТ', 'male', 'married', 1550, '2054-11-10'),
(156, 'Назаров', 'АСАФ', 'male', 'divorced', 1560, '2055-12-11'),
(157, 'Наумов', 'АСГАТ', 'male', 'single', 1570, '2056-01-12'),
(158, 'Некрасов', 'АСКОЛЬД', 'male', 'married', 1580, '2057-02-13'),
(159, 'Нестеров', 'АСКЯР', 'male', 'divorced', 1590, '2058-03-14'),
(160, 'Никитин', 'АСТЕРИЙ', 'male', 'single', 1600, '2059-04-15'),
(161, 'Никифоров', 'АСФАТ', 'male', 'married', 1610, '2060-05-16'),
(162, 'Николаев', 'АТА', 'male', 'divorced', 1620, '2061-06-17'),
(163, 'Никонов', 'АТЛАС', 'male', 'single', 1630, '2062-07-18'),
(164, 'Новиков', 'АТТИЛА', 'male', 'married', 1640, '2063-08-19'),
(165, 'Носков', 'АУТИОН', 'male', 'divorced', 1650, '2064-09-20'),
(166, 'Носов', 'АФАНАСИЙ', 'male', 'single', 1660, '2065-10-21'),
(167, 'Овчинников', 'АФЗАЛ', 'male', 'married', 1670, '2066-11-22'),
(168, 'Одинцов', 'АФИНОГЕН', 'male', 'divorced', 1680, '2067-12-23'),
(169, 'Орехов', 'АФОНИЙ', 'male', 'single', 1690, '2068-01-24'),
(170, 'Орлов', 'АХАД', 'male', 'married', 1700, '2069-02-25'),
(171, 'Осипов', 'АХБАР', 'male', 'divorced', 1710, '2070-03-26'),
(172, 'Павлов', 'АХМАД', 'male', 'single', 1720, '2071-04-27'),
(173, 'Панов', 'АХМАР', 'male', 'married', 1730, '2072-05-28'),
(174, 'Панфилов', 'АХМЕР', 'male', 'divorced', 1740, '2073-06-29'),
(175, 'Пахомов', 'АХМЕТ', 'male', 'single', 1750, '2074-07-01'),
(176, 'Пестов', 'АХМЕТ', 'male', 'married', 1760, '2075-08-02'),
(177, 'Петров', 'АХУНД', 'male', 'divorced', 1770, '2076-09-03'),
(178, 'Петухов', 'АШОТ', 'male', 'single', 1780, '2077-10-04'),
(179, 'Поляков', 'АЮП', 'male', 'married', 1790, '2078-11-05'),
(180, 'Пономарёв', 'АЯЗ', 'male', 'divorced', 1800, '2079-12-06'),
(181, 'Попов', 'БАГАУТДИН', 'male', 'single', 1810, '2080-01-07'),
(182, 'Потапов', 'БАГДАТ', 'male', 'married', 1820, '2081-02-08'),
(183, 'Прохоров', 'БАГИР', 'male', 'divorced', 1830, '2082-03-09'),
(184, 'Рогов', 'БАГМАН', 'male', 'single', 1840, '2083-04-10'),
(185, 'Родионов', 'БАДРЕДДИН', 'male', 'married', 1850, '2084-05-11'),
(186, 'Рожков', 'БАДРЕТДИН', 'male', 'divorced', 1860, '2085-06-12'),
(187, 'Романов', 'БАЖЕН', 'male', 'single', 1870, '2086-07-13'),
(188, 'Русаков', 'БАКИР', 'male', 'married', 1880, '2087-08-14'),
(189, 'Рыбаков', 'БАЛАШ', 'male', 'divorced', 1890, '2088-09-15'),
(190, 'Рябов', 'БАЛЬТАЗАР', 'male', 'single', 1900, '2089-10-16'),
(191, 'Савельев', 'БАНАТ', 'male', 'married', 1910, '2090-11-17'),
(192, 'Савин', 'БАРС', 'male', 'divorced', 1920, '2091-12-18'),
(193, 'Сазонов', 'БАТИСТ', 'male', 'single', 1930, '2092-01-19'),
(194, 'Самойлов', 'БАТУ', 'male', 'married', 1940, '2093-02-20'),
(195, 'Самсонов', 'БАТЫЙ', 'male', 'divorced', 1950, '2094-03-21'),
(196, 'Сафонов', 'БАХАДИР', 'male', 'single', 1960, '2095-04-22'),
(197, 'Селезнёв', 'БАХИР', 'male', 'married', 1970, '2096-05-23'),
(198, 'Селиверстов', 'БАХМАН', 'male', 'divorced', 1980, '2097-06-24'),
(199, 'Семёнов', 'БАХРАМ', 'male', 'single', 1990, '2098-07-25'),
(200, 'Сергеев', 'БАХТИЯР', 'male', 'married', 2000, '2099-08-26'),
(201, 'Сидоров', 'БАШАР', 'male', 'divorced', 2010, '2100-09-27'),
(202, 'Силин', 'БАШИР', 'male', 'single', 2020, '2101-10-28'),
(203, 'Симонов', 'БАЯЗ', 'male', 'married', 2030, '2102-11-29'),
(204, 'Ситников', 'БАЯН', 'male', 'divorced', 2040, '2103-12-01'),
(205, 'Соболев', 'БЕКСОЛТ', 'male', 'single', 2050, '2104-01-02'),
(206, 'Соколов', 'БЕКХАН', 'male', 'married', 2060, '2105-02-03'),
(207, 'Соловьёв', 'БЕЛОСЛАВ', 'male', 'divorced', 2070, '2106-03-04'),
(208, 'Сорокин', 'БЕЛОСЛАВ', 'male', 'single', 2080, '2107-04-05'),
(209, 'Степанов', 'БЕНЕДИКТ', 'male', 'married', 2090, '2108-05-06'),
(210, 'Стрелков', 'БЕРЕК', 'male', 'divorced', 2100, '2109-06-07'),
(211, 'Субботин', 'БЕРИМИР', 'male', 'single', 2110, '2110-07-08'),
(212, 'Суворов', 'БЕРИСЛАВ', 'male', 'married', 2120, '2111-08-09'),
(213, 'Суханов', 'БЕРКУТ', 'male', 'divorced', 2130, '2112-09-10'),
(214, 'Сысоев', 'БЕРНАР', 'male', 'single', 2140, '2113-10-11'),
(215, 'Тарасов', 'БЕРНАРД', 'male', 'married', 2150, '2114-11-12'),
(216, 'Терентьев', 'БЕРТОЛЬД', 'male', 'divorced', 2160, '2115-12-13'),
(217, 'Тетерин', 'БЕРТРАМ', 'male', 'single', 2170, '2116-01-14'),
(218, 'Тимофеев', 'БЕСОЛТАН', 'male', 'married', 2180, '2117-02-15'),
(219, 'Титов', 'БИКБАЙ', 'male', 'divorced', 2190, '2118-03-16'),
(220, 'Тихонов', 'БИКБУЛАТ', 'male', 'single', 2200, '2119-04-17'),
(221, 'Третьяков', 'БИЛАЛ', 'male', 'married', 2210, '2120-05-18'),
(222, 'Трофимов', 'БЛАГОМИР', 'male', 'divorced', 2220, '2121-06-19'),
(223, 'Туров', 'БЛАГОСЛАВ', 'male', 'single', 2230, '2122-07-20'),
(224, 'Уваров', 'БЛУД', 'male', 'married', 2240, '2123-08-21'),
(225, 'Устинов', 'БОГДАН', 'male', 'divorced', 2250, '2124-09-22'),
(226, 'Фадеев', 'БОГОЛЮБ', 'male', 'single', 2260, '2125-10-23'),
(227, 'Фёдоров', 'БОГОМИЛ', 'male', 'married', 2270, '2126-11-24'),
(228, 'Федосеев', 'БОЖИДАР', 'male', 'divorced', 2280, '2127-12-25'),
(229, 'Федотов', 'БОЛГАР', 'male', 'single', 2290, '2128-01-26'),
(230, 'Филатов', 'БОЛЕСЛАВ', 'male', 'married', 2300, '2129-02-27'),
(231, 'Филиппов', 'БОНИФАЦИЙ', 'male', 'divorced', 2310, '2130-03-28'),
(232, 'Фокин', 'БОРИМИР', 'male', 'single', 2320, '2131-04-29'),
(233, 'Фомин', 'БОРИС', 'male', 'married', 2330, '2132-05-01'),
(234, 'Фомичёв', 'БОРИСЛАВ', 'male', 'divorced', 2340, '2133-06-02'),
(235, 'Фролов', 'БОРХАН', 'male', 'single', 2350, '2134-07-03'),
(236, 'Харитонов', 'БОРХАНЕТДИН', 'male', 'married', 2360, '2135-08-04'),
(237, 'Хохлов', 'БОЯН', 'male', 'divorced', 2370, '2136-09-05'),
(238, 'Цветков', 'БРАТИСЛАВ', 'male', 'single', 2380, '2137-10-06'),
(239, 'Чернов', 'БРОНИСЛАВ', 'male', 'married', 2390, '2138-11-07'),
(240, 'Шарапов', 'БРУНО', 'male', 'divorced', 2400, '2139-12-08'),
(241, 'Шаров', 'БРЯЧИСЛАВ', 'male', 'single', 2410, '2140-01-09'),
(242, 'Шашков', 'БУДИМИР', 'male', 'married', 2420, '2141-02-10'),
(243, 'Шестаков', 'БУЛАТ', 'female', 'divorced', 2430, '2142-03-11');

-- --------------------------------------------------------

--
-- Структура таблицы `technologies`
--

DROP TABLE IF EXISTS `technologies`;
CREATE TABLE IF NOT EXISTS `technologies` (
`idTechnology` int(10) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `rate` enum('1','2','3') DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `technologies`
--

INSERT INTO `technologies` (`idTechnology`, `name`, `description`, `rate`) VALUES
(1, 'Java junior', 'начальная ступень java.', '2'),
(2, 'Опа, Европа!!34\r\n3434\r\n34', 'Навык путешествий по Европе!', '3'),
(4, 'Технология3', '3', '1'),
(7, '3345', '345345', '1'),
(8, '54654', '45645654', '1');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `affair`
--
ALTER TABLE `affair`
 ADD PRIMARY KEY (`idAffair`), ADD KEY `idEmployee` (`idEmployee`), ADD KEY `idTechnology` (`idTechnology`);

--
-- Индексы таблицы `employees`
--
ALTER TABLE `employees`
 ADD PRIMARY KEY (`idEmployee`);

--
-- Индексы таблицы `technologies`
--
ALTER TABLE `technologies`
 ADD PRIMARY KEY (`idTechnology`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `affair`
--
ALTER TABLE `affair`
MODIFY `idAffair` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT для таблицы `employees`
--
ALTER TABLE `employees`
MODIFY `idEmployee` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=244;
--
-- AUTO_INCREMENT для таблицы `technologies`
--
ALTER TABLE `technologies`
MODIFY `idTechnology` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `affair`
--
ALTER TABLE `affair`
ADD CONSTRAINT `affair_ibfk_1` FOREIGN KEY (`idEmployee`) REFERENCES `employees` (`idEmployee`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `affair_ibfk_2` FOREIGN KEY (`idTechnology`) REFERENCES `technologies` (`idTechnology`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
