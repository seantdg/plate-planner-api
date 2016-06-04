Feature: As an API consumer I want to access my profile details so that I can check my logged in status and if I have been registered to a house in Plate Planner

	Scenario: I successful retrieve my profile
		Given I set Authorization header to Bearer `token`
		When I GET /profile/me
		Then response code is 200
		And response body path $.facebookId is (.+)
		And response body path $.userId is (\d+)
		And response body path $.houseId is (.\d+)

	Scenario: I fail to retrieve my profile as the access token is missing
		Given I set Authorization header to Bearer `token`
		When I GET /profile/me
		Then response code is 401
		And response body path $.error is unauthorized

	Scenario: I fail to retrieve my profile as the access token is expired
		Given I set Authorization header to Bearer `token`
		When I GET /profile/me
		Then response code is 401
		And response body path $.error is unauthorized

	Scenario: I fail to retrieve my profile as the access token is invalid
		Given I set Authorization header to Bearer `token`
		When I GET /profile/me
		Then response code is 401
		And response body path $.error is unauthorized
	
	Scenario: I fail to retrieve my profile as the access token is missing
		Given I set Authorization header to Bearer `token`
		When I GET /profile/me
		Then response code is 401
		And response body path $.error is unauthorized
