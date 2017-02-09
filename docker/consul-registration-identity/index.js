var express = require('express'),
    xRequestId = require('exwml').XRequestId,
    app = express(),
    os = require("os");
    
// Consul client, used for service registration.
/*var consul = require('consul')({
    host: process.env.CONSUL || '127.0.0.1',
    port: process.env.CONSUL_PORT || '8500',
    token: process.env.CONSUL_TOKEN || null
});*/

app.use(xRequestId());

app.get('/', function(req, res, next) {
    res.send('Hello from ' + os.hostname());
});

app.get('/health', function(req, res, next) {
    res.send(200, 'Ok');
});

app.listen(8080, function() {
    logger.info('Example app listening on port %s!', 8080);
});