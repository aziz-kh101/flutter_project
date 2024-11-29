import 'dart:async';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:project/helpers/token_storage.dart';

class AuthorizationInterceptor extends InterceptorContract {

  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    String? token = await tokenStorage.getToken();

    if(token != null) {
      request.headers['Authorization'] = 'Bearer $token';
      return request;
    }
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    if(response.statusCode == 401) {
      tokenStorage.removeToken();
    }
    return response;
  }

}

final Client client = InterceptedClient.build(
    interceptors: [AuthorizationInterceptor()],
    requestTimeout: const Duration(seconds: 5),
);