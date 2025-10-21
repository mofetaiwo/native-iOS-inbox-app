import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../models/message.dart';

class TaskDetail extends StatelessWidget {
  final Task task;

  const TaskDetail({super.key, required this.task});

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
                    color: CupertinoColors.systemGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    CupertinoIcons.checkmark_square,
                    color: CupertinoColors.systemGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.author,
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
                  _formatTime(task.createdAt),
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: TextStyle(
                fontSize: 16,
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 24),
            _buildTaskInfo(context),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    color: CupertinoColors.systemGrey2,
                    onPressed: () {
                    },
                    child: const Text('Mark as Complete'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CupertinoButton(
                    color: CupertinoColors.systemGrey2,
                    onPressed: () {
                    },
                    child: const Text('Add to To-Do List'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGroupedBackground.resolveFrom(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            context,
            'Status',
            _formatStatus(task.status),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            context,
            'Priority',
            _formatPriority(task.priority),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            context,
            'Due Date',
            DateFormat('EEEE, MMMM d, y').format(task.dueDate),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            context,
            'Estimate',
            '${task.estimateHours} hours',
          ),
          if (task.blockedBy != null && task.blockedBy!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              'Blocked By',
              task.blockedBy!.join(', '),
            ),
          ],
          if (task.completedAt != null) ...[
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              'Completed',
              DateFormat('MMM d, y  h:mm a').format(task.completedAt!),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  String _formatStatus(String status) {
    return status
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _formatPriority(String priority) {
    return priority[0].toUpperCase() + priority.substring(1);
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }
}