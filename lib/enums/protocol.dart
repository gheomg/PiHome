enum Protocol { http, https }

extension ProtocolExtension on Protocol {
  String getString() {
    switch (this) {
      case Protocol.http:
        return 'http';
      case Protocol.https:
        return 'https';
    }
  }
}
