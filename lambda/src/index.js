'use strict';

module.exports.handler = (event, context, callback) => {
    console.log(event);
    const res = {
        statusCode: 200,
        headers: {
            'Access-Control-Allow-Origin': '*', // Required for CORS support to work
        },
        body: event.body
    };
    callback(null, res);
};
