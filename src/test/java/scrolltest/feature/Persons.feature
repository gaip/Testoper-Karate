# Author : Hasan Turhal
# Website :  https://jsonplaceholder.typicode.com/

Feature: Verify Persons

  Background:
    Given url 'https://jsonplaceholder.typicode.com/'

  Scenario: Get all persons
    Given path 'users'
    When method get
    Then status 200
    Then match response == '#array'

  Scenario: Get Single Person
    Given path '/users/1'
    When method get
    Then status 200
    # use def keyword fo the variable
    * def id = response.id
    Then match id == 1
    # contains example
    Then match response contains {"name": "Leanne Graham"}
    Then match response.name ==  'Leanne Graham'
    Then match response.username !=  'Graham'


  Scenario: Get all persons with verification of JSON
    Given path 'users'
    When method get
    Then status 200
    Then match response == '#array'
    Then match each response[*] =={"id": "#number","name": "#string", "username": "#string", "email": "#string","address": "#string", "phoneNumbers": "#string", "website":""#string", "company": "#string"}

    """
        {
        "firstName": "#string",
        "lastName": "#string",
        "age": "#number",
        "id": "#number",
        "address": "#string",
        "phoneNumbers": "#string"
        }
    """

    @debug
    Scenario: Create a New Person
      Given path 'users'
      And request ==  "firstName": "abc",    "lastName": "Singh",    "age" : 23,    "address": "G-1",    "phoneNumbers": "9823232323"
      """
      {
        "firstName": "abc",
        "lastName": "Singh",
        "age" : 23,
        "address": "G-1",
        "phoneNumbers": "9823232323"
      }
      """
      When method POST
      Then status 201
      * def id = response.id

      Given path 'user/'+id
      When method get
      Then status 200
