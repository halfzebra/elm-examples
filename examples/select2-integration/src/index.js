import './main.css';
import '../node_modules/select2/dist/css/select2.min.css';

import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

import $ from 'jquery';
import select2 from 'select2';

var app = Elm.Main.init({
  node: document.getElementById('root')
});

registerServiceWorker();

app.ports.output.subscribe(function (options) {

    var $selectContainer = $('#select2-container');

    // Generate DOM tree with <select> and <option> inside and embed it in to the root node.
    var select = $('<select>', {
        html: options.map(function (option) {
            return $('<option>', {
                value: option[ 0 ],
                text: option[ 1 ]
            })
        })
    }).appendTo($selectContainer);

    // Initialize Select2, when everything is ready.
    var select2 = $(select).select2();

    // Setup change port subscription.
    select2.on('change', function (event) {
        app.ports.input.send(event.target.value);
    });

    // Trigger the change for initial value.
    select2.trigger('change');
});
