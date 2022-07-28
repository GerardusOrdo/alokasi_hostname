class Settings {
  //!Set debugging query mode
  static bool isDebuggingQueryMode = true;

  //!Keycloak default Settings
  static String keycloackUri =
      // 'http://192.168.194.136:8081/auth/realms/DataCenter';
      'http://10.242.65.23:8001/auth/realms/DataCenter';
  static String keycloakClientId = 'aplikasi-alokasi_hostname-web';
  static List<String> keycloakScopes = ['openid', 'profile'];
  static int keycloakPort = 4200;

  //!Hasura settings
  static String hasuraConnectionString =
      // 'http://192.168.194.136:8080/v1/graphql';
      'http://10.242.65.23:8002/v1/graphql';
  static Map<String, String> hasuraSecretHeader = {
    'X-Hasura-Admin-Secret': 'ordo123OK'
  };
  static int hasuraQueryOffset = 0;
  static int hasuraQueryLimit = 20;
}
