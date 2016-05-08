SET foreign_key_checks = 0;
-- drop database if exists chess;
-- create database chess;
use chess;
 
 drop table gameboard_type;
 drop table developer;
 drop table lobby_stats;
 drop table moderator;
 drop table game_history;
 drop table player;
 drop table user_info;
 drop table lobby;
 
create table lobby(
        lobby_id        integer not null,
        min_skill       integer,
    player_waitlist     integer,
        primary key (lobby_id)
);
 
create table gameboard_type(
    name            varchar(15) not null,
    lobby_id        integer not null,
    timer           varchar(8),     #hours:minutes:seconds
    board_color     varchar(15),
    piece_color     char(15),
    primary key (lobby_id,name),
    foreign key (lobby_id) references lobby(lobby_id)
);
 
create table lobby_stats(
        stat_id        integer not null,
        games_in_lobby      integer,
        avg_gametime        varchar(8),     #hours:minutes:seconds
    pieces_taken        integer,
    avg_movetime        varchar(8),     #hours:minutes:seconds
        avg_moves_per_game  float(4,2),
        users_joined        integer,
   primary key (stat_id),                 
        foreign key (stat_id) references lobby(lobby_id)   
);
 
create table user_info(
    id          varchar(25) not null,
    email           varchar(40),
    password        char(64),            #char 64 for sha256
    active_lobby        integer,
    unique (email),
    primary key (id),
	foreign key (active_lobby) references lobby(lobby_id)   
);
 
create table player(
    player_id       varchar(25) not null,
    skill           integer,
    player_since        char(10) not null,      #MM/DD/YYYY
    streak          varchar(3),
    past_punishments    integer,
    primary key (player_id),
    foreign key (player_id) references user_info(id)
);
 
create table game_history(
    match_id        integer not null,
    avg_movetime        varchar(8),     #hours:minutes:seconds
    match_length        varchar(8),     #hours:minutes:seconds
    replay_id       integer,
    elo_change      integer,
    winner          varchar(15),
    date_time       char(19),               #MM/DD/YYYY@HH:MM:SS
    l_id        integer not null,
    p_id        varchar(25) not null,
    primary key (match_id),
    foreign key (l_id) references lobby(lobby_id),
    foreign key (p_id) references player(player_id)
);

create table developer(
    fname           varchar(15) not null,
    lname           varchar(15) not null,
    dev_id          varchar(25) not null,
    dev_rights      varchar(15) not null,
    primary key (dev_id),
    foreign key (dev_id) references user_info(id)
);
 
create table moderator(
    fname           varchar(15) not null,
    lname           varchar(15) not null,
    mod_id          varchar(25) not null,
    admin_powers        varchar(15) not null,
    primary key (mod_id),
    foreign key (mod_id) references user_info(id)
);
 
SET foreign_key_checks = 1;

#=====================================================================LOBBY=====================================================================

insert into lobby (lobby_id, min_skill, player_waitlist) values (1, 1, 3);
insert into lobby (lobby_id, min_skill, player_waitlist) values (2, 25, 1);
insert into lobby (lobby_id, min_skill, player_waitlist) values (0, 0, 0);

#=====================================================================USERS=====================================================================

insert into user_info (id, email, password, active_lobby) values ('vasquo', 'lvasquez0@yahoo.co.jp', 'c3973cb9194c1b7ac13bc03c3ff1e80dccbaa00bc455dc74679125119472675c', 1);
insert into user_info (id, email, password, active_lobby) values ('agarrett1', 'dweaver1@artisteer.com', '4904e2f6bfaef020c6fd0f97398c7cd5bb3bd066fb0601646c91505aea195628', 2);
insert into user_info (id, email, password, active_lobby) values ('rgreene2', 'rgreene2@chicagotribune.com', 'e90bb43dd00e4b9c2feafe726ed3deb15dbda8b10b218ee9c2d3ac7e3c5eecb1', 0);
insert into user_info (id, email, password, active_lobby) values ('jwallace3', 'hgreene3@studiopress.com', '72f0d11aaf4dbfa6d90865cc2ddeaee5705ba8487ee69ef7c11e88f6a42a0d7d', 0);
insert into user_info (id, email, password, active_lobby) values ('darknight1', 'jcarr4@discuz.net', '6acd86ac6cc424e4b5b0499f95f83238e9d18d445c83e1b5b939b862953a3d52', 2);
insert into user_info (id, email, password, active_lobby) values ('blawson5', 'arodriguez5@posterous.com', '1eb31c31180e0354a5888bb91af23b34bab8c0a91359ffd1b8163d971a6fa420', 2);
insert into user_info (id, email, password, active_lobby) values ('enginerd4', 'rhill6@edublogs.org', 'c46c7138780f2bac09b940d85117917869e342952d2ccab9cebf1b7f3064607b', 2);
insert into user_info (id, email, password, active_lobby) values ('damarsh', 'dmarshall7@amazon.com', '5c478bcf8410a4461f3a15993f9d47f15bfcefe720329f3859eacf2c027e6635', 1);
insert into user_info (id, email, password, active_lobby) values ('astephens8', 'awagner8@wp.com', '86970ca14a7060b9400e3910d2e8a3fb57ca1f52eb8a307850b727365d680e13', 0);
insert into user_info (id, email, password, active_lobby) values ('cramos9', 'cramos9@stanford.edu', '24cd89673ad5ca0c4b6f89ac403cb3788c708530f8919f25542ec8974c532401', 2);
insert into user_info (id, email, password, active_lobby) values ('bgrahama', 'mmoralesa@sogou.com', 'c4e52bddfb2eb08191ddd4acfdc34339c4c68280236c1f05338d8f5cdddf261c', 0);
insert into user_info (id, email, password, active_lobby) values ('rufflife', 'amendozab@sfgate.com', 'f5704a4ba375ebf5c29ce3a02c7b631390c70a7cfe681dc7651328d22c51af47', 1);
insert into user_info (id, email, password, active_lobby) values ('ljamesc', 'scampbellc@examiner.com', '6be7c8a09fdde88f8fdcb6cc654c5486a21ba3830ff3c6d64ff95d16522f1c54', 2);
insert into user_info (id, email, password, active_lobby) values ('crusselld', 'iallend@google.pl', '5faa5ad144c7d441e396a613cab60379794889724e9cafa1940875bd243ff855', 2);
insert into user_info (id, email, password, active_lobby) values ('lwebbe', 'molivere@skype.com', '963aeb2af1bc41e881342f6b553adc6c73e9168bb63b86179b36040c1f6ccdd3', 0);

#=====================================================================PLAYERS=====================================================================

insert into player (player_since, skill, past_punishments, streak, player_id) values ('12/14/2015', 18, 4, 'L3', 'vasquo');
insert into player (player_since, skill, past_punishments, streak, player_id) values ('01/30/2016', 46, 0, 'L2', 'agarrett1');
insert into player (player_since, skill, past_punishments, streak, player_id) values ('10/05/2014', 1, 2, 'W1', 'rgreene2');
insert into player (player_since, skill, past_punishments, streak, player_id) values ('04/13/2016', 0, 0, 'NA', 'jwallace3');
insert into player (player_since, skill, past_punishments, streak, player_id) values ('05/02/2016', 0, 0, 'NA', 'darknight1');
insert into player (player_since, skill, past_punishments, streak, player_id) values ('05/20/2014', 53, 0, 'L1', 'blawson5');
insert into player (player_since, skill, past_punishments, streak, player_id) values ('03/02/2016', 23, 1, 'W5', 'damarsh');
insert into player (player_since, skill, past_punishments, streak, player_id) values ('05/24/2015', 93, 1, 'W13', 'enginerd4');
insert into player (player_since, skill, past_punishments, streak, player_id) values ('10/19/2015', 6, 0, 'L10', 'astephens8');
insert into player (player_since, skill, past_punishments, streak, player_id) values ('08/26/2015', 32, 0, 'W1', 'cramos9');

#=====================================================================DEVS=====================================================================

insert into developer (fname, lname, dev_id, dev_rights) values ('Alex', 'Morales', 'bgrahama', 'Developer');
insert into developer (fname, lname, dev_id, dev_rights) values ('Amy', 'Mendoza', 'rufflife', 'Developer');
insert into developer (fname, lname, dev_id, dev_rights) values ('Larry', 'James', 'ljamesc', 'QA');

#=====================================================================MODS=====================================================================

insert into moderator (fname, lname, mod_id, admin_powers) values ('Christina', 'Russell', 'crusselld', 'Full');
insert into moderator (fname, lname, mod_id, admin_powers) values ('Lou', 'Webbe', 'lwebbe', 'Limited');

#=====================================================================GAMEBOARD TYPE=====================================================================

insert into gameboard_type (name, lobby_id, timer, board_color, piece_color) values ('Jungle', 2, '00:12:00', 'Green', 'Indigo');
insert into gameboard_type (name, lobby_id, timer, board_color, piece_color) values ('Ocean', 2, '01:00:00', 'Blue', 'Pink');
insert into gameboard_type (name, lobby_id, timer, board_color, piece_color) values ('Rose', 2, '12:00:00', 'Red', 'Red');
insert into gameboard_type (name, lobby_id, timer, board_color, piece_color) values ('Unicorn', 1, '00:03:00', 'Violet', 'Turquoise');
insert into gameboard_type (name, lobby_id, timer, board_color, piece_color) values ('Basketball', 2, '00:05:00', 'Orange', 'Purple');
insert into gameboard_type (name, lobby_id, timer, board_color, piece_color) values ('Ocean', 1, '00:20:00', 'Teal', 'Blue');

#=====================================================================LOBBY STATS=====================================================================

insert into lobby_stats (stat_id, games_in_lobby, avg_gametime, pieces_taken, avg_movetime, avg_moves_per_game, users_joined) values (1, 53, '03:09:16', 762, '00:11:26', 22.7, 112);
insert into lobby_stats (stat_id, games_in_lobby, avg_gametime, pieces_taken, avg_movetime, avg_moves_per_game, users_joined) values (2, 22, '04:03:52', 339, '00:17:28', 31.08, 52);

#=====================================================================GAME HISTORY=====================================================================

insert into game_history (match_id, avg_movetime, match_length, replay_id, elo_change, winner, date_time, l_id, p_id) values (70730, '00:11:43', '02:26:00', 48396, 3, 'blawson5', '02/14/2016@03:07:37', 1, 'blawson5');
insert into game_history (match_id, avg_movetime, match_length, replay_id, elo_change, winner, date_time, l_id, p_id) values (77091, '03:08:24', '44:05:37', 70145, -1, 'enginerd4', '01/10/2016@14:09:08', 2, 'damarsh');
insert into game_history (match_id, avg_movetime, match_length, replay_id, elo_change, winner, date_time, l_id, p_id) values (28502, '00:37:09', '04:07:45', 46349, 4, 'damarsh', '11/03/2015@15:01:22', 2, 'damarsh');
insert into game_history (match_id, avg_movetime, match_length, replay_id, elo_change, winner, date_time, l_id, p_id) values (42450, '01:03:17', '23:42:10', 70093, 3, 'vasquo', '11/06/2015@12:54:55', 2, 'vasquo');
insert into game_history (match_id, avg_movetime, match_length, replay_id, elo_change, winner, date_time, l_id, p_id) values (66070, '00:12:09', '05:11:05', 79598, -5, 'rgreene2', '06/11/2015@23:45:08', 1, 'cramos9');
