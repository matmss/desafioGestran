*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  JSONLibrary

*** Variables ***
${BASE_URL}    https://reqres.in/api
${USER_ID}     5

*** Test Cases ***
Scenario: Create a new user
    [Documentation]    Creates a user
    [Tags]    POST    CREATE
    Given I need to create a new user with name "Matheus Santos", email "matheus@example.com" and password "pwd"
    When I send a POST request to "/register"
    Then The response status code should be 200
    And The response should contain "id" and "token"

Scenario: Read user list
    [Documentation]    Fetches a user list
    [Tags]    GET    READ
    When I send a GET request to "/users?page=2&per_page=5"
    Then The response status code should be 200
    And The response should contain "data"

Scenario: Update a user
    [Documentation]    Update user information and verify response
    [Tags]    PUT    UPDATE
    Given An existing user with ID "${USER_ID}"
    When I send a PUT request to "/users/${USER_ID}"
    Then The response status code should be 200
    And The response should contain "updatedAt"

Scenario: Delete a user
    [Documentation]    Deletes a user
    [Tags]    DELETE    REMOVE
    When I send a DELETE request to "/users/${USER_ID}"
    Then The response status code should be 204

*** Keywords ***
A new user with name "${name}", email "${email}" and password "${password}"
    ${body}=    Create Dictionary    name=${name}    job=${job}
    Set Test Variable    ${request_body}    ${body}

I send a GET request to "${endpoint}"
    ${response}=    GET    ${BASE_URL}${endpoint}
    Set Test Variable    ${response}
    Log    ${response.json()}

I send a POST request to "${endpoint}"
    ${response}=    POST    ${BASE_URL}${endpoint}    json=${request_body}
    Set Test Variable    ${response}
    Log    ${response.json()}

An existing user with ID "${id}"
    ${body}=    Create Dictionary    name="Updated User"
    Set Test Variable    ${request_body}    ${body}

I send a PUT request to "${endpoint}"
    ${response}=    PUT    ${BASE_URL}${endpoint}    json=${request_body}
    Set Test Variable    ${response}
    Log    ${response.json()}

I send a DELETE request to "${endpoint}"
    ${response}=    DELETE    ${BASE_URL}${endpoint}
    Set Test Variable    ${response}
    Log    ${response.status_code}

The response status code should be ${status_code}
    Should Be Equal As Numbers    ${response.status_code}    ${status_code}

The response should contain "${key}"
    ${json}=    Convert To String    ${response.json()}
    Should Contain    ${json}    ${key}

The response should contain "${key1}" and "${key2}"
    ${json}=    Convert To String    ${response.json()}
    Should Contain    ${json}    ${key1}
    Should Contain    ${json}    ${key2}
