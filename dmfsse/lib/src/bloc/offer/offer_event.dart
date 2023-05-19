import '../../models/offer.dart';

class OfferEvent {}
class GetMyOfferEvent extends OfferEvent{}
class GetMyOrderEvent extends OfferEvent {}
class AcceptOfferEvent extends OfferEvent {
  OfferUpdateData offer;
  AcceptOfferEvent({required this.offer});
}
class DeleteOfferEvent extends OfferEvent {
  String offerId;
  DeleteOfferEvent({required this.offerId});
}