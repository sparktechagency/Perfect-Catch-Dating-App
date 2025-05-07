import 'package:get/get.dart';

import '../models/wallet_model.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class WalletController extends GetxController{

  //=============================> Get Wallet Data <===============================
  RxList<Transaction> transaction = <Transaction>[].obs;
  RxBool transactionLoading = false.obs;
  getTransaction() async {
    transactionLoading(true);
    var response = await ApiClient.getData(ApiConstants.walletEndPoint);
    if (response.statusCode == 200) {
      print(response.body);
      var data = response.body['data']['attributes']['userWallet'];
      if (data is List) {
        transaction.value = List<Transaction>.from(data.map((x) => Transaction.fromJson(x)));
      } else {
        print('User Wallet data is not a list');
      }
      transactionLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      transactionLoading(false);
      update();
    }
  }



  Rx<WalletModel> walletModel = WalletModel().obs;
  RxBool walletLoading = false.obs;
  getWallet() async {
    walletLoading(true);
    var response =
    await ApiClient.getData(ApiConstants.walletEndPoint);
    if (response.statusCode == 200) {
      walletModel.value = WalletModel.fromJson(response.body['data']['attributes']);
      walletLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      walletLoading(false);
      update();
    }
  }
}