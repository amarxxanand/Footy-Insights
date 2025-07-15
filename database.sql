-- SET FOREIGN_KEY_CHECKS = 0;

-- DROP TABLE IF EXISTS player_matches;
-- DROP TABLE IF EXISTS player_stats;
-- DROP TABLE IF EXISTS matches;
-- DROP TABLE IF EXISTS player;
-- DROP TABLE IF EXISTS club_countries;
-- DROP TABLE IF EXISTS countries;

-- SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE countries (
    country_code CHAR(3) PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL
);

CREATE TABLE club_countries (
    club_name VARCHAR(50),
    country_code CHAR(3) NOT NULL,
    PRIMARY KEY (club_name, country_code),
    FOREIGN KEY (country_code) REFERENCES countries(country_code) ON DELETE CASCADE
);

CREATE TABLE player (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(50),
    club_name VARCHAR(50),
    club_country_code CHAR(3),
    nationality VARCHAR(50),
    age INT CHECK (age > 0),
    position VARCHAR(30),
    FOREIGN KEY (club_name, club_country_code) REFERENCES club_countries(club_name, country_code) ON DELETE CASCADE
);

CREATE TABLE matches (
    match_id INT PRIMARY KEY,
    home_team VARCHAR(50) NOT NULL,
    away_team VARCHAR(50) NOT NULL,
    winner VARCHAR(50),
    home_team_goals INT CHECK (home_team_goals >= 0),
    away_team_goals INT CHECK (away_team_goals >= 0)
);

CREATE TABLE player_stats (
    player_id INT PRIMARY KEY,
    goals INT CHECK (goals >= 0),
    assists INT CHECK (assists >= 0),
    passes_attempted INT CHECK (passes_attempted >= 0),
    percentage_passes_completed DECIMAL(5,2) CHECK (percentage_passes_completed BETWEEN 0 AND 100),
    FOREIGN KEY (player_id) REFERENCES player(player_id) ON DELETE CASCADE
);

CREATE TABLE player_matches (
    match_id INT NOT NULL,
    player_id INT NOT NULL,
    PRIMARY KEY (match_id, player_id),
    FOREIGN KEY (match_id) REFERENCES matches(match_id) ON DELETE CASCADE,
    FOREIGN KEY (player_id) REFERENCES player(player_id) ON DELETE CASCADE
);

INSERT INTO countries (country_code, country_name) VALUES
('ARG', 'Argentina'), ('BRA', 'Brazil'), ('GER', 'Germany'), ('FRA', 'France'), ('ESP', 'Spain'), ('ITA', 'Italy'), ('ENG', 'England'), ('POR', 'Portugal'), ('NED', 'Netherlands'), ('BEL', 'Belgium'),
('URU', 'Uruguay'), ('CRO', 'Croatia'), ('COL', 'Colombia'), ('MEX', 'Mexico'), ('SWE', 'Sweden'), ('DEN', 'Denmark'), ('CHL', 'Chile'), ('SUI', 'Switzerland'), ('POL', 'Poland'), ('PER', 'Peru'),
('JPN', 'Japan'), ('KOR', 'South Korea'), ('USA', 'United States'), ('AUS', 'Australia'), ('NGA', 'Nigeria'), ('CIV', 'Ivory Coast'), ('CMR', 'Cameroon'), ('GHA', 'Ghana'), ('SEN', 'Senegal'), ('TUN', 'Tunisia'),
('EGY', 'Egypt'), ('MAR', 'Morocco'), ('IRN', 'Iran'), ('SAU', 'Saudi Arabia'), ('RUS', 'Russia'), ('UKR', 'Ukraine'), ('SRB', 'Serbia'), ('CZE', 'Czech Republic'), ('AUT', 'Austria'), ('ROU', 'Romania'),
('GRE', 'Greece'), ('TUR', 'Turkey'), ('NOR', 'Norway'), ('SCO', 'Scotland'), ('WAL', 'Wales'), ('IRL', 'Ireland'), ('ISL', 'Iceland'), ('HUN', 'Hungary'), ('FIN', 'Finland');

INSERT INTO club_countries (club_name, country_code) VALUES
-- Argentina
('Boca Juniors', 'ARG'),
('River Plate', 'ARG'),
('Independiente', 'ARG'),

-- Brazil
('Flamengo', 'BRA'),
('Palmeiras', 'BRA'),
('Santos', 'BRA'),

-- Germany
('Bayern Munich', 'GER'),
('Borussia Dortmund', 'GER'),
('RB Leipzig', 'GER'),

-- France
('Paris Saint-Germain', 'FRA'),
('Marseille', 'FRA'),
('Lyon', 'FRA'),

-- Spain
('Real Madrid', 'ESP'),
('Barcelona', 'ESP'),
('Atletico Madrid', 'ESP'),

-- Italy
('Juventus', 'ITA'),
('AC Milan', 'ITA'),
('Inter Milan', 'ITA'),

-- England
('Manchester United', 'ENG'),
('Liverpool', 'ENG'),
('Chelsea', 'ENG'),

-- Portugal
('FC Porto', 'POR'),
('Benfica', 'POR'),
('Sporting CP', 'POR'),

-- Netherlands
('Ajax', 'NED'),
('PSV Eindhoven', 'NED'),
('Feyenoord', 'NED'),

-- Belgium
('Anderlecht', 'BEL'),
('Club Brugge', 'BEL'),
('Standard Liège', 'BEL'),

-- Uruguay
('Nacional', 'URU'),
('Peñarol', 'URU'),
('Defensor Sporting', 'URU'),

-- Croatia
('Dinamo Zagreb', 'CRO'),
('Hajduk Split', 'CRO'),
('NK Osijek', 'CRO'),

-- Colombia
('Atlético Nacional', 'COL'),
('Millonarios', 'COL'),
('América de Cali', 'COL'),

-- Mexico
('Club América', 'MEX'),
('Chivas', 'MEX'),
('Cruz Azul', 'MEX'),

-- Sweden
('Malmö FF', 'SWE'),
('IFK Göteborg', 'SWE'),
('AIK', 'SWE'),

-- Denmark
('FC Copenhagen', 'DEN'),
('Brøndby IF', 'DEN'),
('Midtjylland', 'DEN'),

-- Chile
('Colo-Colo', 'CHL'),
('Universidad de Chile', 'CHL'),
('Universidad Católica', 'CHL'),

-- Switzerland
('FC Basel', 'SUI'),
('Grasshopper Club Zürich', 'SUI'),
('Young Boys', 'SUI'),

-- Poland
('Legia Warsaw', 'POL'),
('Lech Poznań', 'POL'),
('Wisła Kraków', 'POL'),

-- Peru
('Alianza Lima', 'PER'),
('Universitario', 'PER'),
('Sporting Cristal', 'PER'),

-- Japan
('Kawasaki Frontale', 'JPN'),
('Gamba Osaka', 'JPN'),
('Yokohama F. Marinos', 'JPN'),

-- South Korea
('Jeonbuk Hyundai Motors', 'KOR'),
('FC Seoul', 'KOR'),
('Ulsan Hyundai', 'KOR'),

-- United States
('LA Galaxy', 'USA'),
('Seattle Sounders', 'USA'),
('Atlanta United', 'USA'),

-- Australia
('Melbourne Victory', 'AUS'),
('Sydney FC', 'AUS'),
('Adelaide United', 'AUS'),

-- Nigeria
('Enyimba', 'NGA'),
('Kano Pillars', 'NGA'),
('Rangers International', 'NGA'),

-- Ivory Coast
('ASEC Mimosas', 'CIV'),
('Africa Sports', 'CIV'),
('Stade d Abidjan', 'CIV'),

-- Cameroon
('Canon Yaoundé', 'CMR'),
('Coton Sport FC', 'CMR'),
('Union Douala', 'CMR'),

-- Ghana
('Asante Kotoko', 'GHA'),
('Accra Hearts of Oak', 'GHA'),
('Ashanti Gold', 'GHA'),

-- Senegal
('ASC Diaraf', 'SEN'),
('Jaraaf', 'SEN'),
('Casa Sports', 'SEN'),

-- Tunisia
('Espérance de Tunis', 'TUN'),
('Club Africain', 'TUN'),
('Étoile du Sahel', 'TUN'),

-- Egypt
('Al Ahly', 'EGY'),
('Zamalek', 'EGY'),
('Ismaily', 'EGY'),

-- Morocco
('Wydad Casablanca', 'MAR'),
('Raja Casablanca', 'MAR'),
('FAR Rabat', 'MAR'),

-- Iran
('Persepolis', 'IRN'),
('Esteghlal', 'IRN'),
('Sepahan', 'IRN'),

-- Saudi Arabia
('Al Hilal', 'SAU'),
('Al Nassr', 'SAU'),
('Al Ittihad', 'SAU'),

-- Russia
('Spartak Moscow', 'RUS'),
('Zenit St. Petersburg', 'RUS'),
('CSKA Moscow', 'RUS'),

-- Ukraine
('Dynamo Kyiv', 'UKR'),
('Shakhtar Donetsk', 'UKR'),
('Dnipro-1', 'UKR'),

-- Serbia
('Red Star Belgrade', 'SRB'),
('Partizan Belgrade', 'SRB'),
('Vojvodina', 'SRB'),

-- Czech Republic
('Sparta Prague', 'CZE'),
('Slavia Prague', 'CZE'),
('Viktoria Plzeň', 'CZE'),

-- Austria
('Rapid Wien', 'AUT'),
('Red Bull Salzburg', 'AUT'),
('Admira Wacker', 'AUT'),

-- Romania
('Steaua București', 'ROU'),
('CFR Cluj', 'ROU'),
('Universitatea Craiova', 'ROU'),

-- Greece
('Olympiacos', 'GRE'),
('Panathinaikos', 'GRE'),
('AEK Athens', 'GRE'),

-- Turkey
('Galatasaray', 'TUR'),
('Fenerbahçe', 'TUR'),
('Beşiktaş', 'TUR'),

-- Norway
('Rosenborg', 'NOR'),
('Molde', 'NOR'),
('Brann', 'NOR'),

-- Scotland
('Celtic', 'SCO'),
('Rangers', 'SCO'),
('Aberdeen', 'SCO'),

-- Wales
('Cardiff City', 'WAL'),
('Swansea City', 'WAL'),
('Newport County', 'WAL'),

-- Ireland
('Shamrock Rovers', 'IRL'),
('Dundalk', 'IRL'),
('Cork City', 'IRL'),

-- Iceland
('KR Reykjavik', 'ISL'),
('Valur', 'ISL'),
('FH Hafnarfjörður', 'ISL'),

-- Hungary
('Ferencváros', 'HUN'),
('Újpest', 'HUN'),
('Diósgyőr', 'HUN'),

-- Finland
('HJK Helsinki', 'FIN'),
('FC Honka', 'FIN'),
('KuPS', 'FIN');

INSERT INTO player (player_id, player_name, club_name, club_country_code, nationality, age, position) VALUES
-- Boca Juniors (Argentina)
(1, 'Carlos Tevez', 'Boca Juniors', 'ARG', 'Argentina', 38, 'Forward'),
(2, 'Esteban Andrada', 'Boca Juniors', 'ARG', 'Argentina', 29, 'Goalkeeper'),
(3, 'Cristian Pavón', 'Boca Juniors', 'ARG', 'Argentina', 28, 'Forward'),

-- River Plate (Argentina)
(4, 'Franco Armani', 'River Plate', 'ARG', 'Argentina', 35, 'Goalkeeper'),
(5, 'Enzo Pérez', 'River Plate', 'ARG', 'Argentina', 35, 'Midfielder'),
(6, 'Gonzalo Montiel', 'River Plate', 'ARG', 'Argentina', 24, 'Defender'),

-- Independiente (Argentina)
(7, 'Rodrigo Zalazar', 'Independiente', 'ARG', 'Argentina', 33, 'Midfielder'),
(8, 'Maximiliano Moralez', 'Independiente', 'ARG', 'Argentina', 31, 'Midfielder'),
(9, 'Leandro Fernández', 'Independiente', 'ARG', 'Argentina', 27, 'Forward'),

-- Flamengo (Brazil)
(10, 'Gabigol', 'Flamengo', 'BRA', 'Brazil', 27, 'Forward'),
(11, 'Diego Alves', 'Flamengo', 'BRA', 'Brazil', 37, 'Goalkeeper'),
(12, 'Giorgian de Arrascaeta', 'Flamengo', 'BRA', 'Brazil', 30, 'Midfielder'),

-- Palmeiras (Brazil)
(13, 'Dudu', 'Palmeiras', 'BRA', 'Brazil', 29, 'Forward'),
(14, 'Gustavo Scarpa', 'Palmeiras', 'BRA', 'Brazil', 28, 'Midfielder'),
(15, 'Weverton', 'Palmeiras', 'BRA', 'Brazil', 32, 'Goalkeeper'),

-- Santos (Brazil)
(16, 'Diego', 'Santos', 'BRA', 'Brazil', 25, 'Midfielder'),
(17, 'Lucas Paquetá', 'Santos', 'BRA', 'Brazil', 26, 'Midfielder'),
(18, 'Renan Lodi', 'Santos', 'BRA', 'Brazil', 24, 'Defender'),

-- Bayern Munich (Germany)
(19, 'Robert Lewandowski', 'Bayern Munich', 'GER', 'Poland', 33, 'Forward'),
(20, 'Manuel Neuer', 'Bayern Munich', 'GER', 'Germany', 35, 'Goalkeeper'),
(21, 'Thomas Müller', 'Bayern Munich', 'GER', 'Germany', 31, 'Midfielder'),

-- Borussia Dortmund (Germany)
(22, 'Marco Reus', 'Borussia Dortmund', 'GER', 'Germany', 32, 'Midfielder'),
(23, 'Erling Haaland', 'Borussia Dortmund', 'GER', 'Norway', 21, 'Forward'),
(24, 'Mats Hummels', 'Borussia Dortmund', 'GER', 'Germany', 33, 'Defender'),

-- RB Leipzig (Germany)
(25, 'Timo Werner', 'RB Leipzig', 'GER', 'Germany', 25, 'Forward'),
(26, 'Angelino', 'RB Leipzig', 'GER', 'Spain', 28, 'Defender'),
(27, 'Dayot Upamecano', 'RB Leipzig', 'GER', 'France', 23, 'Defender'),

-- Paris Saint-Germain (France)
(28, 'Kylian Mbappe', 'Paris Saint-Germain', 'FRA', 'France', 23, 'Forward'),
(29, 'Neymar', 'Paris Saint-Germain', 'FRA', 'Brazil', 30, 'Forward'),
(30, 'Marquinhos', 'Paris Saint-Germain', 'FRA', 'Brazil', 29, 'Defender'),

-- Marseille (France)
(31, 'Florian Thauvin', 'Marseille', 'FRA', 'France', 29, 'Midfielder'),
(32, 'Steve Mandanda', 'Marseille', 'FRA', 'France', 36, 'Goalkeeper'),
(33, 'Dimitri Payet', 'Marseille', 'FRA', 'France', 33, 'Midfielder'),

-- Lyon (France)
(34, 'Houssem Aouar', 'Lyon', 'FRA', 'France', 23, 'Midfielder'),
(35, 'Anthony Lopes', 'Lyon', 'FRA', 'France', 30, 'Goalkeeper'),
(36, 'Moussa Dembélé', 'Lyon', 'FRA', 'France', 25, 'Forward'),

-- Real Madrid (Spain)
(37, 'Karim Benzema', 'Real Madrid', 'ESP', 'France', 33, 'Forward'),
(38, 'Luka Modric', 'Real Madrid', 'ESP', 'Croatia', 36, 'Midfielder'),
(39, 'Thibaut Courtois', 'Real Madrid', 'ESP', 'Belgium', 30, 'Goalkeeper'),

-- Barcelona (Spain)
(40, 'Lionel Messi', 'Barcelona', 'ESP', 'Argentina', 34, 'Forward'),
(41, 'Sergio Busquets', 'Barcelona', 'ESP', 'Spain', 33, 'Midfielder'),
(42, 'Gerard Piqué', 'Barcelona', 'ESP', 'Spain', 34, 'Defender'),

-- Atletico Madrid (Spain)
(43, 'Jan Oblak', 'Atletico Madrid', 'ESP', 'Slovenia', 29, 'Goalkeeper'),
(44, 'Koke', 'Atletico Madrid', 'ESP', 'Spain', 32, 'Midfielder'),
(45, 'Luis Suárez', 'Atletico Madrid', 'ESP', 'Uruguay', 35, 'Forward'),

-- Juventus (Italy)
(46, 'Cristiano Ronaldo', 'Juventus', 'ITA', 'Portugal', 36, 'Forward'),
(47, 'Paulo Dybala', 'Juventus', 'ITA', 'Argentina', 28, 'Forward'),
(48, 'Giorgio Chiellini', 'Juventus', 'ITA', 'Italy', 36, 'Defender'),

-- AC Milan (Italy)
(49, 'Zlatan Ibrahimović', 'AC Milan', 'ITA', 'Sweden', 39, 'Forward'),
(50, 'Theo Hernandez', 'AC Milan', 'ITA', 'France', 24, 'Defender'),
(51, 'Franck Kessié', 'AC Milan', 'ITA', 'Ivory Coast', 28, 'Midfielder'),

-- Inter Milan (Italy)
(52, 'Lautaro Martínez', 'Inter Milan', 'ITA', 'Argentina', 26, 'Forward'),
(53, 'Mauro Icardi', 'Inter Milan', 'ITA', 'Argentina', 31, 'Forward'),
(54, 'Milan Skriniar', 'Inter Milan', 'ITA', 'Slovakia', 30, 'Defender'),

-- Manchester United (England)
(55, 'Marcus Rashford', 'Manchester United', 'ENG', 'England', 24, 'Forward'),
(56, 'David de Gea', 'Manchester United', 'ENG', 'Spain', 32, 'Goalkeeper'),
(57, 'Paul Pogba', 'Manchester United', 'ENG', 'France', 28, 'Midfielder'),

-- Liverpool (England)
(58, 'Mohamed Salah', 'Liverpool', 'ENG', 'Egypt', 29, 'Forward'),
(59, 'Virgil van Dijk', 'Liverpool', 'ENG', 'Netherlands', 30, 'Defender'),
(60, 'Sadio Mane', 'Liverpool', 'ENG', 'Senegal', 29, 'Forward'),

-- Chelsea (England)
(61, 'Mason Mount', 'Chelsea', 'ENG', 'England', 24, 'Midfielder'),
(62, 'N''Golo Kanté', 'Chelsea', 'ENG', 'France', 30, 'Midfielder'),
(63, 'Reece James', 'Chelsea', 'ENG', 'England', 24, 'Defender'),

-- FC Porto (Portugal)
(64, 'Otávio', 'FC Porto', 'POR', 'Brazil', 28, 'Midfielder'),
(65, 'Pepe', 'FC Porto', 'POR', 'Portugal', 36, 'Defender'),
(66, 'Luis Díaz', 'FC Porto', 'POR', 'Colombia', 24, 'Forward'),

-- Benfica (Portugal)
(67, 'Pizzi', 'Benfica', 'POR', 'Portugal', 35, 'Midfielder'),
(68, 'Ederson', 'Benfica', 'POR', 'Portugal', 29, 'Goalkeeper'),
(69, 'Harvey Vale', 'Benfica', 'POR', 'England', 20, 'Midfielder'),

-- Sporting CP (Portugal)
(70, 'Nani', 'Sporting CP', 'POR', 'Portugal', 34, 'Forward'),
(71, 'João Mário', 'Sporting CP', 'POR', 'Portugal', 30, 'Midfielder'),
(72, 'João Palhinha', 'Sporting CP', 'POR', 'Portugal', 26, 'Defender'),

-- Ajax (Netherlands)
(73, 'Dusan Tadić', 'Ajax', 'NED', 'Serbia', 33, 'Midfielder'),
(74, 'Matthijs de Ligt', 'Ajax', 'NED', 'Netherlands', 22, 'Defender'),
(75, 'Frenkie de Jong', 'Ajax', 'NED', 'Netherlands', 24, 'Midfielder'),

-- PSV Eindhoven (Netherlands)
(76, 'Erwin van de Looi', 'PSV Eindhoven', 'NED', 'Netherlands', 39, 'Goalkeeper'),
(77, 'Donyell Malen', 'PSV Eindhoven', 'NED', 'Netherlands', 24, 'Forward'),
(78, 'Morten van de Ven', 'PSV Eindhoven', 'NED', 'Netherlands', 29, 'Midfielder'),

-- Feyenoord (Netherlands)
(79, 'Steven Berghuis', 'Feyenoord', 'NED', 'Netherlands', 28, 'Midfielder'),
(80, 'Luuk de Jong', 'Feyenoord', 'NED', 'Netherlands', 31, 'Forward'),
(81, 'Justin Kluivert', 'Feyenoord', 'NED', 'Netherlands', 23, 'Forward'),

-- Anderlecht (Belgium)
(82, 'Vincent Kompany', 'Anderlecht', 'BEL', 'Belgium', 38, 'Defender'),
(83, 'Romelu Lukaku', 'Anderlecht', 'BEL', 'Belgium', 29, 'Forward'),
(84, 'Youri Tielemans', 'Anderlecht', 'BEL', 'Belgium',24, 'Midfielder'),

-- Club Brugge (Belgium)
(85, 'Hans Vanaken', 'Club Brugge', 'BEL', 'Belgium', 27, 'Midfielder'),
(86, 'Noa Lang', 'Club Brugge', 'BEL', 'Netherlands', 25, 'Forward'),
(87, 'Wout Faes', 'Club Brugge', 'BEL', 'Belgium', 24, 'Defender'),

-- Standard Liège (Belgium)
(88, 'Dieudonné Kalulika', 'Standard Liège', 'BEL', 'DR Congo', 29, 'Midfielder'),
(89, 'Boli Bolingoli', 'Standard Liège', 'BEL', 'Belgium', 25, 'Defender'),
(90, 'Sacha Kljestan', 'Standard Liège', 'BEL', 'USA', 28, 'Midfielder'),

-- Nacional (Uruguay)
(91, 'Facundo Torres', 'Nacional', 'URU', 'Uruguay', 22, 'Forward'),
(92, 'Matías Vecino', 'Nacional', 'URU', 'Uruguay', 31, 'Midfielder'),
(93, 'Rodrigo Muñoz', 'Nacional', 'URU', 'Uruguay', 27, 'Defender'),

-- Peñarol (Uruguay)
(94, 'Fernando Muslera', 'Peñarol', 'URU', 'Uruguay', 36, 'Goalkeeper'),
(95, 'Gastón Silva', 'Peñarol', 'URU', 'Uruguay', 29, 'Forward'),
(96, 'Sebastián Coates', 'Peñarol', 'URU', 'Uruguay', 29, 'Defender'),

-- Cameroon - Canon Yaoundé
(97, 'Eric Mouloungou', 'Canon Yaoundé', 'CMR', 'Cameroon', 27, 'Midfielder'),
(98, 'Aubin Kowo', 'Canon Yaoundé', 'CMR', 'Cameroon', 26, 'Forward'),
(99, 'Guy Mbia', 'Canon Yaoundé', 'CMR', 'Cameroon', 29, 'Defender'),

-- Cameroon - Coton Sport FC
(100, 'Blaise Dje', 'Coton Sport FC', 'CMR', 'Cameroon', 28, 'Midfielder'),
(101, 'Serge Togno', 'Coton Sport FC', 'CMR', 'Cameroon', 25, 'Forward'),
(102, 'Marius Nganou', 'Coton Sport FC', 'CMR', 'Cameroon', 30, 'Defender'),

-- Cameroon - Union Douala
(103, 'Roger Mbeng', 'Union Douala', 'CMR', 'Cameroon', 27, 'Goalkeeper'),
(104, 'Pierre Nlend', 'Union Douala', 'CMR', 'Cameroon', 26, 'Midfielder'),
(105, 'Joseph Enow', 'Union Douala', 'CMR', 'Cameroon', 24, 'Defender'),

-- Ghana - Asante Kotoko
(106, 'Samuel Inkoom', 'Asante Kotoko', 'GHA', 'Ghana', 31, 'Forward'),
(107, 'Kwame Azumah', 'Asante Kotoko', 'GHA', 'Ghana', 28, 'Midfielder'),
(108, 'Yaw Asamoah', 'Asante Kotoko', 'GHA', 'Ghana', 30, 'Defender'),

-- Ghana - Accra Hearts of Oak
(109, 'Nana Boateng', 'Accra Hearts of Oak', 'GHA', 'Ghana', 29, 'Forward'),
(110, 'Kojo Antwi', 'Accra Hearts of Oak', 'GHA', 'Ghana', 34, 'Midfielder'),
(111, 'Yaw Owusu', 'Accra Hearts of Oak', 'GHA', 'Ghana', 27, 'Defender'),

-- Ghana - Ashanti Gold
(112, 'Kofi Adom', 'Ashanti Gold', 'GHA', 'Ghana', 26, 'Midfielder'),
(113, 'Yaw Mensah', 'Ashanti Gold', 'GHA', 'Ghana', 28, 'Forward'),
(114, 'Issahaku Abdul', 'Ashanti Gold', 'GHA', 'Ghana', 30, 'Defender'),

-- Senegal - ASC Diaraf
(115, 'Saliou Ciss', 'ASC Diaraf', 'SEN', 'Senegal', 29, 'Midfielder'),
(116, 'Moussa Ndiaye', 'ASC Diaraf', 'SEN', 'Senegal', 27, 'Forward'),
(117, 'Cheikh Ndour', 'ASC Diaraf', 'SEN', 'Senegal', 30, 'Defender'),

-- Senegal - Jaraaf
(118, 'Abdoulaye Diop', 'Jaraaf', 'SEN', 'Senegal', 28, 'Midfielder'),
(119, 'Lamine Gueye', 'Jaraaf', 'SEN', 'Senegal', 30, 'Defender'),
(120, 'Idrissa Gueye', 'Jaraaf', 'SEN', 'Senegal', 26, 'Midfielder'),

-- Senegal - Casa Sports
(121, 'Ousmane Sarr', 'Casa Sports', 'SEN', 'Senegal', 25, 'Forward'),
(122, 'Mbaye Ndiaye', 'Casa Sports', 'SEN', 'Senegal', 29, 'Midfielder'),
(123, 'Pape Alioune', 'Casa Sports', 'SEN', 'Senegal', 27, 'Defender'),

-- Tunisia - Espérance de Tunis
(124, 'Sami Trabelsi', 'Espérance de Tunis', 'TUN', 'Tunisia', 28, 'Midfielder'),
(125, 'Youssef Msakni', 'Espérance de Tunis', 'TUN', 'Tunisia', 31, 'Forward'),
(126, 'Naim Sliti', 'Espérance de Tunis', 'TUN', 'Tunisia', 24, 'Defender'),

-- Tunisia - Club Africain
(127, 'Mohamed Ali Ben Romdhane', 'Club Africain', 'TUN', 'Tunisia', 30, 'Midfielder'),
(128, 'Amin Ghariani', 'Club Africain', 'TUN', 'Tunisia', 29, 'Forward'),
(129, 'Khalil Azmi', 'Club Africain', 'TUN', 'Tunisia', 27, 'Defender'),

-- Tunisia - Étoile du Sahel
(130, 'Abdelkader Boukhari', 'Étoile du Sahel', 'TUN', 'Tunisia', 26, 'Midfielder'),
(131, 'Fares Chaoui', 'Étoile du Sahel', 'TUN', 'Tunisia', 28, 'Forward'),
(132, 'Slim Ben Gacem', 'Étoile du Sahel', 'TUN', 'Tunisia', 25, 'Defender'),

-- Egypt - Al Ahly
(133, 'Mohamed Magdy', 'Al Ahly', 'EGY', 'Egypt', 28, 'Forward'),
(134, 'Hany Said', 'Al Ahly', 'EGY', 'Egypt', 30, 'Midfielder'),
(135, 'Tarek Abdelhamid', 'Al Ahly', 'EGY', 'Egypt', 27, 'Defender'),

-- Egypt - Zamalek
(136, 'Ahmed Hegazy', 'Zamalek', 'EGY', 'Egypt', 29, 'Defender'),
(137, 'Ahmed Gohar', 'Zamalek', 'EGY', 'Egypt', 31, 'Midfielder'),
(138, 'Mostafa Mohamed', 'Zamalek', 'EGY', 'Egypt', 28, 'Forward'),

-- Egypt - Ismaily
(139, 'Abdelrahman El-Beheiry', 'Ismaily', 'EGY', 'Egypt', 27, 'Goalkeeper'),
(140, 'Mohsen Hefny', 'Ismaily', 'EGY', 'Egypt', 26, 'Defender'),
(141, 'Amr Galal', 'Ismaily', 'EGY', 'Egypt', 29, 'Midfielder'),

-- Morocco - Wydad Casablanca
(142, 'Achraf Bencharki', 'Wydad Casablanca', 'MAR', 'Morocco', 29, 'Forward'),
(143, 'Sofian El Moudane', 'Wydad Casablanca', 'MAR', 'Morocco', 28, 'Midfielder'),
(144, 'Youssef El Arabi', 'Wydad Casablanca', 'MAR', 'Morocco', 30, 'Forward'),

-- Morocco - Raja Casablanca
(145, 'Mohamed Reda', 'Raja Casablanca', 'MAR', 'Morocco', 27, 'Midfielder'),
(146, 'Ahmed Hossam', 'Raja Casablanca', 'MAR', 'Morocco', 28, 'Forward'),
(147, 'Jamal Naji', 'Raja Casablanca', 'MAR', 'Morocco', 26, 'Defender'),

-- Morocco - FAR Rabat
(148, 'Abdellah Idrissi', 'FAR Rabat', 'MAR', 'Morocco', 29, 'Midfielder'),
(149, 'Rachid Chihab', 'FAR Rabat', 'MAR', 'Morocco', 30, 'Defender'),
(150, 'Karim El Amraoui', 'FAR Rabat', 'MAR', 'Morocco', 27, 'Forward'),

-- Iran - Persepolis
(151, 'Ali Daei', 'Persepolis', 'IRN', 'Iran', 41, 'Forward'),
(152, 'Mehdi Mahdavikia', 'Persepolis', 'IRN', 'Iran', 39, 'Midfielder'),
(153, 'Sajad Shahbazzadeh', 'Persepolis', 'IRN', 'Iran', 32, 'Goalkeeper'),

-- Iran - Esteghlal
(154, 'Ali Parvin', 'Esteghlal', 'IRN', 'Iran', 42, 'Midfielder'),
(155, 'Reza Ghoochannejhad', 'Esteghlal', 'IRN', 'Iran', 34, 'Forward'),
(156, 'Vahid Amiri', 'Esteghlal', 'IRN', 'Iran', 29, 'Defender'),

-- Iran - Sepahan
(157, 'Hossein Papi', 'Sepahan', 'IRN', 'Iran', 27, 'Midfielder'),
(158, 'Mohammad Reza Khalatbari', 'Sepahan', 'IRN', 'Iran', 33, 'Forward'),
(159, 'Ebrahim Ashtiani', 'Sepahan', 'IRN', 'Iran', 30, 'Defender'),

-- Saudi Arabia - Al Hilal
(160, 'Salman Al-Faraj', 'Al Hilal', 'SAU', 'Saudi Arabia', 32, 'Midfielder'),
(161, 'Mohammed Al-Deayea', 'Al Hilal', 'SAU', 'Saudi Arabia', 35, 'Goalkeeper'),
(162, 'Yasser Al-Shahrani', 'Al Hilal', 'SAU', 'Saudi Arabia', 28, 'Defender'),

-- Saudi Arabia - Al Nassr
(163, 'Sami Al-Jaber', 'Al Nassr', 'SAU', 'Saudi Arabia', 40, 'Forward'),
(164, 'Abdulrahman Al-Dossari', 'Al Nassr', 'SAU', 'Saudi Arabia', 29, 'Midfielder'),
(165, 'Nordin Amrabat', 'Al Nassr', 'SAU', 'Saudi Arabia', 30, 'Midfielder'),

-- Saudi Arabia - Al Ittihad
(166, 'Yasser Al-Qahtani', 'Al Ittihad', 'SAU', 'Saudi Arabia', 38, 'Forward'),
(167, 'Mansoor Al-Harbi', 'Al Ittihad', 'SAU', 'Saudi Arabia', 31, 'Midfielder'),
(168, 'Sultan Al-Ghanam', 'Al Ittihad', 'SAU', 'Saudi Arabia', 27, 'Defender'),

-- Russia - Spartak Moscow
(169, 'Roman Shishkin', 'Spartak Moscow', 'RUS', 'Russia', 29, 'Forward'),
(170, 'Daniil Lesovoy', 'Spartak Moscow', 'RUS', 'Russia', 26, 'Midfielder'),
(171, 'Kirill Nababkin', 'Spartak Moscow', 'RUS', 'Russia', 28, 'Defender'),

-- Russia - Zenit St. Petersburg
(172, 'Aleksandr Erokhin', 'Zenit St. Petersburg', 'RUS', 'Russia', 29, 'Midfielder'),
(173, 'Ivan Oblyakov', 'Zenit St. Petersburg', 'RUS', 'Russia', 27, 'Forward'),
(174, 'Vladimir Granat', 'Zenit St. Petersburg', 'RUS', 'Russia', 30, 'Defender'),

-- Ukraine - Dynamo Kyiv
(175, 'Andriy Pyatov', 'Dynamo Kyiv', 'UKR', 'Ukraine', 34, 'Goalkeeper'),
(176, 'Andriy Yarmolenko', 'Dynamo Kyiv', 'UKR', 'Ukraine', 31, 'Forward'),
(177, 'Roman Yaremchuk', 'Dynamo Kyiv', 'UKR', 'Ukraine', 27, 'Forward'),

-- Ukraine - Shakhtar Donetsk
(178, 'Marlos', 'Shakhtar Donetsk', 'UKR', 'Brazil', 30, 'Forward'),
(179, 'Taras Stepanenko', 'Shakhtar Donetsk', 'UKR', 'Ukraine', 33, 'Midfielder'),
(180, 'Taras Mykhalyk', 'Shakhtar Donetsk', 'UKR', 'Ukraine', 25, 'Defender'),

-- Ukraine - Dnipro-1
(181, 'Denys Bezborodko', 'Dnipro-1', 'UKR', 'Ukraine', 28, 'Forward'),
(182, 'Ivan Ordets', 'Dnipro-1', 'UKR', 'Ukraine', 29, 'Defender'),
(183, 'Artem Kravets', 'Dnipro-1', 'UKR', 'Ukraine', 26, 'Midfielder'),

-- Serbia - Red Star Belgrade
(184, 'Vasilije Micić', 'Red Star Belgrade', 'SRB', 'Serbia', 28, 'Forward'),
(185, 'Luka Jović', 'Red Star Belgrade', 'SRB', 'Serbia', 27, 'Forward'),
(186, 'Nikola Stojiljković', 'Red Star Belgrade', 'SRB', 'Serbia', 29, 'Midfielder'),

-- Serbia - Partizan Belgrade
(187, 'Aleksandar Mitrović', 'Partizan Belgrade', 'SRB', 'Serbia', 31, 'Forward'),
(188, 'Stevan Jovetić', 'Partizan Belgrade', 'SRB', 'Serbia', 32, 'Forward'),
(189, 'Đorđe Ivanović', 'Partizan Belgrade', 'SRB', 'Serbia', 26, 'Midfielder'),

-- Serbia - Vojvodina
(190, 'Filip Kostić', 'Vojvodina', 'SRB', 'Serbia', 29, 'Forward'),
(191, 'Miloš Veljković', 'Vojvodina', 'SRB', 'Serbia', 27, 'Midfielder'),
(192, 'Marko Simonovski', 'Vojvodina', 'SRB', 'Macedonia', 26, 'Defender'),

-- Czech Republic - Sparta Prague
(193, 'Václav Kadlec', 'Sparta Prague', 'CZE', 'Czech Republic', 30, 'Goalkeeper'),
(194, 'Bořek Dočkal', 'Sparta Prague', 'CZE', 'Czech Republic', 31, 'Defender'),
(195, 'Tomáš Pekhart', 'Sparta Prague', 'CZE', 'Czech Republic', 29, 'Forward'),

-- Czech Republic - Slavia Prague
(196, 'Ondřej Kolář', 'Slavia Prague', 'CZE', 'Czech Republic', 28, 'Midfielder'),
(197, 'Lukáš Masopust', 'Slavia Prague', 'CZE', 'Czech Republic', 29, 'Defender'),
(198, 'Vítězslav Jaroš', 'Slavia Prague', 'CZE', 'Czech Republic', 27, 'Forward'),

-- Czech Republic - Viktoria Plzeň
(199, 'Jiří Plíšek', 'Viktoria Plzeň', 'CZE', 'Czech Republic', 34, 'Midfielder'),
(200, 'David Lischka', 'Viktoria Plzeň', 'CZE', 'Czech Republic', 25, 'Forward'),
(201, 'Michal Ševčík', 'Viktoria Plzeň', 'CZE', 'Czech Republic', 26, 'Defender'),

-- Austria - Rapid Wien
(202, 'Peter Trapp', 'Rapid Wien', 'AUT', 'Austria', 28, 'Defender'),
(203, 'Stefan Ilsanker', 'Rapid Wien', 'AUT', 'Austria', 29, 'Midfielder'),
(204, 'Marc Janko', 'Rapid Wien', 'AUT', 'Austria', 34, 'Forward'),

-- Austria - Red Bull Salzburg
(205, 'Marcel Sabitzer', 'Red Bull Salzburg', 'AUT', 'Austria', 29, 'Midfielder'),
(206, 'Xaver Schlager', 'Red Bull Salzburg', 'AUT', 'Austria', 26, 'Midfielder'),
(207, 'Andreas Ulmer', 'Red Bull Salzburg', 'AUT', 'Austria', 33, 'Forward'),

-- Austria - Admira Wacker
(208, 'Peter Pekarík', 'Admira Wacker', 'AUT', 'Slovakia', 29, 'Goalkeeper'),
(209, 'Christoph Monschein', 'Admira Wacker', 'AUT', 'Austria', 31, 'Defender'),
(210, 'Marko Milinković', 'Admira Wacker', 'AUT', 'Serbia', 27, 'Midfielder'),

-- Romania - Steaua București
(211, 'Marius Șumudică', 'Steaua București', 'ROU', 'Romania', 32, 'Midfielder'),
(212, 'Gheorghe Hagi', 'Steaua București', 'ROU', 'Romania', 48, 'Forward'),
(213, 'Florin Bratu', 'Steaua București', 'ROU', 'Romania', 36, 'Forward'),

-- Romania - CFR Cluj
(214, 'Răzvan Marin', 'CFR Cluj', 'ROU', 'Romania', 29, 'Midfielder'),
(215, 'Alin Minteuan', 'CFR Cluj', 'ROU', 'Romania', 31, 'Defender'),
(216, 'Florin Nitu', 'CFR Cluj', 'ROU', 'Romania', 28, 'Forward'),

-- Romania - Universitatea Craiova
(217, 'Luis Hernández', 'Universitatea Craiova', 'ROU', 'Romania', 27, 'Forward'),
(218, 'Alexandru Tudorie', 'Universitatea Craiova', 'ROU', 'Romania', 26, 'Midfielder'),
(219, 'Cristian Gavanescu', 'Universitatea Craiova', 'ROU', 'Romania', 30, 'Defender'),

-- Greece - Olympiacos
(220, 'Vasilis Torosidis', 'Olympiacos', 'GRE', 'Greece', 35, 'Defender'),
(221, 'Kostas Mitroglou', 'Olympiacos', 'GRE', 'Greece', 33, 'Forward'),
(222, 'Sebastian Leto', 'Olympiacos', 'GRE', 'Greece', 29, 'Midfielder'),

-- Greece - Panathinaikos
(223, 'Dimitris Papadopoulos', 'Panathinaikos', 'GRE', 'Greece', 31, 'Midfielder'),
(224, 'Giannis Maniatis', 'Panathinaikos', 'GRE', 'Greece', 34, 'Defender'),
(225, 'Kostas Frantzeskos', 'Panathinaikos', 'GRE', 'Greece', 27, 'Forward'),

-- Greece - AEK Athens
(226, 'Manolo Gabbiadini', 'AEK Athens', 'GRE', 'Italy', 31, 'Forward'),
(227, 'Sokratis Papastathopoulos', 'AEK Athens', 'GRE', 'Greece', 34, 'Defender'),
(228, 'Marko Livaja', 'AEK Athens', 'GRE', 'Croatia', 28, 'Midfielder'),

-- Turkey - Galatasaray
(229, 'Fernando Muslera', 'Galatasaray', 'TUR', 'Uruguay', 35, 'Goalkeeper'),
(230, 'Arda Turan', 'Galatasaray', 'TUR', 'Turkey', 33, 'Midfielder'),
(231, 'Radamel Falcao', 'Galatasaray', 'TUR', 'Colombia', 33, 'Forward'),

-- Turkey - Fenerbahçe
(232, 'Altay Bayındır', 'Fenerbahçe', 'TUR', 'Turkey', 25, 'Goalkeeper'),
(233, 'Mesut Özil', 'Fenerbahçe', 'TUR', 'Germany', 34, 'Midfielder'),
(234, 'Ozan Tufan', 'Fenerbahçe', 'TUR', 'Turkey', 28, 'Defender'),

-- Turkey - Besiktas
(235, 'Cenk Tosun', 'Besiktas', 'TUR', 'Turkey', 30, 'Forward'),
(236, 'Andreas Cornelius', 'Besiktas', 'TUR', 'Denmark', 31, 'Forward'),
(237, 'Gökhan Gönül', 'Besiktas', 'TUR', 'Turkey', 33, 'Defender'),

-- Norway - Rosenborg
(238, 'Nicklas Bendtner', 'Rosenborg', 'NOR', 'Denmark', 29, 'Forward'),
(239, 'Morten Gamst Pedersen', 'Rosenborg', 'NOR', 'Norway', 34, 'Midfielder'),
(240, 'Tore Reginiussen', 'Rosenborg', 'NOR', 'Norway', 32, 'Defender'),

-- Norway - Molde
(241, 'Ole Gunnar Solskjær', 'Molde', 'NOR', 'Norway', 37, 'Forward'),
(242, 'Erling Haaland', 'Molde', 'NOR', 'Norway', 20, 'Forward'),
(243, 'Martin Ødegaard', 'Molde', 'NOR', 'Norway', 21, 'Midfielder'),

-- Norway - Brann
(244, 'Harald Brattbakk', 'Brann', 'NOR', 'Norway', 34, 'Forward'),
(245, 'Stig Inge Bjørnebye', 'Brann', 'NOR', 'Norway', 35, 'Defender'),
(246, 'Daniel Braaten', 'Brann', 'NOR', 'Norway', 28, 'Midfielder'),

-- Scotland - Celtic
(247, 'Scott Brown', 'Celtic', 'SCO', 'Scotland', 34, 'Defender'),
(248, 'Callum McGregor', 'Celtic', 'SCO', 'Scotland', 29, 'Midfielder'),
(249, 'James Forrest', 'Celtic', 'SCO', 'Scotland', 27, 'Forward'),

-- Scotland - Rangers
(250, 'James Tavernier', 'Rangers', 'SCO', 'Scotland', 33, 'Defender'),
(251, 'Paul Foley', 'Rangers', 'SCO', 'Scotland', 30, 'Midfielder'),
(252, 'Chris Burke', 'Rangers', 'SCO', 'Scotland', 26, 'Forward'),

-- Scotland - Aberdeen
(253, 'Scott McKenna', 'Aberdeen', 'SCO', 'Scotland', 24, 'Defender'),
(254, 'Greg Leigh', 'Aberdeen', 'SCO', 'Scotland', 23, 'Defender'),
(255, 'Jonny Hayes', 'Aberdeen', 'SCO', 'Scotland', 27, 'Forward'),

-- Wales - Cardiff City
(256, 'Joe Ralls', 'Cardiff City', 'WAL', 'Wales', 28, 'Midfielder'),
(257, 'Ryan Flores', 'Cardiff City', 'WAL', 'Wales', 30, 'Defender'),
(258, 'Kieffer Moore', 'Cardiff City', 'WAL', 'Wales', 27, 'Forward'),

-- Wales - Swansea City
(259, 'Connor Roberts', 'Swansea City', 'WAL', 'Wales', 24, 'Defender'),
(260, 'Joe Allen', 'Swansea City', 'WAL', 'Wales', 31, 'Midfielder'),
(261, 'Leon Britton', 'Swansea City', 'WAL', 'Wales', 32, 'Midfielder'),

-- Wales - Newport County
(262, 'Aaron Collins', 'Newport County', 'WAL', 'Wales', 26, 'Defender'),
(263, 'Ryan Taylor', 'Newport County', 'WAL', 'Wales', 28, 'Midfielder'),
(264, 'Ethan Villamar', 'Newport County', 'WAL', 'Wales', 23, 'Forward'),

-- Ireland - Shamrock Rovers
(265, 'Gary O Neill', 'Shamrock Rovers', 'IRL', 'Ireland', 29, 'Defender'),
(266, 'Conor Hourihane', 'Shamrock Rovers', 'IRL', 'Ireland', 28, 'Midfielder'),
(267, 'Daryl Horgan', 'Shamrock Rovers', 'IRL', 'Ireland', 30, 'Forward'),

-- Ireland - Dundalk
(268, 'Patrick McEleney', 'Dundalk', 'IRL', 'Ireland', 31, 'Midfielder'),
(269, 'Shane Long', 'Dundalk', 'IRL', 'Ireland', 33, 'Forward'),
(270, 'David McMillan', 'Dundalk', 'IRL', 'Ireland', 28, 'Forward'),

-- Ireland - Cork City
(271, 'Eoin Concannon', 'Cork City', 'IRL', 'Ireland', 26, 'Defender'),
(272, 'Seán McLoughlin', 'Cork City', 'IRL', 'Ireland', 29, 'Midfielder'),
(273, 'Ronan Curtis', 'Cork City', 'IRL', 'Ireland', 24, 'Forward'),

-- Iceland - KR Reykjavik
(274, 'Sævar Birgisson', 'KR Reykjavik', 'ISL', 'Iceland', 34, 'Goalkeeper'),
(275, 'Kolbeinn Sigþórsson', 'KR Reykjavik', 'ISL', 'Iceland', 31, 'Forward'),
(276, 'Birkir Már Sævarsson', 'KR Reykjavik', 'ISL', 'Iceland', 28, 'Midfielder'),

-- Iceland - Valur
(277, 'Arnar Gunnlaugsson', 'Valur', 'ISL', 'Iceland', 35, 'Forward'),
(278, 'Ólafur Ingi', 'Valur', 'ISL', 'Iceland', 32, 'Midfielder'),
(279, 'Eiður Guðjohnsen', 'Valur', 'ISL', 'Iceland', 37, 'Forward'),

-- Iceland - FH Hafnarfjörður
(280, 'Rútur Elíasson', 'FH Hafnarfjörður', 'ISL', 'Iceland', 27, 'Midfielder'),
(281, 'Kári Árnason', 'FH Hafnarfjörður', 'ISL', 'Iceland', 30, 'Defender'),
(282, 'Magnús Sigurðsson', 'FH Hafnarfjörður', 'ISL', 'Iceland', 26, 'Forward'),

-- Hungary - Ferencváros
(283, 'Dávid Korcsmár', 'Ferencváros', 'HUN', 'Hungary', 24, 'Midfielder'),
(284, 'László Kleinheisler', 'Ferencváros', 'HUN', 'Hungary', 28, 'Midfielder'),
(285, 'Nemanja Nikolić', 'Ferencváros', 'HUN', 'Hungary', 31, 'Forward'),

-- Hungary - Újpest
(286, 'Zoltán Gera', 'Újpest', 'HUN', 'Hungary', 38, 'Midfielder'),
(287, 'Markus Tamas', 'Újpest', 'HUN', 'Hungary', 25, 'Defender'),
(288, 'Balázs Dzsudzsák', 'Újpest', 'HUN', 'Hungary', 33, 'Midfielder'),

-- Hungary - Diósgyőr
(289, 'Szabolcs Huszti', 'Diósgyőr', 'HUN', 'Hungary', 34, 'Midfielder'),
(290, 'Attila Fiola', 'Diósgyőr', 'HUN', 'Hungary', 26, 'Defender'),
(291, 'Zsolt Kalmár', 'Diósgyőr', 'HUN', 'Hungary', 29, 'Forward'),

-- Finland - HJK Helsinki
(292, 'Teemu Pukki', 'HJK Helsinki', 'FIN', 'Finland', 31, 'Forward'),
(293, 'Dever Orgill', 'HJK Helsinki', 'FIN', 'Finland', 30, 'Midfielder'),
(294, 'Atik Ismail', 'HJK Helsinki', 'FIN', 'Finland', 28, 'Defender'),

-- Finland - FC Honka
(295, 'Joni Kauko', 'FC Honka', 'FIN', 'Finland', 29, 'Defender'),
(296, 'Henri Anier', 'FC Honka', 'FIN', 'Estonia', 30, 'Goalkeeper'),
(297, 'Eero Markkanen', 'FC Honka', 'FIN', 'Finland', 27, 'Forward'),

-- Finland - KuPS
(298, 'Eero Tamminen', 'KuPS', 'FIN', 'Finland', 26, 'Midfielder'),
(299, 'Timo Furuholm', 'KuPS', 'FIN', 'Finland', 28, 'Defender'),
(300, 'Jukka Raitala', 'KuPS', 'FIN', 'Finland', 31, 'Defender');



INSERT INTO matches (match_id, home_team, away_team, winner, home_team_goals, away_team_goals) VALUES
-- Group 1 (Matches 1-10)
(1, 'Boca Juniors', 'River Plate', 'Boca Juniors', 2, 1),
(2, 'Bayern Munich', 'Borussia Dortmund', 'Bayern Munich', 3, 1),
(3, 'Real Madrid', 'Barcelona', 'Real Madrid', 2, 1),
(4, 'Manchester United', 'Liverpool', 'Liverpool', 1, 2),
(5, 'Juventus', 'AC Milan', 'Juventus', 2, 0),
(6, 'Paris Saint-Germain', 'Marseille', 'Paris Saint-Germain', 4, 2),
(7, 'Ajax', 'PSV Eindhoven', 'Ajax', 2, 0),
(8, 'Flamengo', 'Palmeiras', 'Draw', 1, 1),
(9, 'Santos', 'RB Leipzig', 'RB Leipzig', 0, 3),
(10, 'Independiente', 'Flamengo', 'Flamengo', 1, 2),

-- Group 2 (Matches 11-20)
(11, 'River Plate', 'Boca Juniors', 'Draw', 1, 1),
(12, 'Borussia Dortmund', 'Bayern Munich', 'Bayern Munich', 1, 3),
(13, 'Barcelona', 'Real Madrid', 'Real Madrid', 0, 1),
(14, 'Liverpool', 'Manchester United', 'Manchester United', 2, 1),
(15, 'AC Milan', 'Juventus', 'Juventus', 1, 2),
(16, 'Marseille', 'Lyon', 'Lyon', 1, 2),
(17, 'PSV Eindhoven', 'Feyenoord', 'PSV Eindhoven', 3, 2),
(18, 'Palmeiras', 'Santos', 'Santos', 1, 2),
(19, 'RB Leipzig', 'Borussia Dortmund', 'RB Leipzig', 2, 0),
(20, 'Flamengo', 'Independiente', 'Flamengo', 2, 0),

-- Group 3 (Matches 21-30)
(21, 'Boca Juniors', 'Independiente', 'Boca Juniors', 3, 1),
(22, 'Borussia Dortmund', 'RB Leipzig', 'Borussia Dortmund', 2, 1),
(23, 'Real Madrid', 'Atletico Madrid', 'Real Madrid', 3, 0),
(24, 'Chelsea', 'Manchester United', 'Chelsea', 2, 1),
(25, 'Juventus', 'Inter Milan', 'Juventus', 1, 0),
(26, 'Paris Saint-Germain', 'Lyon', 'Paris Saint-Germain', 2, 1),
(27, 'Ajax', 'Feyenoord', 'Ajax', 3, 2),
(28, 'Palmeiras', 'Flamengo', 'Flamengo', 1, 3),
(29, 'Santos', 'Flamengo', 'Draw', 2, 2),
(30, 'Real Madrid', 'Barcelona', 'Barcelona', 1, 2),

-- Group 4 (Matches 31-40)
(31, 'Bayern Munich', 'RB Leipzig', 'Bayern Munich', 3, 0),
(32, 'Borussia Dortmund', 'Bayern Munich', 'Bayern Munich', 0, 2),
(33, 'River Plate', 'Independiente', 'River Plate', 2, 1),
(34, 'AC Milan', 'Inter Milan', 'Inter Milan', 1, 2),
(35, 'Marseille', 'Paris Saint-Germain', 'Paris Saint-Germain', 1, 3),
(36, 'Lyon', 'Marseille', 'Lyon', 2, 1),
(37, 'Ajax', 'PSV Eindhoven', 'Ajax', 2, 0),
(38, 'Feyenoord', 'PSV Eindhoven', 'PSV Eindhoven', 1, 2),
(39, 'Chelsea', 'Liverpool', 'Chelsea', 2, 0),
(40, 'Manchester United', 'Chelsea', 'Draw', 2, 2),

-- Group 5 (Matches 41-50)
(41, 'Juventus', 'AC Milan', 'Juventus', 2, 1),
(42, 'Inter Milan', 'Juventus', 'Juventus', 0, 1),
(43, 'Real Madrid', 'Atletico Madrid', 'Atletico Madrid', 1, 2),
(44, 'Barcelona', 'Atletico Madrid', 'Barcelona', 2, 1),
(45, 'Boca Juniors', 'River Plate', 'River Plate', 1, 2),
(46, 'Flamengo', 'Santos', 'Flamengo', 3, 1),
(47, 'Palmeiras', 'Santos', 'Palmeiras', 2, 0),
(48, 'Bayern Munich', 'Borussia Dortmund', 'Bayern Munich', 3, 1),
(49, 'Paris Saint-Germain', 'Marseille', 'Paris Saint-Germain', 2, 0),
(50, 'Ajax', 'Feyenoord', 'Ajax', 2, 0),

-- Group 6 (Matches 51-60)
(51, 'River Plate', 'Boca Juniors', 'River Plate', 2, 1),
(52, 'Borussia Dortmund', 'RB Leipzig', 'Borussia Dortmund', 1, 0),
(53, 'Real Madrid', 'Barcelona', 'Draw', 2, 2),
(54, 'Manchester United', 'Liverpool', 'Liverpool', 0, 1),
(55, 'Juventus', 'AC Milan', 'Juventus', 2, 1),
(56, 'Paris Saint-Germain', 'Lyon', 'Paris Saint-Germain', 3, 1),
(57, 'Ajax', 'PSV Eindhoven', 'Ajax', 1, 0),
(58, 'Flamengo', 'Palmeiras', 'Flamengo', 2, 1),
(59, 'Santos', 'RB Leipzig', 'RB Leipzig', 1, 2),
(60, 'Independiente', 'Flamengo', 'Flamengo', 1, 2),

-- Group 7 (Matches 61-70)
(61, 'Boca Juniors', 'Independiente', 'Boca Juniors', 2, 0),
(62, 'Borussia Dortmund', 'RB Leipzig', 'Borussia Dortmund', 2, 1),
(63, 'Real Madrid', 'Atletico Madrid', 'Real Madrid', 3, 1),
(64, 'Chelsea', 'Manchester United', 'Chelsea', 1, 0),
(65, 'Juventus', 'Inter Milan', 'Juventus', 2, 0),
(66, 'Paris Saint-Germain', 'Marseille', 'Paris Saint-Germain', 4, 1),
(67, 'Ajax', 'Feyenoord', 'Ajax', 2, 1),
(68, 'Palmeiras', 'Santos', 'Santos', 1, 2),
(69, 'RB Leipzig', 'Borussia Dortmund', 'RB Leipzig', 3, 1),
(70, 'Flamengo', 'Independiente', 'Flamengo', 2, 0),

-- Group 8 (Matches 71-80)
(71, 'Boca Juniors', 'River Plate', 'Draw', 1, 1),
(72, 'Bayern Munich', 'Borussia Dortmund', 'Bayern Munich', 3, 1),
(73, 'Real Madrid', 'Barcelona', 'Real Madrid', 2, 0),
(74, 'Manchester United', 'Liverpool', 'Liverpool', 1, 2),
(75, 'Juventus', 'AC Milan', 'Juventus', 2, 0),
(76, 'Paris Saint-Germain', 'Marseille', 'Paris Saint-Germain', 4, 1),
(77, 'Ajax', 'PSV Eindhoven', 'Ajax', 2, 0),
(78, 'Flamengo', 'Palmeiras', 'Flamengo', 2, 1),
(79, 'Santos', 'RB Leipzig', 'RB Leipzig', 1, 2),
(80, 'Independiente', 'Flamengo', 'Flamengo', 2, 0),

-- Group 9 (Matches 81-90)
(81, 'River Plate', 'Boca Juniors', 'River Plate', 3, 2),
(82, 'Borussia Dortmund', 'Bayern Munich', 'Bayern Munich', 1, 3),
(83, 'Barcelona', 'Real Madrid', 'Real Madrid', 1, 2),
(84, 'Liverpool', 'Manchester United', 'Manchester United', 1, 0),
(85, 'AC Milan', 'Juventus', 'Juventus', 0, 1),
(86, 'Marseille', 'Lyon', 'Lyon', 1, 2),
(87, 'PSV Eindhoven', 'Feyenoord', 'PSV Eindhoven', 3, 2),
(88, 'Palmeiras', 'Santos', 'Santos', 1, 2),
(89, 'RB Leipzig', 'Borussia Dortmund', 'RB Leipzig', 2, 0),
(90, 'Flamengo', 'Independiente', 'Flamengo', 2, 0),
(91, 'Real Madrid', 'Barcelona', 'Barcelona', 1, 2),
(92, 'Chelsea', 'Manchester United', 'Chelsea', 2, 1),
(93, 'Flamengo', 'Boca Juniors', 'Flamengo', 3, 1),
(94, 'Juventus', 'Real Madrid', 'Real Madrid', 1, 2),
(95, 'Barcelona', 'Manchester United', 'Barcelona', 2, 1),
(96, 'Bayern Munich', 'Chelsea', 'Bayern Munich', 3, 0),
(97, 'Atletico Madrid', 'Inter Milan', 'Inter Milan', 1, 3),
(98, 'PSV Eindhoven', 'Ajax', 'Ajax', 0, 2),
(99, 'Liverpool', 'Boca Juniors', 'Liverpool', 2, 0),
(100, 'AC Milan', 'Real Madrid', 'Draw', 1, 1),
(101, 'Flamengo', 'Juventus', 'Flamengo', 2, 1),
(102, 'Barcelona', 'Chelsea', 'Chelsea', 1, 2),
(103, 'Inter Milan', 'Boca Juniors', 'Inter Milan', 2, 0),
(104, 'Paris Saint-Germain', 'Real Madrid', 'Paris Saint-Germain', 3, 2),
(105, 'Lyon', 'Manchester United', 'Manchester United', 1, 2),
(106, 'Boca Juniors', 'Chelsea', 'Boca Juniors', 2, 1),
(107, 'Juventus', 'Inter Milan', 'Juventus', 3, 1),
(108, 'Real Madrid', 'AC Milan', 'Real Madrid', 2, 0),
(109, 'Liverpool', 'Chelsea', 'Chelsea', 1, 2),
(110, 'Flamengo', 'Paris Saint-Germain', 'Flamengo', 2, 0),
(111, 'Bayern Munich', 'Barcelona', 'Bayern Munich', 2, 0),
(112, 'Real Madrid', 'Inter Milan', 'Real Madrid', 1, 0),
(113, 'Liverpool', 'Juventus', 'Liverpool', 3, 2),
(114, 'AC Milan', 'PSV Eindhoven', 'AC Milan', 2, 1),
(115, 'Ajax', 'Manchester United', 'Ajax', 2, 0),
(116, 'Boca Juniors', 'Flamengo', 'Flamengo', 0, 1),
(117, 'Chelsea', 'Bayern Munich', 'Bayern Munich', 1, 2),
(118, 'Real Madrid', 'Barcelona', 'Draw', 1, 1),
(119, 'Inter Milan', 'AC Milan', 'AC Milan', 0, 1),
(120, 'Juventus', 'Liverpool', 'Juventus', 3, 2),
(121, 'PSV Eindhoven', 'Ajax', 'Ajax', 2, 0),
(122, 'Manchester United', 'Chelsea', 'Manchester United', 2, 1),
(123, 'Paris Saint-Germain', 'Boca Juniors', 'Paris Saint-Germain', 3, 0),
(124, 'Flamengo', 'Real Madrid', 'Flamengo', 1, 2),
(125, 'Barcelona', 'Inter Milan', 'Barcelona', 2, 1),
(126, 'AC Milan', 'Juventus', 'Juventus', 2, 3),
(127, 'Bayern Munich', 'Liverpool', 'Bayern Munich', 3, 1),
(128, 'Chelsea', 'Real Madrid', 'Real Madrid', 1, 2),
(129, 'Inter Milan', 'Flamengo', 'Flamengo', 1, 3),
(130, 'Paris Saint-Germain', 'Barcelona', 'Paris Saint-Germain', 2, 0),
(131, 'Manchester United', 'Boca Juniors', 'Manchester United', 2, 0),
(132, 'Juventus', 'Chelsea', 'Juventus', 2, 1),
(133, 'Real Madrid', 'Bayern Munich', 'Real Madrid', 1, 1),
(134, 'Liverpool', 'Inter Milan', 'Liverpool', 3, 1),
(135, 'AC Milan', 'Barcelona', 'Barcelona', 1, 2),
(136, 'PSV Eindhoven', 'Boca Juniors', 'PSV Eindhoven', 2, 1),
(137, 'Ajax', 'Juventus', 'Ajax', 2, 1),
(138, 'Chelsea', 'Paris Saint-Germain', 'Paris Saint-Germain', 1, 2),
(139, 'Boca Juniors', 'Inter Milan', 'Boca Juniors', 2, 1),
(140, 'Real Madrid', 'Manchester United', 'Real Madrid', 3, 2),
(141, 'Flamengo', 'Bayern Munich', 'Flamengo', 2, 1),
(142, 'Real Madrid', 'Paris Saint-Germain', 'Real Madrid', 2, 1),
(143, 'Barcelona', 'Juventus', 'Barcelona', 3, 2),
(144, 'Boca Juniors', 'River Plate', 'Boca Juniors', 1, 0),
(145, 'Bayern Munich', 'Borussia Dortmund', 'Bayern Munich', 4, 1),
(146, 'Manchester United', 'Liverpool', 'Liverpool', 1, 2),
(147, 'Inter Milan', 'AC Milan', 'Inter Milan', 2, 1),
(148, 'Paris Saint-Germain', 'Marseille', 'Paris Saint-Germain', 3, 0),
(149, 'Ajax', 'PSV Eindhoven', 'Ajax', 2, 1),
(150, 'Flamengo', 'Palmeiras', 'Flamengo', 2, 0),
(151, 'Santos', 'RB Leipzig', 'RB Leipzig', 1, 2),
(152, 'Independiente', 'Atletico Madrid', 'Atletico Madrid', 0, 1),
(153, 'Chelsea', 'Real Madrid', 'Chelsea', 2, 1),
(154, 'River Plate', 'Independiente', 'River Plate', 3, 0),
(155, 'Juventus', 'Barcelona', 'Juventus', 1, 0),
(156, 'Borussia Dortmund', 'Bayern Munich', 'Bayern Munich', 0, 3),
(157, 'Marseille', 'Lyon', 'Marseille', 2, 1),
(158, 'Lyon', 'Paris Saint-Germain', 'Paris Saint-Germain', 1, 2),
(159, 'AC Milan', 'Juventus', 'Juventus', 0, 1),
(160, 'Manchester United', 'Chelsea', 'Draw', 1, 1),
(161, 'Liverpool', 'Manchester United', 'Liverpool', 2, 0),
(162, 'FC Porto', 'Benfica', 'FC Porto', 1, 0),
(163, 'Sporting CP', 'Benfica', 'Benfica', 1, 2),
(164, 'Ajax', 'Feyenoord', 'Ajax', 3, 1),
(165, 'PSV Eindhoven', 'Feyenoord', 'PSV Eindhoven', 2, 0),
(166, 'Anderlecht', 'Club Brugge', 'Club Brugge', 1, 2),
(167, 'Standard Liège', 'Anderlecht', 'Standard Liège', 2, 1),
(168, 'Nacional', 'Peñarol', 'Draw', 1, 1),
(169, 'Peñarol', 'Defensor Sporting', 'Peñarol', 2, 0),
(170, 'Dinamo Zagreb', 'Hajduk Split', 'Dinamo Zagreb', 2, 1),
(171, 'NK Osijek', 'Dinamo Zagreb', 'NK Osijek', 1, 0),
(172, 'Atlético Nacional', 'Millonarios', 'Atlético Nacional', 2, 1),
(173, 'América de Cali', 'Millonarios', 'América de Cali', 1, 0),
(174, 'Club América', 'Chivas', 'Club América', 3, 2),
(175, 'Chivas', 'Cruz Azul', 'Chivas', 2, 1),
(176, 'FC Copenhagen', 'Brøndby IF', 'FC Copenhagen', 2, 0),
(177, 'Brøndby IF', 'Midtjylland', 'Midtjylland', 1, 2),
(178, 'Colo-Colo', 'Universidad de Chile', 'Draw', 1, 1),
(179, 'Universidad Católica', 'Colo-Colo', 'Universidad Católica', 2, 1),
(180, 'FC Basel', 'Grasshopper Club Zürich', 'FC Basel', 2, 1),
(181, 'Young Boys', 'FC Basel', 'Young Boys', 1, 0),
(182, 'Legia Warsaw', 'Lech Poznań', 'Legia Warsaw', 3, 1),
(183, 'Lech Poznań', 'Wisła Kraków', 'Lech Poznań', 2, 1),
(184, 'Benfica', 'FC Porto', 'Benfica', 1, 0),
(185, 'RB Leipzig', 'Borussia Dortmund', 'RB Leipzig', 2, 1),
(186, 'Chelsea', 'Liverpool', 'Draw', 1, 1),
(187, 'Barcelona', 'Real Madrid', 'Real Madrid', 2, 1),
(188, 'Bayern Munich', 'Borussia Dortmund', 'Bayern Munich', 3, 1),
(189, 'Inter Milan', 'Juventus', 'Inter Milan', 2, 0),
(190, 'Paris Saint-Germain', 'Marseille', 'Paris Saint-Germain', 3, 1),
(191, 'Lyon', 'Marseille', 'Lyon', 2, 1),
(192, 'Manchester United', 'Liverpool', 'Manchester United', 2, 1),
(193, 'Real Madrid', 'Atletico Madrid', 'Real Madrid', 1, 0),
(194, 'Ajax', 'PSV Eindhoven', 'Ajax', 2, 0),
(195, 'Flamengo', 'Palmeiras', 'Flamengo', 2, 0),
(196, 'Santos', 'Independiente', 'Draw', 1, 1),
(197, 'Boca Juniors', 'River Plate', 'River Plate', 0, 1),
(198, 'Inter Milan', 'AC Milan', 'Inter Milan', 2, 1),
(199, 'Chelsea', 'Manchester United', 'Chelsea', 1, 0),
(200, 'Borussia Dortmund', 'RB Leipzig', 'Borussia Dortmund', 2, 1);


INSERT INTO player_stats (player_id, goals, assists, passes_attempted, percentage_passes_completed) VALUES
(1, 12, 5, 250, 82.30),
(2, 0, 0, 220, 88.00),
(3, 8, 7, 300, 79.50),
(4, 1, 3, 260, 75.00),
(5, 5, 5, 280, 80.00),
(6, 9, 4, 310, 82.00),
(7, 4, 6, 200, 85.50),
(8, 2, 7, 190, 78.00),
(9, 7, 3, 210, 81.00),
(10, 11, 6, 240, 83.50),
(11, 0, 2, 180, 79.00),
(12, 3, 4, 230, 80.50),
(13, 10, 5, 250, 82.10),
(14, 6, 7, 270, 79.80),
(15, 1, 1, 190, 76.00),
(16, 8, 3, 260, 80.20),
(17, 7, 2, 240, 81.00),
(18, 2, 5, 220, 77.50),
(19, 14, 4, 300, 84.00),
(20, 3, 3, 210, 80.00),
(21, 5, 8, 230, 78.50),
(22, 7, 5, 250, 82.00),
(23, 9, 6, 270, 79.20),
(24, 4, 2, 220, 80.50),
(25, 11, 7, 260, 83.00),
(26, 6, 4, 240, 81.50),
(27, 8, 5, 250, 80.30),
(28, 13, 6, 300, 85.00),
(29, 7, 5, 240, 80.20),
(30, 2, 3, 210, 78.00),
(31, 10, 4, 255, 83.20),
(32, 5, 3, 230, 79.80),
(33, 7, 6, 245, 81.00),
(34, 9, 2, 265, 80.50),
(35, 3, 5, 220, 77.00),
(36, 8, 4, 250, 82.50),
(37, 12, 7, 280, 84.30),
(38, 6, 6, 240, 80.00),
(39, 4, 4, 210, 79.50),
(40, 11, 5, 260, 82.00),
(41, 2, 2, 200, 78.00),
(42, 7, 3, 230, 80.20),
(43, 9, 4, 250, 83.00),
(44, 3, 6, 220, 78.50),
(45, 10, 7, 275, 84.00),
(46, 5, 5, 240, 80.00),
(47, 8, 3, 245, 81.20),
(48, 4, 2, 215, 79.00),
(49, 12, 6, 265, 82.50),
(50, 7, 4, 240, 80.80),
(51, 3, 2, 215, 78.50),
(52, 4, 3, 220, 79.00),
(53, 5, 4, 225, 79.50),
(54, 2, 3, 210, 78.00),
(55, 7, 5, 240, 82.00),
(56, 6, 4, 235, 81.50),
(57, 4, 3, 220, 80.00),
(58, 5, 4, 230, 80.50),
(59, 3, 2, 215, 78.00),
(60, 8, 6, 250, 83.00),
(61, 4, 3, 225, 79.00),
(62, 7, 5, 245, 82.50),
(63, 5, 4, 230, 80.00),
(64, 6, 3, 220, 79.50),
(65, 3, 2, 210, 78.00),
(66, 8, 6, 255, 83.50),
(67, 5, 4, 235, 80.50),
(68, 7, 5, 240, 82.00),
(69, 4, 3, 220, 79.00),
(70, 6, 4, 230, 80.50),
(71, 5, 3, 225, 79.00),
(72, 4, 2, 215, 78.50),
(73, 7, 5, 245, 82.00),
(74, 6, 4, 230, 80.50),
(75, 5, 3, 220, 80.00),
(76, 8, 6, 250, 83.00),
(77, 4, 3, 215, 78.50),
(78, 6, 4, 225, 79.50),
(79, 7, 5, 240, 82.50),
(80, 5, 4, 235, 81.00),
(81, 3, 2, 210, 78.00),
(82, 8, 6, 250, 83.00),
(83, 5, 4, 230, 80.50),
(84, 6, 3, 220, 79.00),
(85, 7, 5, 245, 82.00),
(86, 4, 3, 215, 78.50),
(87, 5, 4, 225, 79.50),
(88, 8, 6, 240, 81.50),
(89, 6, 4, 230, 80.00),
(90, 7, 5, 245, 82.00),
(91, 5, 3, 220, 80.00),
(92, 4, 2, 210, 78.50),
(93, 6, 4, 230, 80.50),
(94, 7, 5, 240, 82.00),
(95, 5, 4, 225, 79.00),
(96, 3, 3, 215, 78.50),
(97, 8, 6, 250, 83.00),
(98, 6, 4, 235, 81.50),
(99, 5, 3, 220, 80.00),
(100, 7, 5, 245, 82.00),
(101, 4, 3, 215, 79.00),
(102, 8, 6, 255, 83.50),
(103, 5, 4, 230, 80.50),
(104, 6, 3, 220, 79.00),
(105, 3, 2, 210, 78.00),
(106, 7, 5, 245, 82.00),
(107, 5, 4, 225, 79.00),
(108, 6, 4, 230, 80.50),
(109, 8, 6, 250, 83.00),
(110, 4, 3, 215, 79.00),
(111, 7, 5, 240, 82.00),
(112, 5, 3, 220, 80.00),
(113, 4, 2, 215, 78.50),
(114, 6, 4, 230, 80.50),
(115, 3, 3, 210, 78.00),
(116, 8, 6, 250, 83.00),
(117, 5, 4, 225, 79.50),
(118, 6, 3, 220, 80.00),
(119, 7, 5, 240, 82.50),
(120, 4, 3, 215, 79.00),
(121, 5, 4, 225, 80.00),
(122, 8, 6, 250, 83.00),
(123, 6, 3, 230, 80.50),
(124, 7, 5, 245, 82.00),
(125, 4, 3, 220, 79.00),
(126, 5, 4, 230, 80.50),
(127, 3, 2, 210, 78.00),
(128, 8, 6, 255, 83.50),
(129, 6, 4, 235, 81.50),
(130, 7, 5, 245, 82.00),
(131, 4, 3, 215, 79.00),
(132, 5, 4, 225, 80.00),
(133, 7, 5, 240, 82.00),
(134, 6, 4, 230, 80.50),
(135, 5, 3, 220, 79.00),
(136, 3, 2, 210, 78.50),
(137, 8, 6, 250, 83.00),
(138, 6, 4, 235, 81.50),
(139, 5, 3, 220, 80.00),
(140, 7, 5, 245, 82.00),
(141, 4, 3, 215, 79.00),
(142, 5, 4, 225, 80.50),
(143, 7, 5, 240, 82.50),
(144, 6, 4, 230, 80.00),
(145, 3, 2, 210, 78.00),
(146, 8, 6, 250, 83.00),
(147, 5, 4, 225, 79.50),
(148, 6, 3, 220, 80.00),
(149, 7, 5, 240, 82.00),
(150, 4, 3, 215, 79.00),
(151, 8, 4, 240, 81.50),
(152, 5, 5, 230, 80.00),
(153, 7, 3, 250, 82.00),
(154, 6, 4, 220, 79.00),
(155, 9, 5, 260, 83.00),
(156, 4, 3, 210, 78.50),
(157, 10, 6, 270, 84.00),
(158, 3, 3, 200, 77.00),
(159, 8, 7, 250, 81.50),
(160, 7, 4, 230, 80.00),
(161, 5, 2, 215, 79.00),
(162, 9, 6, 250, 82.00),
(163, 4, 3, 220, 78.50),
(164, 6, 5, 240, 80.00),
(165, 7, 4, 245, 81.50),
(166, 8, 3, 230, 80.00),
(167, 5, 5, 220, 78.50),
(168, 7, 6, 240, 80.50),
(169, 6, 4, 230, 79.00),
(170, 8, 7, 250, 82.00),
(171, 9, 5, 260, 83.50),
(172, 4, 2, 210, 78.00),
(173, 10, 6, 270, 84.00),
(174, 3, 4, 200, 77.50),
(175, 8, 5, 250, 81.00),
(176, 7, 3, 230, 80.50),
(177, 6, 4, 220, 79.50),
(178, 9, 7, 260, 83.00),
(179, 5, 4, 240, 80.00),
(180, 7, 5, 245, 81.50),
(181, 6, 3, 230, 79.00),
(182, 8, 4, 250, 82.00),
(183, 7, 6, 240, 80.50),
(184, 5, 3, 220, 78.50),
(185, 9, 5, 260, 83.00),
(186, 4, 4, 210, 78.00),
(187, 8, 7, 250, 81.50),
(188, 7, 3, 230, 80.00),
(189, 6, 5, 220, 79.00),
(190, 10, 6, 270, 84.50),
(191, 5, 3, 215, 78.50),
(192, 8, 5, 240, 81.00),
(193, 7, 4, 230, 80.50),
(194, 6, 3, 220, 79.00),
(195, 9, 5, 260, 83.00),
(196, 4, 4, 210, 78.50),
(197, 8, 6, 250, 81.50),
(198, 7, 5, 230, 80.00),
(199, 6, 4, 220, 79.50),
(200, 10, 7, 270, 84.00),
(201, 8, 5, 240, 81.50),
(202, 6, 3, 230, 80.00),
(203, 7, 4, 235, 80.50),
(204, 9, 6, 250, 82.00),
(205, 10, 7, 260, 83.00),
(206, 4, 2, 210, 78.50),
(207, 5, 3, 220, 79.00),
(208, 7, 4, 230, 80.00),
(209, 6, 3, 220, 79.50),
(210, 8, 5, 240, 81.00),
(211, 9, 6, 250, 82.50),
(212, 5, 3, 220, 80.00),
(213, 7, 4, 230, 81.50),
(214, 10, 7, 260, 83.50),
(215, 4, 3, 215, 78.50),
(216, 7, 5, 245, 82.00),
(217, 6, 4, 230, 80.50),
(218, 8, 3, 225, 79.50),
(219, 5, 2, 210, 78.00),
(220, 9, 5, 250, 82.00),
(221, 7, 4, 230, 80.00),
(222, 8, 6, 255, 83.00),
(223, 6, 5, 240, 81.00),
(224, 7, 3, 220, 79.50),
(225, 5, 4, 230, 80.50),
(226, 10, 6, 270, 84.00),
(227, 8, 5, 240, 81.50),
(228, 9, 4, 250, 82.00),
(229, 6, 3, 220, 79.00),
(230, 7, 4, 230, 80.50),
(231, 8, 6, 240, 81.00),
(232, 5, 3, 215, 78.50),
(233, 7, 5, 245, 82.00),
(234, 6, 4, 230, 80.00),
(235, 8, 7, 250, 83.00),
(236, 9, 6, 260, 83.50),
(237, 7, 4, 240, 81.00),
(238, 5, 3, 220, 80.50),
(239, 8, 5, 230, 81.00),
(240, 6, 4, 220, 79.00),
(241, 7, 5, 240, 82.00),
(242, 8, 6, 250, 83.00),
(243, 9, 5, 260, 83.50),
(244, 4, 2, 210, 78.50),
(245, 7, 4, 230, 80.00),
(246, 6, 3, 220, 79.00),
(247, 8, 5, 240, 81.00),
(248, 10, 7, 260, 83.50),
(249, 5, 3, 215, 78.50),
(250, 7, 4, 230, 80.00),
(251, 6, 4, 230, 81.50),
(252, 7, 4, 235, 82.00),
(253, 5, 5, 225, 80.00),
(254, 8, 3, 240, 83.00),
(255, 4, 2, 210, 78.50),
(256, 9, 5, 250, 82.50),
(257, 6, 4, 220, 80.00),
(258, 7, 6, 245, 82.00),
(259, 5, 3, 215, 79.50),
(260, 8, 5, 230, 80.50),
(261, 6, 4, 220, 79.00),
(262, 7, 4, 225, 80.00),
(263, 5, 3, 210, 78.00),
(264, 8, 6, 250, 83.00),
(265, 4, 2, 215, 78.50),
(266, 7, 5, 240, 81.50),
(267, 6, 3, 220, 80.00),
(268, 8, 4, 230, 80.50),
(269, 5, 3, 210, 78.50),
(270, 7, 4, 225, 80.00),
(271, 6, 4, 230, 81.00),
(272, 8, 5, 240, 82.00),
(273, 4, 2, 215, 78.00),
(274, 7, 5, 245, 81.50),
(275, 6, 4, 230, 80.50),
(276, 8, 6, 250, 83.00),
(277, 5, 3, 215, 79.50),
(278, 7, 4, 225, 80.50),
(279, 6, 3, 220, 80.00),
(280, 8, 5, 230, 81.50),
(281, 4, 3, 210, 78.50),
(282, 7, 5, 245, 82.00),
(283, 6, 4, 230, 80.50),
(284, 8, 6, 250, 83.50),
(285, 5, 3, 215, 79.00),
(286, 7, 4, 225, 80.00),
(287, 6, 3, 220, 80.50),
(288, 8, 5, 230, 81.00),
(289, 4, 2, 210, 78.00),
(290, 7, 6, 245, 81.50),
(291, 6, 4, 230, 80.00),
(292, 8, 5, 240, 82.00),
(293, 5, 3, 215, 79.50),
(294, 7, 4, 225, 80.00),
(295, 6, 3, 220, 80.50),
(296, 8, 5, 230, 81.50),
(297, 4, 2, 210, 78.50),
(298, 7, 6, 245, 82.00),
(299, 6, 4, 230, 80.00),
(300, 8, 5, 240, 82.50);

-- Match 1: Boca Juniors vs River Plate
INSERT INTO player_matches (match_id, player_id) VALUES
(1, 1),  (1, 2),  (1, 3),  -- Boca Juniors players
(1, 4),  (1, 5),  (1, 6);  -- River Plate players

-- Match 2: Bayern Munich vs Borussia Dortmund
INSERT INTO player_matches (match_id, player_id) VALUES
(2, 19), (2, 20), (2, 21),  -- Bayern Munich players
(2, 22), (2, 23), (2, 24);  -- Borussia Dortmund players

-- Match 3: Real Madrid vs Barcelona
INSERT INTO player_matches (match_id, player_id) VALUES
(3, 37), (3, 38), (3, 39),  -- Real Madrid players
(3, 40), (3, 41), (3, 42);  -- Barcelona players

-- Match 4: Manchester United vs Liverpool
INSERT INTO player_matches (match_id, player_id) VALUES
(4, 55), (4, 56), (4, 57),  -- Manchester United players
(4, 58), (4, 59), (4, 60);  -- Liverpool players

-- Match 5: Juventus vs AC Milan
INSERT INTO player_matches (match_id, player_id) VALUES
(5, 46), (5, 47), (5, 48),  -- Juventus players
(5, 49), (5, 50), (5, 51);  -- AC Milan players

-- Match 6: Paris Saint-Germain vs Marseille
INSERT INTO player_matches (match_id, player_id) VALUES
(6, 28), (6, 29), (6, 30),  -- PSG players
(6, 31), (6, 32), (6, 33);  -- Marseille players

-- Match 7: Ajax vs PSV Eindhoven
INSERT INTO player_matches (match_id, player_id) VALUES
(7, 73), (7, 74), (7, 75),  -- Ajax players
(7, 76), (7, 77), (7, 78);  -- PSV Eindhoven players

-- Match 8: Zenit St. Petersburg vs Spartak Moscow
INSERT INTO player_matches (match_id, player_id) VALUES
(8, 172), (8, 173), (8, 174),  -- Zenit players
(8, 169), (8, 170), (8, 171);  -- Spartak Moscow players

INSERT INTO player_matches (match_id, player_id) VALUES
(9, 100), (9, 101), (9, 102),
(10, 103), (10, 104), (10, 105),
(11, 106), (11, 107), (11, 108),
(12, 109), (12, 110), (12, 111),
(13, 112), (13, 113), (13, 114),
(14, 115), (14, 116), (14, 117),
(15, 118), (15, 119), (15, 120),
(16, 121), (16, 122), (16, 123),
(17, 124), (17, 125), (17, 126),
(18, 127), (18, 128), (18, 129),
(19, 130), (19, 131), (19, 132),
(20, 133), (20, 134), (20, 135),
(21, 136), (21, 137), (21, 138),
(22, 139), (22, 140), (22, 141),
(23, 142), (23, 143), (23, 144),
(24, 145), (24, 146), (24, 147),
(25,148), (25,149), (25,150),
(26,151), (26,152), (26,153),
(27,154), (27,155), (27,156),
(28,157), (28,158), (28,159),
(29,160), (29,161), (29,162),
(30,163), (30,164), (30,165),
(31,166), (31,167), (31,168),
(32,169), (32,170), (32,171),
(33,172), (33,173), (33,174),
(34,175), (34,176), (34,177),
(35,178), (35,179), (35,180),
(36,181), (36,182), (36,183),
(37,184), (37,185), (37,186),
(38,187), (38,188), (38,189),
(39,190), (39,191), (39,192),
(40,193), (40,194), (40,195),
(41, 196), (41, 197), (41, 198),
(42, 199), (42, 200), (42, 201),
(43, 202), (43, 203), (43, 204),
(44, 205), (44, 206), (44, 207),
(45, 208), (45, 209), (45, 210),
(46, 211), (46, 212), (46, 213),
(47, 214), (47, 215), (47, 216),
(48, 217), (48, 218), (48, 219),
(49, 220), (49, 221), (49, 222),
(50, 223), (50, 224), (50, 225),
(51, 226), (51, 227), (51, 228),
(52, 229), (52, 230), (52, 231),
(53, 232), (53, 233), (53, 234),
(54, 235), (54, 236), (54, 237),
(55, 238), (55, 239), (55, 240),
(56, 241), (56, 242), (56, 243),
(57, 244), (57, 245), (57, 246),
(58, 247), (58, 248), (58, 249),
(59, 250), (59, 251), (59, 252),
(60, 253), (60, 254), (60, 255),
(61, 256), (61, 257), (61, 258),
(62, 259), (62, 260), (62, 261),
(63, 262), (63, 263), (63, 264),
(64, 265), (64, 266), (64, 267),
(65, 268), (65, 269), (65, 270),
(66, 271), (66, 272), (66, 273),
(67, 274), (67, 275), (67, 276),
(68, 277), (68, 278), (68, 279),
(69, 280), (69, 281), (69, 282),
(70, 283), (70, 284), (70, 285),
(71, 286), (71, 287), (71, 288),
(72, 289), (72, 290), (72, 291),
(73, 292), (73, 293), (73, 294),
(74, 295), (74, 296), (74, 297);

INSERT INTO player_matches (match_id, player_id) VALUES
(75, 151), (75, 152), (75, 153), (75, 154), (75, 155), (75, 156),
(76, 157), (76, 158), (76, 159), (76, 160), (76, 161), (76, 162),
(77, 163), (77, 164), (77, 165), (77, 166), (77, 167), (77, 168),
(78, 169), (78, 170), (78, 171), (78, 172), (78, 173), (78, 174),
(79, 175), (79, 176), (79, 177), (79, 178), (79, 179), (79, 180),
(80, 181), (80, 182), (80, 183), (80, 184), (80, 185), (80, 186),
(81, 187), (81, 188), (81, 189), (81, 190), (81, 191), (81, 192),
(82, 193), (82, 194), (82, 195), (82, 196), (82, 197), (82, 198),
(83, 199), (83, 200), (83, 201), (83, 202), (83, 203), (83, 204),
(84, 205), (84, 206), (84, 207), (84, 208), (84, 209), (84, 210),
(85, 211), (85, 212), (85, 213), (85, 214), (85, 215), (85, 216),
(86, 217), (86, 218), (86, 219), (86, 220), (86, 221), (86, 222),
(87, 223), (87, 224), (87, 225), (87, 226), (87, 227), (87, 228),
(88, 229), (88, 230), (88, 231), (88, 232), (88, 233), (88, 234),
(89, 235), (89, 236), (89, 237), (89, 238), (89, 239), (89, 240),
(90, 241), (90, 242), (90, 243), (90, 244), (90, 245), (90, 246),
(91, 247), (91, 248), (91, 249), (91, 250), (91, 251), (91, 252),
(92, 253), (92, 254), (92, 255), (92, 256), (92, 257), (92, 258),
(93, 259), (93, 260), (93, 261), (93, 262), (93, 263), (93, 264),
(94, 265), (94, 266), (94, 267), (94, 268), (94, 269), (94, 270),
(95, 271), (95, 272), (95, 273), (95, 274), (95, 275), (95, 276),
(96, 277), (96, 278), (96, 279), (96, 280), (96, 281), (96, 282),
(97, 283), (97, 284), (97, 285), (97, 286), (97, 287), (97, 288),
(98, 289), (98, 290), (98, 291), (98, 292), (98, 293), (98, 294),
(99, 295), (99, 296), (99, 297), (99, 298), (99, 299), (99, 300);