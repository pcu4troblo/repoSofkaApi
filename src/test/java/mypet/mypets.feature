Feature: My Pets

  Scenario Outline: agregar actualizar y consultar las mascotas
    * header Content-Type = 'application/json;charset=UTF-8'
    * def requestBody = read ('classpath:utils/AddPet.json')
    * replace requestBody.name = <name>

    Given url 'https://petstore.swagger.io/v2/pet'
    And request requestBody
    When method POST
    Then status 200
    And print response
    * def idPet = response.id

  #Scenario: consultar mascota
    Given url 'https://petstore.swagger.io/v2/pet/'
    And path response.id
    When method GET
    Then status 200
    And print response

  #Scenario: actualizar nombre de la mascota
    * header Content-Type = 'application/json;charset=UTF-8'
    * def requestBody = read ('classpath:utils/AddPet.json')
    * replace requestBody.name = "Sold"
    Given url 'https://petstore.swagger.io/v2/pet/'
    And request requestBody
    When method PUT
    Then status 200
    And print response


  #Scenario: consultar mascota por estado
    Given url 'https://petstore.swagger.io/v2/pet/findByStatus'
    And params 'status=Sold'
    When method GET
    Then status 200
    And print response

    Examples:
      | name     |
      | "tekila" |
      | "africa" |
      | "flor"   |