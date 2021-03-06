Game = require '../models/game'
Player = require '../models/player'

module.exports = 
  view: (req, res) ->
    name = req.params.name
    Player.findOne name_lower: name.toLowerCase(), (err, player) ->
      if err or not player?
        return res.render 'player404.jade'
          status: 404
          name: req.params.name

      player.prettyStatReport (err, stats) ->
        res.render 'player/player.jade',
          player: player
          stats: stats
          games: Game.find().where('rankings.player', player._id).populate('rankings.killer').limit(25).exec()
