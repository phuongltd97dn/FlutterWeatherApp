import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response response) {
  final statusCode = response.statusCode;
  final reasonPhrase = response.reasonPhrase;

  String errorMessage =
      'Request failed\nStatus Code: $statusCode\nReason Phrase: $reasonPhrase';

  return errorMessage;
}
