import '../data_provider/offer_data_provider.dart';
import '../models/offer.dart';

class OfferDataRepository {
   OfferDataProvider  offerDataProvider;
   OfferDataRepository({required this.offerDataProvider});

   Future<List<Offer>> getMyOffer(){
    return offerDataProvider.getMyOffer();
   }
}