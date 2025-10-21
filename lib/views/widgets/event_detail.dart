import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../models/message.dart';

class EventDetail extends StatelessWidget {
  final Event event;

  const EventDetail({super.key, required this.event});

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
                    color: CupertinoColors.systemOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    CupertinoIcons.calendar,
                    color: CupertinoColors.systemOrange,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.author,
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
                  _formatTime(event.createdAt),
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              event.description,
              style: TextStyle(
                fontSize: 16,
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoSection(context),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    color: CupertinoColors.systemGrey2,
                    onPressed: () {
                    },
                    child: const Text('Accept'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CupertinoButton(
                    color: CupertinoColors.systemGrey2,
                    onPressed: () {
                    },
                    child: const Text('Decline'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
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
            'Date',
            DateFormat('EEEE, MMMM d, y').format(event.startTime),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            context,
            'Time',
            '${DateFormat('h:mm a').format(event.startTime)} - ${DateFormat('h:mm a').format(event.endTime)}',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            context,
            'Location',
            event.location,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            context,
            'Organizer',
            event.organizer,
          ),
          if (event.attendees.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildAttendeesRow(context),
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
          width: 80,
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

  Widget _buildAttendeesRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            'Attendees',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: event.attendees.map((attendee) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '${attendee.name} (${attendee.response})',
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }
}