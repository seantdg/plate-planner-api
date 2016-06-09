@WorkInProgress
Feature: As an API consumer I want to access my profile details so that I can check my logged in status and if I have been registered to a house in Plate Planner

	Scenario: I successful retrieve my profile
		Given I set Authorization header to Bearer `token`
		When I GET /profile/me
		Then response code should be 200
		And response body path $.facebookId should be (.+)
		And response body path $.userId should be (\d+)
		And response body path $.houseId should be (.\d+)

	Scenario: I fail to retrieve my profile as the access token should be missing
		Given I set Authorization header to Bearer `token`
		When I GET /profile/me
		Then response code should be 401
		And response body path $.error should be unauthorized

	Scenario: I fail to retrieve my profile as the access token should be expired
		Given I set Authorization header to Bearer `token`
		When I GET /profile/me
		Then response code should be 401
		And response body path $.error should be unauthorized

	Scenario: I fail to retrieve my profile as the access token should be invalid
		Given I set Authorization header to Bearer `token`
		When I GET /profile/me
		Then response code should be 401
		And response body path $.error should be unauthorized
	
	Scenario: I fail to retrieve my profile as the access token should be missing
		Given I set Authorization header to Bearer `token`
		When I GET /profile/me
		Then response code should be 401
		And response body path $.error should be unauthorized
