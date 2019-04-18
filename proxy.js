var httpProxy = require('http-proxy');
var http = require('http');

var proxy = httpProxy.createProxyServer({
	target: {
		host: 'localhost',
		port: 3000
	},
	ws: true
});

var proxyServer = http.createServer(function (req, res) {
	proxy.web(req, res);
});

proxyServer.on('upgrade', function (req, socket, head) {
	proxy.ws(req, socket, head);
});

proxyServer.listen(5050);
console.log("listen 5050");
