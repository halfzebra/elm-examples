var ghpages = require('gh-pages');

var path = require('path');

ghpages.publish(
    path.join(__dirname, '..', 'examples'),
    {
        src: [
            'index.html',
            '**/dist/**/*',
            '!**/node_modules/**',
            '!**/elm_stuff/**'
        ]
    },
    function (err) {

        console.log('Failed to publish with gh-pages');
        console.log('');
        throw new Error(err);
        process.exit(1);
    }
);

console.log('Published succesfuly!');