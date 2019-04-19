const httpProxy = require('http-proxy');
const http = require('http');
const basicAuth = require('basic-auth');
const crypto = require('crypto');


var username = process.env['username'] || 'land007';
var password = process.env['password'] || 'fcea920f7412b5da7be0cf42b8c93759';


var proxy = httpProxy.createProxyServer({
	target: {
		host: 'localhost',
		port: 3000
	},
	ws: true
});

var send401 = function(res) {
	res.statusCode = 401;
	res.setHeader('WWW-Authenticate', 'Basic realm=Authorization Required');
	res.end('<html><body>Need some creds son</body></html>');
};

var proxyServer = http.createServer(function (req, res) {
	var user = basicAuth(req);
	if (!user) {
		send401(res);
		return;
	}
	var md5 = crypto.createHash('md5');
	if (user.pass === undefined) {
		md5.update('undefined');
	} else {
		md5.update(user.pass);
	}
	var pass = md5.digest('hex');
	if (user.name !== username || pass !== password) {
		send401(res);
		return;
	}
	proxy.web(req, res);
});

proxyServer.on('upgrade', function (req, socket, head) {
	proxy.ws(req, socket, head);
});

proxyServer.listen(5050);
console.log("listen 5050");
