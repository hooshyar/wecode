import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinksService {
  Future<Uri> createDynamicLink({required String vacancyID}) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://www.wecode-rwanga.com/vacancy/$vacancyID"),
      uriPrefix: "https://wecode2.page.link",
      androidParameters:
          const AndroidParameters(packageName: "app.datacode.wecode.wecode"),
      iosParameters:
          const IOSParameters(bundleId: "app.datacode.wecode.wecode"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    return dynamicLink;
  }

  Future<ShortDynamicLink> createShortLink({required String vacancyID}) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://www.wecode-rwanga.com/$vacancyID"),
      uriPrefix: "https://wecode2.page.link",
      androidParameters:
          const AndroidParameters(packageName: "app.datacode.wecode.wecode"),
      iosParameters:
          const IOSParameters(bundleId: "app.datacode.wecode.wecode"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    return dynamicLink;
  }
}
