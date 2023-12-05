import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PostDataService {
  var token;

  final String _baseUrl = "http://localhost:8000";
  //final String _baseUrl = "https://bapok-disperdagin.banjarmasinkota.go.id";

  Dio dio = Dio();

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('token');
    // return token;
    print(token);
    return '$token';
  }

  hasToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString('token');
  }

  LoginService(String username, String password) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    final responseData = await dio.post("$_baseUrl/api/login", data: {
      'username': username,
      'password': password,
    });

    print(['response :', responseData.data]);

    if (responseData.statusCode == 200) {
      if (responseData.data['data'] == null) {
        return null;
      } else {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        await sharedPreferences.setString(
            'token', responseData.data['api_token']);

        return responseData.data;
      }
    } else {
      return 401;
    }
  }

  checkToken() async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer " + await getToken();
    //print(['My Token :', getToken()]);
    final responseData = await dio.get(
      "$_baseUrl/api/user",
      options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json),
    );

    return responseData.statusCode;
  }

  dataUserService() async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer " + await getToken();
    final responseData = await dio.get("$_baseUrl/api/user",
        options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json));

    //print(['responseku :', responseData.data]);
    return responseData.data;
  }

  dataKomoditi(String pasar_id, String tanggal) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer " + await getToken();

    final responseData = await dio.post("$_baseUrl/api/komoditi", data: {
      'pasar_id': pasar_id,
      'tanggal': tanggal,
    });

    print('te');
    return responseData.data;
  }

  updateKomoditi(
      String harga_id, String pasar, String tanggal, String harga) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer " + await getToken();
    final responseData = await dio.post("$_baseUrl/api/komoditi/update", data: {
      'harga_id': harga_id,
      'pasar_id': pasar,
      'harga': harga,
      'tanggal': tanggal,
    });
    return responseData.data;
  }

  gantiPassword(String password) async {
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer " + await getToken();
    final responseData = await dio.post("$_baseUrl/api/gantipassword", data: {
      'password': password,
    });
    return responseData.data;
  }
}
