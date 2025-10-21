import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../models/message.dart';

class MessageListItem extends StatelessWidget {
  final Message message;
  final VoidCallback onTap;

  const MessageListItem({
    super.key,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.separator.resolveFrom(context),
              width: 0.5,
            ),
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              _buildIcon(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getTitle(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _formatTime(message.createdAt),
                          style: TextStyle(
                            fontSize: 14,
                            color: CupertinoColors.secondaryLabel
                                .resolveFrom(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _getSubtitle(),
                      style: TextStyle(
                        fontSize: 14,
                        color:
                            CupertinoColors.secondaryLabel.resolveFrom(context),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getPreview(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.label.resolveFrom(context),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                CupertinoIcons.chevron_right,
                size: 20,
                color: CupertinoColors.systemGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData iconData;
    Color color;

    switch (message.messageType) {
      case 'memo':
        iconData = CupertinoIcons.envelope_fill;
        color = CupertinoColors.systemBlue;
        break;
      case 'event':
        iconData = CupertinoIcons.calendar;
        color = CupertinoColors.systemOrange;
        break;
      case 'task':
        iconData = CupertinoIcons.checkmark_square;
        color = CupertinoColors.systemGreen;
        break;
      default:
        iconData = CupertinoIcons.envelope;
        color = CupertinoColors.systemGrey;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        iconData,
        color: color,
        size: 24,
      ),
    );
  }

  String _getTitle() {
    if (message is Event) {
      return (message as Event).author;
    }
    return message.author;
  }

  String _getSubtitle() {
    if (message is Event) {
      return (message as Event).title;
    } else if (message is Task) {
      return (message as Task).title;
    } else if (message is Memo) {
      final memo = message as Memo;
      return memo.message.split('\n')[0];
    }
    return 'To: You';
  }

  String _getPreview() {
    if (message is Event) {
      return (message as Event).description;
    } else if (message is Task) {
      return (message as Task).description;
    } else if (message is Memo) {
      return (message as Memo).message;
    }
    return '';
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return DateFormat('h:mm a').format(dateTime);
    } else if (now.difference(messageDate).inDays < 7) {
      return DateFormat('EEE').format(dateTime);
    } else {
      return DateFormat('M/d/yy').format(dateTime);
    }
  }
}