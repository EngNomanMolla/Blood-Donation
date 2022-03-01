import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobeHelper {
  InterstitialAd _interstitialAd;
  int num_of_attem_load = 0;
  void createInerAd() {
    InterstitialAd.load(
       adUnitId:"ca-app-pub-4598469579115055/5884451458",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad){
              _interstitialAd=ad;
              num_of_attem_load=0;
            }, onAdFailedToLoad: (LoadAdError error){

              num_of_attem_load+1;
              _interstitialAd=null;
              if(num_of_attem_load<=2){
                createInerAd();
              }

        }));
  }

  void showInterAd() {

    if(_interstitialAd==null){
      return;
    }
    else{
      _interstitialAd.fullScreenContentCallback=FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad){

            print("Full Screen");

          },
          onAdDismissedFullScreenContent: (InterstitialAd ad){
            print("Add Dispose");
            ad.dispose();
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad,AdError adError){
            ad.dispose();
            createInerAd();
          }

      );
      if(_interstitialAd!=null){
      _interstitialAd.show();
      _interstitialAd=null;
    }
    }




  }
}
