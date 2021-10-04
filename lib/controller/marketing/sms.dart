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
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("SMS SENT CSV!");
        return response.statusCode;
      } else {
        print('some error!');
        return response.statusCode;
      }
    } on DioError catch (e) {
      print(e.message);
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
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("SMS SENT DATA BANK!");
        return response.statusCode;
      } else {
        print('some error!');
        return response.statusCode;
      }
    } on DioError catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
