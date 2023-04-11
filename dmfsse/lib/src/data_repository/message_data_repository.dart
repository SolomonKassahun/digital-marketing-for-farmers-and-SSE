import 'package:dmfsse/src/data_provider/message_data_provider.dart';

import '../models/message.dart';

class MessageDataRepository {
  MessageDataProvier messageDataProvier;
  MessageDataRepository({required this.messageDataProvier});

  Future<List<MessageInfo>> getAllUserMessage() async {
    List<MessageInfo> listOfMesssage =
        await messageDataProvier.getAllUserMessage();
    print("data repo reached $listOfMesssage");
    return listOfMesssage;
  }

  Future<bool> sendMessage(String message, String id) async {
    return messageDataProvier.sendMessage(message, id);
  }
}
