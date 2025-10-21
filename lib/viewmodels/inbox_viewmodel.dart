import 'package:flutter/foundation.dart';
import '../models/message.dart';
import '../services/message_service.dart';

class InboxViewModel extends ChangeNotifier {
  final IMessageService _messageService;

  List<Message> _messages = [];
  Message? _selectedMessage;
  bool _isLoading = true;

  InboxViewModel(this._messageService);

  List<Message> get messages => List.unmodifiable(_messages);
  Message? get selectedMessage => _selectedMessage;
  bool get isLoading => _isLoading;

  Future<void> loadMessages() async {
    _isLoading = true;
    notifyListeners();

    try {
      _messages = await _messageService.loadMessages();
    } catch (e) {
      debugPrint('Error loading messages: $e');
      _messages = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectMessage(Message message) {
    _selectedMessage = message;
    notifyListeners();
  }

  void clearSelection() {
    _selectedMessage = null;
    notifyListeners();
  }
}
