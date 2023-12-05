import 'package:dio/dio.dart';

class checkVersion {
  var versiclient = "1.0.6";
  final String _baseUrl =
      "https://absensi.banjarmasinkota.go.id/api/checkversion";

  Dio dio = Dio();

  checkService() async {
    final responseData = await dio.get(_baseUrl);
    var versiserver = responseData.data['data'];
    if (versiclient == versiserver) {
      return true;
    } else {
      return false;
    }
  }
}
