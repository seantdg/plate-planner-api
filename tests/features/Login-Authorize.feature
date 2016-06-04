Feature: As an API Consumer I want to authorize my application so that the Client application can log in directly with an authorization server

	Scenario: I successfully authorize
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| `valid_client_id`		|
			| redirect_uri	| `valid_redirect_uri`	|
			| response_type	| code					|
			| state			| `uuid`				|
			| scope			| public_profile		|
		When I GET /authorize
		Then response code should be 302
		And Location header should be (.*)

	Scenario: I fail to authorize with an invalid client id
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| invalid_id			|
			| redirect_uri	| `valid_redirect_uri`	|
			| response_type	| code					|
			| state			| `uuid`				|
			| scope			| public_profile		|
		When I GET /authorize
		Then response code should be 401
		And response body path $.error should be unauthorized_client

	Scenario: I fail to authorize with a revoked client id
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| `revoked_client_id`	|
			| redirect_uri	| `valid_redirect_uri`	|
			| response_type	| code					|
			| state			| `uuid`				|
			| scope			| public_profile		|
		When I GET /authorize
		Then response code should be 401
		And response body path $.error should be unauthorized_client

	Scenario: I fail to authorize with a missing client id
		Given I set query parameters to
			| parameter		| value					|
			| redirect_uri	| `valid_redirect_uri`	|
			| response_type	| code					|
			| state			| `uuid`				|
			| scope			| public_profile		|
		When I GET /authorize
		Then response code should be 400
		And response body path $.error should be invalid_request

	Scenario: I fail to authorize with an invalid redirect uri
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| `valid_id`			|
			| redirect_uri	| invalid_redirect_uri	|
			| response_type	| code					|
			| state			| `uuid`				|
			| scope			| public_profile		|
		When I GET /authorize
		Then response code should be 400
		And response body path $.error should be invalid_request

	Scenario: I fail to authorize with a missing redirect uri
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| `valid_id`			|
			| response_type	| code					|
			| state			| `uuid`				|
			| scope			| public_profile		|
		When I GET /authorize
		Then response code should be 400
		And response body path $.error should be invalid_request

	Scenario: I fail to authorize with an invalid response type 
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| `valid_id`			|
			| redirect_uri	| `valid_redirect_uri`	|
			| response_type	| invalid				|
			| state			| `uuid`				|
			| scope			| public_profile		|
		When I GET /authorize
		Then response code should be 400
		And response body path $.error should be unsupported_response_type

	Scenario: I fail to authorize with a missing response type
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| `valid_id`			|
			| redirect_uri	| `valid_redirect_uri`	|
			| state			| `uuid`				|
			| scope			| public_profile		|
		When I GET /authorize
		Then response code should be 400
		And response body path $.error should be invalid_request

	Scenario: I successfully authorize with a missing state
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| `valid_id`			|
			| redirect_uri	| `valid_redirect_uri`	|
			| response_type	| code					|
			| scope			| public_profile		|
		When I GET /authorize
		Then response code should be 302
		And Location header should be (.*)

	Scenario: I fail to authorize with an invalid scope
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| `valid_id`			|
			| redirect_uri	| `valid_redirect_uri`	|
			| response_type	| code					|
			| state			| `uuid`				|
			| scope			| invalid				|
		When I GET /authorize
		Then response code should be 400
		And response body path $.error should be invalid_scope

	Scenario: I successfully authorize with a valid scope 
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| `valid_id`			|
			| redirect_uri	| `valid_redirect_uri`	|
			| response_type	| code					|
			| state			| `uuid`				|
			| scope			| public_profile		|
		When I GET /authorize
		Then response code should be 302
		And Location header should be (.*)

	Scenario: I fail to authorize with a forbidden scope
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| `valid_id`			|
			| redirect_uri	| `valid_redirect_uri`	|
			| response_type	| code					|
			| state			| `uuid`				|
			| scope			| pin_number			|
		When I GET /authorize
		Then response code should be 401
		And response body path $.error should be access_denied

	Scenario: I successfully authorize with missing scopes
		Given I set query parameters to
			| parameter		| value					|
			| client_id		| `valid_id`			|
			| redirect_uri	| `valid_redirect_uri`	|
			| response_type	| code					|
			| state			| `uuid`				|
		When I GET /authorize
		Then response code should be 302
		And Location header should be (.*)

