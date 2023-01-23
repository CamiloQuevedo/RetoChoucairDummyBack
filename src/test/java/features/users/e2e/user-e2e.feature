Feature: Test check get users

  Background:
    * def funBody = read('classpath:resources/BodyUserPost.js')
    * def jsonBody = call funBody {name: '<name>', salary: '<salary>', age: '<age>'}

  @E2E
  Scenario Outline: test E2E
    * def funBody = read('classpath:resources/BodyUserPost.js')
    * def jsonBody = call funBody {name: '<name>', salary: '<salary>', age: '<age>'}

    Given url global.host + global.version + '/create'
    And request jsonBody
    When method POST
    Then status 200
    * configure report = false
    * def requestGet = call read('classpath:features/users/get/user-get.feature@E2E'){"id": '#(response.data.id)'}
    * configure report = true
    * match name == requestGet.response.data.employee_name
    * match salary == requestGet.response.data.employee_salary
    * match age == requestGet.response.data.employee_age
    * configure report = false
    * def requestPut = call read('classpath:features/users/put/user-put.feature@E2E'){id: response.data.id, name: 'Juan Perez', salary: '1998322', age: '27'}
    * def requestGet = call read('classpath:features/users/get/user-get.feature@E2E'){id: response.data.id}
    * configure report = true
    * match requestPut.response.data.name == requestGet.response.data.employee_name
    * match requestPut.response.data.salary == requestGet.response.data.employee_salary
    * match requestPut.response.data.age == requestGet.response.data.employee_age
    * configure report = false
    * def requestDelete = call read('classpath:features/users/delete/user-Delete.feature@E2E'){id: response.data.id}
    * configure report = true
    * match requestDelete.response.data.status == 'success'
    * match requestDelete.response.data.message == 'successfully! deleted Records'

    Examples:
      | name   | salary  | age |
      | Miguel | 2300000 | 30  |