Feature: Test check update user

  Background:
    * def path = '/update'

  @scenario
  Scenario Outline: Update user ok
    * def funBody = read('classpath:resources/BodyUserPost.js')
    * def jsonBody = call funBody {id: '<id>', name: '<name>', salary: '<salary>', age: '<age>'}

    Given url global.host + global.version + path
    And request jsonBody
    When method PUT
    Then status 200
    * configure report = false
    * def result = call read('classpath:features/users/get/user-get.feature@E2E'){id: '<id>'}
    * configure report = true
    * print result
    * match name == result.response.data.employee_name
    * match salary == result.response.data.employee_salary
    * match age == result.response.data.employee_age

    Examples:
      | id | name | salary  | age |
      | 2  | Juan | 2300000 | 28  |

  @scenario
  Scenario Outline: Update user bad request
    * def funBody = read('classpath:resources/BodyUserPost.js')
    * def jsonBody = call funBody {id: '<id>', name: '<name>', salary: '<salary>', age: '<age>'}

    Given url global.host + global.version + path
    And request jsonBody
    When method PUT
    * print response
    Then assert responseStatus != 200
    Examples:
      | id | name | salary  | age |
      |    | Juan | 2300000 | -28 |

  @E2E
  Scenario: Update user ok
    * def funBody = read('classpath:resources/BodyUserPost.js')
    * def user = {"id": '#(id)', "name": '#(name)', "salary": '#(salary)', "age": '#(age)'}
    * def jsonBody = call funBody {name: user.name, salary: user.salary, age: user.age}

    Given url global.host + global.version + path + user.id
    And request jsonBody
    When method PUT
    * print response
    Then status 200