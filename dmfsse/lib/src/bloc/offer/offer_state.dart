import '../../models/offer.dart';

class OfferState {}
class OfferStateLoading extends OfferState {}
class OfferStateSucess extends OfferState {
  List<Offer> offer;
  OfferStateSucess({required this.offer});
}
class OfferAcceptStateSucess extends OfferState {}
class OfferStateFailure extends OfferState{
  String message;
  OfferStateFailure({required this.message});
}