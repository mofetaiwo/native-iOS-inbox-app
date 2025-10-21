import 'package:flutter/cupertino.dart';
import '../models/message.dart';
import '../services/message_service.dart';
import '../viewmodels/inbox_viewmodel.dart';
import 'widgets/message_list_item.dart';
import 'message_detail_view.dart';

class InboxView extends StatefulWidget {
  const InboxView({super.key});

  @override
  State<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
  late InboxViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = InboxViewModel(MessageService());
    _viewModel.loadMessages();
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape &&
            _viewModel.selectedMessage != null) {
          return _buildSplitView();
        }
        return _buildPortraitView();
      },
    );
  }

  Widget _buildPortraitView() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Inbox'),
        backgroundColor: CupertinoColors.systemGroupedBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(child: _buildMessageList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSplitView() {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildSearchBar(),
                  Expanded(child: _buildMessageList()),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: MessageDetailView(
                message: _viewModel.selectedMessage!,
                onClose: () => _viewModel.clearSelection(),
                isLandscape: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: CupertinoColors.systemGroupedBackground,
      child: CupertinoSearchTextField(
        placeholder: 'Search',
        enabled: false,
      ),
    );
  }

  Widget _buildMessageList() {
    if (_viewModel.isLoading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (_viewModel.messages.isEmpty) {
      return const Center(
        child: Text('No messages'),
      );
    }

    return CupertinoScrollbar(
      child: ListView.builder(
        itemCount: _viewModel.messages.length,
        itemBuilder: (context, index) {
          final message = _viewModel.messages[index];
          return MessageListItem(
            message: message,
            onTap: () => _onMessageTap(message),
          );
        },
      ),
    );
  }

  void _onMessageTap(Message message) {
    _viewModel.selectMessage(message);

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => MessageDetailView(
            message: message,
            onClose: () {
              _viewModel.clearSelection();
              Navigator.of(context).pop();
            },
            isLandscape: false,
          ),
        ),
      );
    }
  }
}
