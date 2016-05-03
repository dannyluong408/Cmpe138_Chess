SET foreign_key_checks = 0;
use chess;
 
-- drop table gameboard_type;
-- drop table developer;
-- drop table lobby_stats;
-- drop table moderator;
-- drop table viewer_slot;
-- drop table game_history;
-- drop table player;
-- drop table user_info;
-- drop table lobby;
 
create table lobby(
    player_waitlist     integer,
        min_skill       integer,
        lobby_id        integer not null,
        primary key (lobby_id)
);
 
create table gameboard_type(
    timer           float(4,2),     #minutes.seconds
    grid_number     char(2),
    board_color     varchar(10),
    piece_color     char(5),
    name            varchar(15) not null,
    lobby_id        integer not null,
    primary key (lobby_id,name),
    foreign key (lobby_id) references lobby(lobby_id)
);
 
create table lobby_stats(
    pieces_taken        integer,
        avg_gametime        float(4,2),     #hours.minutes
    avg_movetime        float(4,2),     #minutes.seconds
        games_in_lobby      integer,
        avg_moves_per_game  float(4,2),
        users_joined        integer,
        lobby_id        integer not null,
#   primary key (lobby_id),                 #FIX
        foreign key (lobby_id) references lobby(lobby_id)   #FIX
);
 
create table user_info(
    id          varchar(25) not null,
    email           varchar(25),
    password        char(64),            #char 64 for sha256
    active_lobby        integer,
    unique (email),
    primary key (id),
    foreign key (active_lobby) references lobby(lobby_id)
);
 
create table viewer_slot(
    viewer          varchar(25) not null,
        lobby_id        integer not null,
        primary key     (lobby_id),
        foreign key (lobby_id) references lobby(lobby_id),
        foreign key (viewer) references user_info(id)
);
 
 
create table player(
    player_since        char(10) not null,      #MM/DD/YYYY
    streak          char(2),
    player_id       varchar(25) not null,
    skill           integer,
    past_punishments    varchar(15),
    primary key (player_id),
    foreign key (player_id) references user_info(id)
);
 
create table game_history(
    avg_movetime        float(4,2),             #minute.second
    match_id        integer not null,
    match_length        float(4,2),             #hour.minute
    replay_id       integer,
    elo_change      integer,
    winner          varchar(15),
    date_time       char(16),               #MM/DD/YYYY:HH.MM
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


--Sample user_info data
 
-- danny/gamer123 86333ac84810343f726a58b2d531574c6d42d8e88e34035999040d50541d6fe6
INSERT INTO `user_info` (`id`, `email`, `password`, `active_lobby`) VALUES ('danny', 'danny@gmail.com', '86333ac84810343f726a58b2d531574c6d42d8e88e34035999040d50541d6fe6', NULL);
 
-- danny2/gamer321 89b01f18f88e95d8890e70b471f705b33573e712fbe0bebc766104fdd4637888
INSERT INTO `user_info` (`id`, `email`, `password`, `active_lobby`) VALUES ('danny2', 'danny2@gmail.com', '89b01f18f88e95d8890e70b471f705b33573e712fbe0bebc766104fdd4637888', NULL);
 
-- user1/gamer1 fda50cb79dc9e7589aa6df29cfb7db27fdd7ed62482ec7c72dde6a28e8fed5e7
INSERT INTO `user_info` (`id`, `email`, `password`, `active_lobby`) VALUES ('user1', 'user1@gmail.com', 'fda50cb79dc9e7589aa6df29cfb7db27fdd7ed62482ec7c72dde6a28e8fed5e7', NULL);
 
-- user2/gamer2 f66f158b49308430821743acc354c6419b1c8cdfd5383472d5987fa3ba99c20esh
INSERT INTO `user_info` (`id`, `email`, `password`, `active_lobby`) VALUES ('user2', 'user2\@gmail.com', 'f66f158b49308430821743acc354c6419b1c8cdfd5383472d5987fa3ba99c20e', NULL);
 
-- user3/gamer3 49a0a464ee6d980ed2b59d6ca11d985c5ca0695a806f7db6033d11c640f893ac
INSERT INTO `user_info` (`id`, `email`, `password`, `active_lobby`) VALUES ('user3', 'user3\@gmail.com', '49a0a464ee6d980ed2b59d6ca11d985c5ca0695a806f7db6033d11c640f893ac', NULL);
 
-- user4/gamer4 99020a9607bfeb1576193e8489981364edca75a5a6f6b9a3d91b9a6af3efa5b5
INSERT INTO `user_info` (`id`, `email`, `password`, `active_lobby`) VALUES ('user4', 'user4\@gmail.com', '99020a9607bfeb1576193e8489981364edca75a5a6f6b9a3d91b9a6af3efa5b5', NULL);
 
-- user5/gamer5 1fabc4846ca29959fe6c7bf3796c1a7ed19b5cb37b69ef62d2034b722b96d60d
INSERT INTO `user_info` (`id`, `email`, `password`, `active_lobby`) VALUES ('user5', 'user5@gmail.com', '1fabc4846ca29959fe6c7bf3796c1a7ed19b5cb37b69ef62d2034b722b96d60d', NULL);
 
-- user6/gamer6 148d6daa89eaafc744e22984187258c42b1e17d313e2345136de579ecba466f6
INSERT INTO `user_info` (`id`, `email`, `password`, `active_lobby`) VALUES ('user6', 'user6@gmail.com', '148d6daa89eaafc744e22984187258c42b1e17d313e2345136de579ecba466f6', NULL);
