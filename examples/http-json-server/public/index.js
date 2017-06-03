require('../css/main.css')
var logoPath = require('../media/logo.svg')
var Elm = require('../../src/App.elm')

var root = document.getElementById('root')

Elm.App.embed(root, logoPath)
