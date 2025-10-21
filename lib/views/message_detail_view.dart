import 'package:flutter/cupertino.dart';
import '../models/message.dart';
import 'widgets/memo_detail.dart';
import 'widgets/event_detail.dart';
import 'widgets/task_detail.dart';

class MessageDetailView extends StatelessWidget {
  final Message message;
  final VoidCallback onClose;
  final bool isLandscape;

  const MessageDetailView({
    super.key,
    required this.message,
    required this.onClose,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    if (isLandscape) {
      return _buildLandscapeLayout(context);
    }
    return _buildPortraitLayout(context);
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: onClose,
        ),
        middle: const Text('Inbox'),
        backgroundColor: CupertinoColors.systemGroupedBackground,
      ),
      child: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: CupertinoColors.separator.resolveFrom(context),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGroupedBackground.resolveFrom(context),
              border: Border(
                bottom: BorderSide(
                  color: CupertinoColors.separator.resolveFrom(context),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Close'),
                  onPressed: onClose,
                ),
              ],
            ),
          ),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (message is Memo) {
      return MemoDetail(memo: message as Memo);
    } else if (message is Event) {
      return EventDetail(event: message as Event);
    } else if (message is Task) {
      return TaskDetail(task: message as Task);
    }
    return const Center(child: Text('Unknown message type'));
  }
}