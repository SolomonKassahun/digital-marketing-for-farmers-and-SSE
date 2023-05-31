import 'package:dmfsse/src/data_provider/message_data_provider.dart';

import '../models/message.dart';
import '../models/message_list.dart';

class MessageDataRepository {
  MessageDataProvier messageDataProvier;
  MessageDataRepository({required this.messageDataProvier});

  Future<List<MessageInfo>> getAllUserMessage() async {
    List<MessageInfo> listOfMesssage =
        await messageDataProvier.getAllUserMessage();
    print("data repo reached $listOfMesssage");
    return listOfMesssage;
  }

  Future<ListOfMessage> sendMessage(MessageBody messageBody) async {
    print("message at provier");
    return messageDataProvier.sendMessage(messageBody);
  }

  Future<List<ListOfMessage>> getYourMessage(String id) async {
    return messageDataProvier.getYourMessage(id);
  }
  Future<bool> deleteMessage(String id,String userId){
    return messageDataProvier.deleteMessage(id,userId);
  }
}
