// // lib/features/chat/models/chat_room.dart

// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatRoom {
//   final String id;
//   final List<String> participants;
//   final Timestamp lastMessageTimestamp;

//   ChatRoom({
//     required this.id,
//     required this.participants,
//     required this.lastMessageTimestamp,
//   });

//   factory ChatRoom.fromMap(Map<String, dynamic> map, String id) {
//     return ChatRoom(
//       id: id,
//       participants: List<String>.from(map['participants'] ?? []),
//       lastMessageTimestamp: map['lastMessageTimestamp'] ?? Timestamp.now(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'participants': participants,
//       'lastMessageTimestamp': lastMessageTimestamp,
//     };
//   }
// }
// lib/features/chat/models/chat_room.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id;
  final List<String> participants;
  final Timestamp lastMessageTimestamp;
  final String customerName;

  ChatRoom({
    required this.id,
    required this.participants,
    required this.lastMessageTimestamp,
    required this.customerName,
  });

  factory ChatRoom.fromMap(Map<String, dynamic> map, String id) {
    return ChatRoom(
      id: id,
      participants: List<String>.from(map['participants'] ?? []),
      lastMessageTimestamp: map['lastMessageTimestamp'] ?? Timestamp.now(),
      customerName: map['customerName'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'participants': participants,
      'lastMessageTimestamp': lastMessageTimestamp,
      'customerName': customerName,
    };
  }
}