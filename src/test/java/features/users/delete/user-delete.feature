Feature: Test check delete users

  Background:
    * def path = '/delete'

  @scenario
  Scenario Outline: Delete user ok

    Given url global.host + global.version + path + '/' + <id>
    When method DELETE
    Then status 200
    * print response
    Examples:
      | id |
      | 2  |

  @scenario
  Scenario Outline: Delete user bad request

    Given url global.host + global.version + path + '/<id>'

    When method GET
    Then match response.message == 'Error Occured! Page Not found, contact rstapi2example@gmail.com'
    * print response

    Examples:
      | id |
      | a  |

  @E2E
  Scenario:Delete user
    * def Customer = {"id": '#(id)'}

    Given url global.host + global.version + path + '/' + Customer.id
    When method DELETE
    Then status 200
    * print response
