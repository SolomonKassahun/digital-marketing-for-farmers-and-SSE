import '../data_provider/offer_data_provider.dart';
import '../models/offer.dart';

class OfferDataRepository {
   OfferDataProvider  offerDataProvider;
   OfferDataRepository({required this.offerDataProvider});

   Future<List<Offer>> getMyOffer() async{
      List<Offer> listOfOffer = await offerDataProvider.getMyOffer();
      print("list of ooooo is ${listOfOffer}");
    return listOfOffer;
   }
   Future<List<Offer>> getMyOrder() async{
      List<Offer> listOfOffer = await offerDataProvider.getMyOrder();
      print("list of ooooo is ${listOfOffer}");
    return listOfOffer;
   }
   Future<Offer> acceptOffer(OfferUpdateData offer){
    return offerDataProvider.acceptOffer(offer);
   }
   Future<bool> deleteOffer(String offerId){
    return offerDataProvider.deleteOffer(offerId);
   }
}