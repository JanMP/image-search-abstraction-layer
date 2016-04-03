mongoose = require "mongoose"
Schema = mongoose.Schema

SearchEntry = new Schema
  query : String
  offset : Number
  date : Date
  
module.exports = mongoose.model "SearchEntry", SearchEntry