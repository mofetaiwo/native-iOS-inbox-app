import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/message.dart';

abstract class IMessageService {
  Future<List<Message>> loadMessages();
}

class MessageService implements IMessageService {
  @override
  Future<List<Message>> loadMessages() async {
    final jsonString = await rootBundle.loadString('assets/mp2.json');
    final jsonData = json.decode(jsonString);

    List<Message> messages = [];

    for (var memoJson in jsonData['memos']) {
      messages.add(Memo.fromJson(memoJson));
    }

    for (var eventJson in jsonData['events']) {
      messages.add(Event.fromJson(eventJson));
    }

    for (var taskJson in jsonData['tasks']) {
      messages.add(Task.fromJson(taskJson));
    }

    messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return messages;
  }
}
