require('./main.css');
require('../node_modules/select2/dist/css/select2.min.css');

var $ = require('jquery');
var select2 = require('select2');

var Elm = require('./Main.elm');
var root = document.getElementById('root');
var App = Elm.Main.embed(root);

App.ports.output.subscribe(function (options) {

    var $selectContainer = $('#select2-container');

    var select = $('<select>', {
        html: options.map(function (option) {
            return $('<option>', {
                value: option[ 0 ],
                text: option[ 1 ]
            })
        })
    }).appendTo($selectContainer);

    var select2 = $(select).select2();

    // Setup change port subscription.
    select2.on('change', function (event) {
        App.ports.input.send(event.target.value);
    });

    // Trigger the change for initial value.
    select2.trigger('change');
});