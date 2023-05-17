import 'package:network_info_plus/network_info_plus.dart';

Future<String> getIpAddress(int serverNo) async {
  List<String> usedAddress = List.filled(2, "", growable: false);
  NetworkInfo networkInfo = NetworkInfo();
  String? ipAddress =
      await networkInfo.getWifiIP(); // or getWifiIP or getEthernetIP
  (ipAddress == null)
      ? {
          usedAddress[0] = "http://localhost:5000",
          usedAddress[1] = "http://localhost:5253"
        }
      : {
          usedAddress[0] = "http://${ipAddress}:5000",
          usedAddress[1] = "http://${ipAddress}:5001"
        };
  return usedAddress[serverNo];
}