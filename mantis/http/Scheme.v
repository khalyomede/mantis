module http

pub enum Scheme {
	undefined
	http
	https
	ws
	wss
	mailto
	tel
	slack
	s3
}

pub fn (scheme Scheme) str() string {
	return match scheme {
		.undefined	{ "" }
		.http 		{ "http" }
		.https 		{ "https" }
		.ws 		{ "ws" }
		.wss 		{ "wss" }
		.mailto 	{ "mailto" }
		.tel 		{ "tel" }
		.slack 		{ "slack" }
		.s3 		{ "s3" }
	}
}
