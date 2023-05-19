import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_repository/offer_data_repository.dart';
import '../../models/offer.dart';
import 'offer_event.dart';
import 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent,OfferState>{
  OfferDataRepository offerDataRepository;
OfferBloc({required this.offerDataRepository}):super(OfferStateLoading()){
  on<OfferEvent>((event, emit)  async{
     if(event is GetMyOfferEvent) {
        try {
          emit (OfferStateLoading());
        List<Offer> offer = await offerDataRepository.getMyOffer();
        if(offer != []){
          emit (OfferStateSucess(offer: offer));
        } else{
          emit (OfferStateFailure(message: "Failed to load offer"));
        }
        } catch (e) {
          emit (OfferStateFailure(message: "Failed to load offer"));
        }
     }
  });

}


}