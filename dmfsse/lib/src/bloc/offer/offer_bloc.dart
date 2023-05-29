import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_repository/offer_data_repository.dart';
import '../../models/offer.dart';
import 'offer_event.dart';
import 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  OfferDataRepository offerDataRepository;
  OfferBloc({required this.offerDataRepository}) : super(OfferStateLoading()) {
    on<OfferEvent>((event, emit) async {
      
      if (event is GetMyOfferEvent) {
        emit(OfferStateLoading());
        try {
           print("state is in aaaaaaaaaaaa");
         final List<Offer> offer = await offerDataRepository.getMyOffer();
          print("state is in sssssssss");
          if (offer != []) {
            print("state is in sssssssss");
            emit(OfferStateSucess(offer: offer));
          } else {
            print("state is in ffffffffffff");
            emit(OfferStateFailure(message: "Failed to load offer"));
          }
        } catch (e) {
          emit(OfferStateFailure(message: "Failed to load offer"));
        }
      }
       if (event is GetMyOrderEvent) {
        emit(OfferStateLoading());
        try {
           print("state is in aaaaaaaaaaaa");
         final List<Offer> offer = await offerDataRepository.getMyOrder();
          print("state is in sssssssss");
          if (offer != []) {
            print("state is in sssssssss");
            emit(OfferStateSucess(offer: offer));
          } else {
            print("state is in ffffffffffff");
            emit(OfferStateFailure(message: "Failed to load offer"));
          }
        } catch (e) {
          emit(OfferStateFailure(message: "Failed to load offer"));
        }
      }
      if (event is AcceptOfferEvent) {
        emit(OfferStateLoading());
        try {
          print("Bezuken bzuken 0");
          bool offer = await offerDataRepository.acceptOffer(event.offer);
           print("Bezuken bzuken 1");
          // List<Offer> lstOfOffer = await offerDataRepository.getMyOffer();
          print("Bezuken bzuken");
          // ignore: unnecessary_type_check
          if (offer) {
            emit(OfferAcceptStateSucess());
          } else {
            emit(OfferStateFailure(message: "Failed to load update offer"));
          }
        } catch (e) {
          emit(OfferStateFailure(message: e.toString()));
        }
      }
      if (event is DeleteOfferEvent) {
        emit(OfferStateLoading());
        try {
          bool isOfferDeleted =
              await offerDataRepository.deleteOffer(event.offerId);
          List<Offer> listOfOffer = await offerDataRepository.getMyOffer();
          if (isOfferDeleted) {
            emit(OfferStateSucess(offer: listOfOffer));
          } else {
            emit(OfferStateFailure(message: "Failed to delete offer"));
          }
        } catch (e) {
          emit(OfferStateFailure(message: "Failed to delete offer"));
        }
      }
    });
  }
}
