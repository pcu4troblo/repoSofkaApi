Feature: Crear usuario y autenticar en demoblaze

  Yo como usuario
  Necesito crear mis credenciales
  Para ingresar al aplicativo demoblaze

  @CrearUsuarioExitoso
  Scenario: Creacion de usuario exitosa
    * def randomNumber = function(min, max) { return Math.floor(Math.random() * (max - min + 1) + min); }
    * def randomUsername = 'nmdfgr' + randomNumber(1, 1000)
    * def randomPassword = 'MTIzNDU=' + randomNumber(1, 1000)
    * def signUpPayload = { "username": "#(randomUsername)", "password": "#(randomPassword)" }

    Given url 'https://api.demoblaze.com/signup'
    And request signUpPayload
    When method post
    Then status 200
    And match response.errorMessage == null

  @CrearUsuarioExistente
  Scenario Outline: Creacion de usuario ya existente
    Given url 'https://api.demoblaze.com/signup'
    And request  { "username": "<username>", "password": "<password>" }
    When method post
    Then status 200
    And match response.errorMessage == "This user already exist."

    Examples:
      | read('classpath:../data/usuariosExistentes.csv') |

  @AutenticacionExitosa
  Scenario: Autenticacion exitosa
    Given url 'https://api.demoblaze.com/login'
    And request  { "username": "jpra8", "password": "12345" }
    When method post
    Then status 200
    And match response.errorMessage == null


  @UsuarioIncorrecto
  Scenario: Usuario incorrecto al autenticar
    Given url 'https://api.demoblaze.com/login'
    And request  { "username": "xmls.-12", "password": "12345" }
    When method post
    Then status 200
    And match response.errorMessage == "User does not exist."

  @ContrasenaIncorrecta
  Scenario: Contrasena incorrecta al autenticar
    Given url 'https://api.demoblaze.com/login'
    And request  { "username": "jpra", "password": "54321" }
    When method post
    Then status 200
    And match response.errorMessage == "Wrong password."

