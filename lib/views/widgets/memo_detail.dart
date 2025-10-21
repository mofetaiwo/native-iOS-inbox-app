import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../models/message.dart';

class MemoDetail extends StatelessWidget {
  final Memo memo;

  const MemoDetail({super.key, required this.memo});

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    CupertinoIcons.envelope_fill,
                    color: CupertinoColors.systemBlue,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        memo.author,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'To: You',
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.secondaryLabel
                              .resolveFrom(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  _formatDateTime(memo.createdAt),
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGroupedBackground.resolveFrom(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memo.message,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  if (memo.tags.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: memo.tags.map((tag) => _buildTag(tag)).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey5,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          fontSize: 12,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, y  h:mm a').format(dateTime);
  }
}