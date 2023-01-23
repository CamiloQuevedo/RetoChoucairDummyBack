Feature: Test check create users

  Background:
    * def path = '/create'

  @scenario
  Scenario Outline: create user ok
    * def funBody = read('classpath:resources/BodyUserPost.js')
    * def jsonBody = call funBody {name: '<name>', salary: '<salary>', age: '<age>'}

    Given url global.host + global.version + path
    And request jsonBody
    When method POST
    * print response
    Then status 200
    * match name == response.data.name
    * match salary == response.data.salary
    * match age == response.data.age
    Examples:
      | name   | salary    | age |
      | Juan   | 2300000   | 28  |
      | Kariña | 129999,21 | 78  |

  @scenario
  Scenario Outline: create user bad request
    * def funBody = read('classpath:resources/BodyUserPost.js')
    * def jsonBody = call funBody {name: '<name>', salary: '<salary>', age: '<age>'}

    Given url global.host + global.version + path
    And request jsonBody
    When method POST
    * print response
    Then assert responseStatus != 200

    Examples:
      | name   | salary     | age |
      |        | 2300000    | 28  |
      | Kariña | 129999,21  | -78 |
      | Kariña | -129999,21 | 78  |
