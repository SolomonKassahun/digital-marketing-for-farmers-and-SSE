import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../bloc/chapa_payment/payment_bloc.dart';
import '../../../bloc/chapa_payment/payment_event.dart';
import '../../../bloc/chapa_payment/payment_state.dart';
import '../../../bloc/offer/offer_bloc.dart';
import '../../../bloc/offer/offer_event.dart';
import '../../../models/offer.dart';
import '../../../models/payment_model.dart';

class PaymentAlertDialogBox extends StatefulWidget {
  final PaymentModel paymentModel;
  final int quantity;
  const PaymentAlertDialogBox({required this.paymentModel,required this.quantity, super.key});

  @override
  State<PaymentAlertDialogBox> createState() => _PaymentAlertDialogBoxState();
}

class _PaymentAlertDialogBoxState extends State<PaymentAlertDialogBox> {
  bool isInPayment = false;
  final GlobalKey webViewKey = GlobalKey();

  _launchURLBrowser(String url) async {
    var urllaunchable = await canLaunchUrl(Uri.parse(url));
    if (urllaunchable) {
      await launchUrl(
          Uri.parse(url)); //launch is from url_launcher package to launch URL
    } else {
       const AlertDialog(
        title: Text("Failed to launch"),
       );
    }
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(builder: (contex, state) {
      if (state is PaymentStateLoading) {
        isInPayment = true;
      }
      if (state is PaymentFailureState) {
        isInPayment = false;

       
      }
      if (state is PaymentStateSucess) {
        Navigator.pop(context);
        _launchURLBrowser(state.paymentData.data.checkoutUrl);
        isInPayment = false;
      }
      return AlertDialog(
        title: isInPayment
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : const Text("Payment "),
        content: const Text("Do you want to pay payment?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              OfferUpdateData offerUpdateData = OfferUpdateData(
                              offerId: widget.paymentModel.txtRef,
                              accepted: "completed",
                              canRate: '',
                              quantity: widget.quantity,
                              offerPrice: int.parse(widget.paymentModel.amount));
                          AcceptOfferEvent acceptOfferEvent =
                              AcceptOfferEvent(offer: offerUpdateData);
                          BlocProvider.of<OfferBloc>(context)
                              .add(acceptOfferEvent);
              BlocProvider.of<PaymentBloc>(context)
                  .add(PayPaymentEvent(paymentModel: widget.paymentModel));
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Yes"),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("No"),
            ),
          ),
        ],
      );
    });
  }
}
