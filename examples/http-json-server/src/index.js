import './main.css'
const Elm = require('./App.elm')

const root = document.getElementById('root')

Elm.App.embed(root)
