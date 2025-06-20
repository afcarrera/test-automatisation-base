@REQ_TEST-1 @MarvelCharactersAPI
Feature: MarvelCharactersAPI

  Background:
    * configure ssl = true
    * def config = callonce read('classpath:karate-config.js')
    * def domain = config.url
    * def randomSuffix = config.suffix
    * def path = '/username-' + randomSuffix +'/api/characters'
    * def id = '/1'

  @id:1 @CrearPersonaje
  Scenario Outline: T-API-TEST-1-CA01 - Crear personaje de Marvel
    Given url domain + path
    And def user = read('classpath:../data/marverl_characters_api/marvel_characters_api_body.json')
    And request user
    When method POST
    Then status 201
    And match response.name == '<name>'
    And match response.description == '<description>'
    And match response.powers[0] == '<powers1>'
    And match response.powers[1] == '<powers2>'
    And match response.alterego == '<alterego>'
    Examples:
      |read('classpath:../data/marverl_characters_api/marvel_characters_api_data1.csv')|

  @id:2 @CrearPersonajeDuplicado
  Scenario Outline: T-API-TEST-1-CA02 - Crear personaje de Marvel duplicado
    Given url domain + path
    And def user = read('classpath:../data/marverl_characters_api/marvel_characters_api_body.json')
    And request user
    When method POST
    Then status 400
    And match response.error == '<error>'
    Examples:
      |read('classpath:../data/marverl_characters_api/marvel_characters_api_data2.csv')|

  @id:3 @CrearPersonajeCamposVacios
  Scenario Outline: T-API-TEST-1-CA03 - Crear personaje de Marvel con campos vacíos
    Given url domain + path
    And def user = read('classpath:../data/marverl_characters_api/marvel_characters_api_body_400.json')
    And request user
    When method POST
    Then status 400
    And match response.name == '<name>'
    And match response.description == '<description>'
    And match response.powers == '<powers>'
    And match response.alterego == '<alterego>'
    Examples:
      |read('classpath:../data/marverl_characters_api/marvel_characters_api_data3.csv')|

  @id:4 @ObtenerPersonajes
  Scenario Outline: T-API-TEST-1-CA04 - Obtener personajes de Marvel
    Given url domain + path
    When method GET
    Then status 200
    And match response[0].name == '<name>'
    And match response[0].description == '<description>'
    And match response[0].powers[0] == '<powers1>'
    And match response[0].powers[1] == '<powers2>'
    And match response[0].alterego == '<alterego>'
    Examples:
      |read('classpath:../data/marverl_characters_api/marvel_characters_api_data4.csv')|

  @id:5 @ObtenerPersonajeId
  Scenario Outline: T-API-TEST-1-CA05 - Obtener personaje de Marvel por su ID
    Given url domain + path + id
    When method GET
    Then status 200
    And match response.name == '<name>'
    And match response.description == '<description>'
    And match response.powers[0] == '<powers1>'
    And match response.powers[1] == '<powers2>'
    And match response.alterego == '<alterego>'
    Examples:
      |read('classpath:../data/marverl_characters_api/marvel_characters_api_data5.csv')|

  @id:6 @ObtenerPersonajeIdError
  Scenario Outline: T-API-TEST-1-CA06 - Obtener personaje de Marvel por su ID que no existe
    Given url domain + path + '/2'
    When method GET
    Then status 404
    And match response.error == '<error>'
    Examples:
      |read('classpath:../data/marverl_characters_api/marvel_characters_api_data6.csv')|

  @id:7 @ActualizarPersonaje
  Scenario Outline: T-API-TEST-1-CA07 - Actualizar personaje de Marvel por su ID
    Given url domain + path + id
    And def user = read('classpath:../data/marverl_characters_api/marvel_characters_api_body_put.json')
    And request user
    When method PUT
    Then status 200
    And match response.name == '<name>'
    And match response.description == '<description>'
    And match response.powers[0] == '<powers1>'
    And match response.powers[1] == '<powers2>'
    And match response.alterego == '<alterego>'
    Examples:
      |read('classpath:../data/marverl_characters_api/marvel_characters_api_data7.csv')|

  @id:8 @ActualizarPersonajeError
  Scenario Outline: T-API-TEST-1-CA08 - Actualizar personaje de Marvel por su ID que no existe
    Given url domain + path + '/2'
    And def user = read('classpath:../data/marverl_characters_api/marvel_characters_api_body_put.json')
    And request user
    When method PUT
    Then status 404
    And match response.error == '<error>'
    Examples:
      |read('classpath:../data/marverl_characters_api/marvel_characters_api_data8.csv')|

  @id:9 @EliminarPersonaje
  Scenario Outline: T-API-TEST-1-CA09 - Eliminar personaje de Marvel por su ID
    Given url domain + path + id
    When method DELETE
    Then status <status>
    Examples:
      |read('classpath:../data/marverl_characters_api/marvel_characters_api_data9.csv')|

  @id:10 @EliminarPersonajeError
  Scenario Outline: T-API-TEST-1-CA10 - Eliminar personaje de Marvel por su ID que no existe
    Given url domain + path + '/2'
    When method DELETE
    Then status 404
    And match response.error == '<error>'
    Examples:
      |read('classpath:../data/marverl_characters_api/marvel_characters_api_data10.csv')|