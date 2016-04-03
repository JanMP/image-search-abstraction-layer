request = require "request"
path = process.cwd()
SearchEntry = require path + "/app/models/searches.js"

urlStr = "https://www.googleapis.com/customsearch/v1?key=AIzaSyD79lKLhaHzunEXAj_bYMkwVI3lx-dYdxM&cx=007414649059824118455:2qstsvfxe1o&searchType=image&q="

module.exports = ->
  
  search : (req, res) ->
    query= req.params.query
    offset = req.query.offset ? 0
    request
      url : urlStr + query + "?startIndex=" + offset
      json : true
      (err, msg, data) ->
        if err then throw err
        res.send data.items?.map (d) ->
          imageURL : d.link
          thumpnailURL : d.image.thumbnailLink
          altText : d.snippet
          pageURL : d.image.contextLink
        searchEntry = new SearchEntry
          query : query
          offset : Number offset
          date : new Date()
        searchEntry.save (err, entry) ->
          if err then throw err
          console.log "#{entry.date} : #{entry.query} : #{offset}"
          
    
  list : (req, res) ->
    SearchEntry.find {}
    .sort date : -1
    .limit 10
    .exec (err, list) ->
      if err then throw err
      res.send list.map (d) ->
        query : d.query
        offset : d.offset
        date : d.date
    