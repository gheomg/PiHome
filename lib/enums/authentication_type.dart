enum AuthenticationType { token, credentials }

extension AuthenticationTypeExtension on AuthenticationType {
  String getString() {
    switch (this) {
      case AuthenticationType.token:
        return 'API Token';
      case AuthenticationType.credentials:
        return 'Credentials';
    }
  }
}
