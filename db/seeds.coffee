async = require 'async'
mongoose = require 'mongoose'

Player = require '../models/player'
Game = require '../models/game'
Server = require '../models/server'

module.exports = (done) ->
  ##########
  # PLAYERS
  ##########
  albireox = new Player name: 'albireox'
  mongong = new Player name: 'Mongong'
  bluejayway = new Player name: 'BlueJayWay'
  photon75 = new Player name: 'Photon75'
  svinnik = new Player name: 'Svinnik'

  ##########
  # SERVERS
  ##########
  server1 = new Server
    ip: 'a.mcsg.co'
    location: 'USA'
    secret: 'secretkey'
    ping_port: 25809

  ##########
  # GAMES
  ##########
  game1 = new Game
    server: server1
    type: 'Normal'
    date: Date.now() - (8 * 60 * 60 * 1000) # 8 hours ago
    rankings: [
      {
        time: 400 # Winner
        player: albireox
        kills: [mongong, bluejayway]
        class: 'Lumberjack'
        rank: 1
      },
      {
        time: 400 # Last kill; game lasted 400 seconds
        player: mongong
        kills: []
        class: 'Firefighter'
        rank: 2
      },
      {
        time: 200 # BJW died 200 seconds after start of game
        player: bluejayway
        kills: []
        class: 'Firefighter'
        rank: 3
      }
    ]

  game2 = new Game
    server: server1
    type: 'Desert'
    date: Date.now() - (12 * 60 * 60 * 1000) # 12 hours ago
    rankings: [
      {
        time: 200 # Winner
        player: albireox
        kills: [photon75]
        class: 'Warrior'
        rank: 1
      },
      {
        time: 200 # Game lasted 200 seconds
        player: photon75
        kills: [svinnik]
        class: 'Archer'
        rank: 2
      },
      {
        time: 50
        player: svinnik
        kills: []
        class: 'Hacker' # :p
        rank: 3
      }
    ]

  game3 = new Game
    server: server1
    type: 'Desert'
    date: Date.now() - (36 * 60 * 60 * 1000) # 36 hours ago
    rankings: [
      {
        time: 300 # Winner
        player: albireox
        kills: [photon75]
        class: 'Warrior'
        rank: 1
      },
      {
        time: 300 # Game lasted 300 seconds
        player: photon75
        kills: [svinnik]
        class: 'Archer'
        rank: 2
      },
      {
        time: 70
        player: svinnik
        kills: []
        class: 'Hacker' # :p
        rank: 3
      }
    ]

  # Save it all!
  async.parallel [
    # Players
    (cb) -> albireox.save cb,
    (cb) -> mongong.save cb,
    (cb) -> bluejayway.save cb,
    (cb) -> photon75.save cb,
    (cb) -> svinnik.save cb,

    # Games
    (cb) -> game1.save cb,
    (cb) -> game2.save cb,
    (cb) -> game3.save cb,

    # Servers
    (cb) -> server1.save cb
  ], (err, results) ->
    done()
