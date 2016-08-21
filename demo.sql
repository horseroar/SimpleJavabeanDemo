-- phpMyAdmin SQL Dump
-- version 2.11.9.2
-- http://www.phpmyadmin.net
--
-- 主机: 127.0.0.1:3306
-- 生成日期: 2016 年 08 月 21 日 12:27
-- 服务器版本: 5.1.28
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- 数据库: `test`
--

-- --------------------------------------------------------

--
-- 表的结构 `employee`
--

CREATE TABLE IF NOT EXISTS `employee` (
  `empCode` varchar(100) NOT NULL,
  `departMent` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `sex` smallint(6) NOT NULL,
  `cardNo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 导出表中的数据 `employee`
--

INSERT INTO `employee` (`empCode`, `departMent`, `name`, `sex`, `cardNo`) VALUES
('10001', '研发科1', 'cai01', 1, '155734564'),
('10002', '研发科1', 'cai02', 1, '155734565'),
('10003', '研发科1', 'cai03', 1, '155734566'),
('10004', '研发科1', 'cai04', 1, '155734567'),
('10005', '研发科1', 'cai05', 1, '155734568'),
('10006', '研发科1', 'cai06', 1, '155734569'),
('10007', '研发科2', 'cai07', 1, '155734570'),
('10008', '研发科2', 'cai08', 1, '155734571'),
('10009', '研发科2', 'cai09', 1, '155734572'),
('10010', '研发科2', 'cai10', 1, '155734573'),
('10011', '研发科2', 'cai11', 1, '155734574'),
('10012', '研发科2', 'cai12', 1, '155734575'),
('10013', '研发科3', 'cai13', 1, '155734576'),
('10014', '研发科3', 'cai14', 1, '155734577'),
('10015', '研发科3', 'cai15', 0, '155734578'),
('10016', '研发科3', 'cai16', 0, '155734579'),
('10017', '研发科3', 'cai17', 0, '155734580'),
('10018', '研发科3', 'cai18', 0, '155734581'),
('10019', '研发科3', 'cai19', 0, '155734582'),
('10020', '研发科3', 'cai20', 0, '155734583'),
('10021', '研发科3', 'cai21', 0, '155734584'),
('10022', '研发科3', 'cai22', 0, '155734585');


-- phpMyAdmin SQL Dump
-- version 2.11.9.2
-- http://www.phpmyadmin.net
--
-- 主机: 127.0.0.1:3306
-- 生成日期: 2016 年 08 月 21 日 12:28
-- 服务器版本: 5.1.28
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- 数据库: `test`
--

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `password` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=189 ;

--
-- 导出表中的数据 `user`
--

INSERT INTO `user` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin'),
(15, 'user1', 'pass1'),
(16, 'user2', 'pass2'),
(17, 'user3', 'pass3'),
(18, 'user4', 'pass4'),
(19, 'user5', 'pass5'),
(20, 'user6', 'pass6'),
(21, 'user7', 'pass7'),
(22, 'user8', 'pass8'),
(23, 'user9', 'pass9'),
(24, 'user10', 'pass10'),
(25, 'user11', 'pass11'),
(26, 'user12', 'pass12'),
(27, 'user13', 'pass13'),
(28, 'user14', 'pass14'),
(29, 'user15', 'pass15'),
(30, 'user16', 'pass16'),
(31, 'user17', 'pass17'),
(32, 'user18', 'pass18'),
(33, 'user19', 'pass19'),
(34, 'user20', 'pass20'),
(35, 'user21', 'pass21'),
(36, 'user22', 'pass22'),
(37, 'user23', 'pass23'),
(38, 'user24', 'pass24'),
(39, 'user25', 'pass25'),
(40, 'user26', 'pass26'),
(41, 'user27', 'pass27'),
(42, 'user28', 'pass28'),
(43, 'user29', 'pass29'),
(44, 'user30', 'pass30'),
(45, 'user31', 'pass31'),
(46, 'user32', 'pass32'),
(47, 'user33', 'pass33'),
(48, 'user34', 'pass34'),
(49, 'user35', 'pass35'),
(50, 'user36', 'pass36'),
(51, 'user37', 'pass37'),
(52, 'user38', 'pass38'),
(53, 'user39', 'pass39'),
(54, 'user40', 'pass40'),
(55, 'user41', 'pass41'),
(56, 'user42', 'pass42'),
(57, 'user43', 'pass43'),
(58, 'user44', 'pass44'),
(59, 'user45', 'pass45'),
(60, 'user46', 'pass46'),
(61, 'user47', 'pass47'),
(62, 'user48', 'pass48'),
(63, 'user49', 'pass49'),
(64, 'user50', 'pass50'),
(65, 'user51', 'pass51'),
(66, 'user52', 'pass52'),
(67, 'user53', 'pass53'),
(68, 'user54', 'pass54'),
(69, 'user55', 'pass55'),
(70, 'user56', 'pass56'),
(71, 'user57', 'pass57'),
(72, 'user58', 'pass58'),
(73, 'user59', 'pass59'),
(74, 'user60', 'pass60'),
(75, 'user61', 'pass61'),
(76, 'user62', 'pass62'),
(77, 'user63', 'pass63'),
(78, 'user64', 'pass64'),
(79, 'user65', 'pass65'),
(80, 'user66', 'pass66'),
(81, 'user67', 'pass67'),
(82, 'user68', 'pass68'),
(83, 'user69', 'pass69'),
(84, 'user70', 'pass70'),
(85, 'user71', 'pass71'),
(86, 'user72', 'pass72'),
(87, 'user73', 'pass73'),
(88, 'user74', 'pass74'),
(89, 'user75', 'pass75'),
(90, 'user76', 'pass76'),
(91, 'user77', 'pass77'),
(92, 'user78', 'pass78'),
(93, 'user79', 'pass79'),
(94, 'user80', 'pass80'),
(95, 'user81', 'pass81'),
(96, 'user82', 'pass82'),
(97, 'user83', 'pass83'),
(98, 'user84', 'pass84'),
(99, 'user85', 'pass85'),
(100, 'user86', 'pass86'),
(101, 'user87', 'pass87'),
(102, 'user88', 'pass88'),
(103, 'user89', 'pass89'),
(104, 'user90', 'pass90'),
(105, 'user91', 'pass91'),
(106, 'user92', 'pass92'),
(107, 'user93', 'pass93'),
(108, 'user94', 'pass94'),
(109, 'user95', 'pass95'),
(110, 'user96', 'pass96'),
(111, 'user97', 'pass97'),
(112, 'user98', 'pass98'),
(113, 'user99', 'pass99'),
(114, 'user100', 'pass100'),
(115, 'user101', 'pass101'),
(116, 'user102', 'pass102'),
(117, 'user103', 'pass103'),
(118, 'user104', 'pass104'),
(119, 'user105', 'pass105'),
(120, 'user106', 'pass106'),
(121, 'user107', 'pass107'),
(122, 'user108', 'pass108'),
(123, 'user109', 'pass109'),
(124, 'user110', 'pass110'),
(125, 'user111', 'pass111'),
(126, 'user112', 'pass112'),
(127, 'user113', 'pass113'),
(128, 'user114', 'pass114'),
(129, 'user115', 'pass115'),
(130, 'user116', 'pass116'),
(131, 'user117', 'pass117'),
(132, 'user118', 'pass118'),
(133, 'user119', 'pass119'),
(134, 'user120', 'pass120'),
(135, 'user121', 'pass121'),
(136, 'user122', 'pass122'),
(137, 'user123', 'pass123'),
(138, 'user124', 'pass124'),
(139, 'user125', 'pass125'),
(140, 'user126', 'pass126'),
(141, 'user127', 'pass127'),
(142, 'user128', 'pass128'),
(143, 'user129', 'pass129'),
(144, 'user130', 'pass130'),
(145, 'user131', 'pass131'),
(146, 'user132', 'pass132'),
(147, 'user133', 'pass133'),
(148, 'user134', 'pass134'),
(149, 'user135', 'pass135'),
(150, 'user136', 'pass136'),
(151, 'user137', 'pass137'),
(152, 'user138', 'pass138'),
(153, 'user139', 'pass139'),
(154, 'user140', 'pass140'),
(155, 'user141', 'pass141'),
(156, 'user142', 'pass142'),
(157, 'user143', 'pass143'),
(158, 'user144', 'pass144'),
(159, 'user145', 'pass145'),
(160, 'user146', 'pass146'),
(161, 'user147', 'pass147'),
(162, 'user148', 'pass148'),
(163, 'user149', 'pass149'),
(164, 'user150', 'pass150'),
(165, 'user151', 'pass151'),
(166, 'user152', 'pass152'),
(167, 'user153', 'pass153'),
(168, 'user154', 'pass154'),
(169, 'user155', 'pass155'),
(170, 'user156', 'pass156'),
(171, 'user157', 'pass157'),
(172, 'user158', 'pass158'),
(173, 'user159', 'pass159'),
(174, 'user160', 'pass160'),
(175, 'user161', 'pass161'),
(176, 'user162', 'pass162'),
(177, 'user163', 'pass163'),
(178, 'user164', 'pass164'),
(179, 'user165', 'pass165'),
(180, 'user166', 'pass166'),
(181, 'user167', 'pass167'),
(182, 'user168', 'pass168'),
(183, 'user169', 'pass169');
