import 'package:adam/constants.dart';
import 'package:adam/views/services/instagram/instagram_view.dart';
import 'package:adam/views/services/linkedin/linkedin_view.dart';
import 'package:adam/views/services/twitter/twitter_view.dart';
import 'package:adam/widgets/customBtn.dart';
import 'package:adam/widgets/logoDisplay.dart';
import 'package:flutter/material.dart';

class ServiceNotRunning extends StatelessWidget {
  final String serviceName;
  final bool isPremium;

  const ServiceNotRunning({Key key, this.isPremium, this.serviceName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  onPressed: () => Navigator.pop(context),
                ),
                LogoDisplay()
              ],
            ),
            Expanded(child: Container()),
            Text(
              serviceName,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 10.0),
            Text("No progress, service not started!"),
            SizedBox(height: 20.0),
            CustomButton(
              btnWidth: 200.0,
              btnHeight: 40.0,
              btnColor: kLightBlueColor,
              btnOnPressed: () {
                if (serviceName == "Instagram Marketing") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InstagramView(
                        isPrem: isPremium,
                      ),
                    ),
                  );
                } else if (serviceName == "Twitter Marketing") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TwitterView(
                        isPrem: isPremium,
                      ),
                    ),
                  );
                } else if (serviceName == "LinkedIn Marketing") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LinkedinView(
                        isPrem: isPremium,
                      ),
                    ),
                  );
                }
              },

              // btnOnPressed: () async {
              //   FilePickerResult result = await FilePicker.platform.pickFiles(
              //       type: FileType.custom,
              //       allowedExtensions: ['jpg'],
              //       allowMultiple: false);
              //   // File file = File(result.files.single.path);
              //   if (result != null) {
              //     print(result.files.single.path);
              //     String url =
              //         "https://adam-twitter.herokuapp.com/twitter/post/media";

              //     var response = await http.post(Uri.parse(url), body: {
              //       "text": "Flutter posting",
              //       "media": result.files.single.path,
              //     });

              //     // FormData formData = FormData.fromMap({
              //     //   "text": "FLUTTER + TWITTER API IS LOVE!",
              //     //   "media": await MultipartFile.fromFile(
              //     //     result.files.single.path,
              //     //     filename: result.files.single.name,
              //     //   ),
              //     // });

              //     // var response = await dio.post(
              //     //   url,
              //     //   data: formData,
              //     //   options: Options(
              //     //     contentType: "application/form-data",
              //     //     followRedirects: false,
              //     //     validateStatus: (status) {
              //     //       return status < 500;
              //     //     },
              //     //   ),
              //     // );
              //     // var response = await http.post(Uri.parse(url),
              //     //     body: jsonEncode(<String, dynamic>{
              //     //       "text": "POSTING FROM FLUTTER!!",
              //     //     }));
              //     print(response.body);
              //     // if (response.statusCode == 400) {
              //     //   print(response.data['id']);
              //     //   print("WAR GYE");
              //     // }
              //   }
              // },
              btnText: Text(
                "Start!",
                style: kBtnTextStyle,
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      )),
    );
  }
}
