Feature: As an API consumer I want to obtain an access token so that I can use protected Plate Planner resources 

	Scenario: I successfully request a token
		Given I set Authorization header to Basic `client_auth_basic`   
		And I set body to redirect_uri=`valid_redirect_uri`&grant_type=code&code=`valid_auth_code`
		Then response code should be 200
		And response body path $.access_token should be (.+)
		And response body path $.token_type should be Bearer
		And response body path $.expires_in should be (\d+)
		And response body path $.scope should be public_profile

	Scenario: I fail to request a token with invalid client credentials
		Given I set Authorization header to Basic invalid  
		And I set body to redirect_uri=`valid_redirect_uri`&grant_type=code&code=`valid_auth_code`
		Then response code should be 401
		And response body path $.error should be invalid_client
	
	Scenario: I fail to request a token with missing client credentials
		And I set body to redirect_uri=`valid_redirect_uri`&grant_type=code&code=`valid_auth_code`
		Then response code should be 401
		And response body path $.error should be invalid_client
	
	Scenario: I fail to request a token with an invalid redirect_uri
		Given I set Authorization header to Basic `client_auth_basic`   
		And I set body to redirect_uri=invalid&grant_type=code&code=`valid_auth_code`
		Then response code should be 400
		And response body path $.error should be invalid_request	
	
	Scenario: I fail to request a token with an missing redirect_uri
		Given I set Authorization header to Basic `client_auth_basic`   
		And I set body to grant_type=code&code=`valid_auth_code`
		Then response code should be 400
		And response body path $.error should be invalid_request	

	Scenario: I fail to request an access token with an invalid grant type
		Given I set Authorization header to Basic `client_auth_basic`   
		And I set body to redirect_uri=`valid_redirect_uri`&grant_type=invalid&code=`valid_auth_code`
		Then response code should be 400
		And response body path $.error should be unsupported_grant_type

	Scenario: I fail to request an access token with a missing grant type
		Given I set Authorization header to Basic `client_auth_basic`   
		And I set body to redirect_uri=`valid_redirect_uri`&code=`valid_auth_code`
		Then response code should be 400
		And response body path $.error should be invalid_request

	Scenario: I fail to request an access token with an invalid authorization code
		Given I set Authorization header to Basic `client_auth_basic`   
		And I set body to redirect_uri=`valid_redirect_uri`&grant_type=code&code=invalid
		Then response code should be 400
		And the response body path $.error should be invalid_grant

	Scenario: I fail to request an access token with an expired authorization code
		Given I set Authorization header to Basic `client_auth_basic`   
		And I set body to redirect_uri=`valid_redirect_uri`&grant_type=code&code=`expired_auth_code`
		Then response code should be 400 
		And response body path $.error should be invalid_grant

	Scenario: I fail to request an access token with a missing authorization code
		Given I set Authorization header to Basic `client_auth_basic`   
		And I set body to redirect_uri=`valid_redirect_uri`&grant_type=code
		Then response code should be 400
		And response body path $.error should be invalid_grant
