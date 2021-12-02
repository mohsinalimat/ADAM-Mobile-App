import 'package:dio/dio.dart';

class SMSMarketing {
  Dio dio = Dio();
  Future smsFromCSV(List<String> phoneNumbersList, String smsBody) async {
    try {
      String url = "https://adam-web-api.herokuapp.com/sms/marketing-csv";
      var body = {
        "sms_body": smsBody,
        "number_list": [
          '+923111559877',
          '+923325464892',
        ],
      };

      Response response = await dio.post(
        url,
        data: body,
      );
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } on DioError catch (e) {
      return e.message;
    }
  }

  Future smsFromDataBank(String smsBody) async {
    try {
      String url = "https://adam-web-api.herokuapp.com/sms/marketing-data-bank";
      var body = {
        "sms_body": smsBody,
      };

      Response response = await dio.post(
        url,
        data: body,
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } on DioError catch (e) {
      return e.message;
    }
  }
}
