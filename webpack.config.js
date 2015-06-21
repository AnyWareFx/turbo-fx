var webpack = require('webpack');
var glob = require("glob");

var commons = new webpack.optimize.CommonsChunkPlugin('fx-common.js');
var dedupe = new webpack.optimize.DedupePlugin();


module.exports = {
    entry: {
        'fx-command': glob.sync('./src/scripts/core/command/*.coffee'),
        'fx-model': glob.sync('./src/scripts/core/model/*.coffee'),
        'turbo-fx': glob.sync('./src/**/*.coffee')
    },
    output: {
        path: 'dist',
        filename: '[name].js'
    },
    module: {
        loaders: [
            { test: /\.coffee$/, loader: 'coffee-loader' }
        ]
    },
    resolve: {
        extensions: ['', '.js', '.json', '.coffee']
    },
    plugins: [
        commons,
        dedupe
    ]
};