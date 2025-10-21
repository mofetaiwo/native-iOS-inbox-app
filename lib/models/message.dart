abstract class Message {
  final String id;
  final String author;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.author,
    required this.createdAt,
  });

  String get messageType;
}

class Memo extends Message {
  final String message;
  final List<String> tags;

  Memo({
    required super.id,
    required this.message,
    required super.author,
    required super.createdAt,
    required this.tags,
  });

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
      id: json['id'],
      message: json['message'],
      author: json['author'],
      createdAt: DateTime.parse(json['created_at']),
      tags: List<String>.from(json['tags']),
    );
  }

  @override
  String get messageType => 'memo';
}

class Event extends Message {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String description;
  final String organizer;
  final List<Attendee> attendees;

  Event({
    required super.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.description,
    required this.organizer,
    required this.attendees,
    required super.author,
    required super.createdAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      location: json['location'],
      description: json['description'],
      organizer: json['organizer'],
      attendees: (json['attendees'] as List).map((a) => Attendee.fromJson(a)).toList(),
      author: 'Event',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  String get messageType => 'event';
}

class Attendee {
  final String name;
  final String email;
  final String response;

  Attendee({
    required this.name,
    required this.email,
    required this.response,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(
      name: json['name'],
      email: json['email'],
      response: json['response'],
    );
  }
}

class Task extends Message {
  final String title;
  final String status;
  final String priority;
  final String assignedTo;
  final DateTime dueDate;
  final String description;
  final double estimateHours;
  final DateTime? completedAt;
  final List<String>? blockedBy;

  Task({
    required super.id,
    required this.title,
    required this.status,
    required this.priority,
    required this.assignedTo,
    required this.dueDate,
    required this.description,
    required this.estimateHours,
    required super.author,
    required super.createdAt,
    this.completedAt,
    this.blockedBy,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      priority: json['priority'],
      assignedTo: json['assigned_to'],
      dueDate: DateTime.parse(json['due_date']),
      description: json['description'],
      estimateHours: json['estimate_hours'].toDouble(),
      completedAt: json['completed_at'] != null ? DateTime.parse(json['completed_at']) : null,
      blockedBy: json['blocked_by'] != null? List<String>.from(json['blocked_by']) : null,
      author: 'Task',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  @override
  String get messageType => 'task';
}
