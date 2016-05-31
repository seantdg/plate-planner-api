Feature: Smoke Test the Plate Planner API

Scenario: Get Recipes
    When I GET /something
    Then response code should be 404
