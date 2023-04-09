import 'package:dmfsse/src/data_provider/message_data_provider.dart';

import '../models/message.dart';

class MessageDataRepository {
  MessageDataProvier messageDataProvier;
  MessageDataRepository({required this.messageDataProvier});

  Future<List<Message>> getAllUserMessage() async {
    List<Message> listOfMesssage = await messageDataProvier.getAllUserMessage();
    print("data repo reached $listOfMesssage");
    return listOfMesssage;
  }
}
