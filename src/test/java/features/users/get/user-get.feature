Feature: Test check get users

  Background:
    * def path = '/employee'
    * def funBody = read('classpath:resources/BodyUserPost.js')
    * def jsonBody = call funBody {name: '<name>', salary: '<salary>', age: '<age>'}
    * def sleep = function(millis){ java.lang.Thread.sleep(millis) }


  @scenario
  Scenario Outline: Get user ok

    Given url global.host + global.version + path + '/' + '<id>'
    When method GET
    * karate.pause(100000)
    Then status 200
    * match response.data.id == <id>
    * print response
    Examples:
      | id |
      | 3  |

  @scenario
  Scenario: Get Id user ok

    Given url global.host + global.version + path + 's'
    When method GET
    * print responseStatus
    Then status 200


  @scenario
  Scenario Outline: Get Id user bad request

    Given url global.host + global.version + path + '/' + '<id>'
    When method GET
    * print responseStatus
    Then status 200
    * match response.data == null

    Examples:
      | id |
      | a  |
      | 5a |


  @E2E
  Scenario: Get user
    * def Customer = {"id": '#(id)'}

    Given url global.host + global.version + path + '/' + Customer.id
    When method GET
    Then status 200
    * print response

