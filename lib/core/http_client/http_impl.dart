import 'package:naturalista/core/http_client/http_client.dart';
import 'package:http/http.dart' as http;

class HttpClientImpl extends HttpClient {
  final client = http.Client();

  @override
  Future<HttpResponse> get(String url, Map<String, String> headers) async {
    final response = await client.get(Uri.parse(url), headers: headers);

    return HttpResponse(data: response.body, statusCode: response.statusCode);
  }
}
