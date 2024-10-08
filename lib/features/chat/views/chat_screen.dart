import 'package:customer_application/common/constants/app_id.dart';
import 'package:customer_application/features/utility/date_format.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/chat/model/chat_model.dart';
import 'package:intl/intl.dart';

class CustomerChatScreen extends StatefulWidget {
  @override
  _CustomerChatScreenState createState() => _CustomerChatScreenState();
}

class _CustomerChatScreenState extends State<CustomerChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<QuerySnapshot>? _messagesStream;
  String? _chatRoomId;
  bool _isLoading = true;
  String _customerName = 'Unknown';
  String? _customerId;

  @override
  void initState() {
    super.initState();
    _initializeChatRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimaryColor,
        title: Text('Chat with Alfa works', style: AppTextStyles.whiteBody),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _messagesStream == null
                      ? Center(child: Text('No messages yet.'))
                      : StreamBuilder<QuerySnapshot>(
                          stream: _messagesStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return Center(child: Text('No messages yet.'));
                            }

                            List<Message> messages = snapshot.data!.docs
                                .map((doc) => Message.fromMap(doc.data() as Map<String, dynamic>, doc.id))
                                .toList();

                            return ListView.builder(
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                Message message = messages[index];
                                bool isMe = message.senderId == _customerId;
                                bool showDate = index == messages.length - 1 || 
                                    !isSameDay(messages[index].timestamp.toDate(), messages[index + 1].timestamp.toDate());

                                return Column(
                                  children: [
                                    if (showDate)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          formatMessageDate(message.timestamp.toDate()),
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    Align(
                                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: isMe ? Colors.blue[100] : const Color.fromARGB(255, 243, 212, 212),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                          children: [
                                            Text(message.content),
                                            SizedBox(height: 5),
                                            Text(
                                              formatMessageTime(message.timestamp.toDate()),
                                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.textPrimaryColor
                        ),
                        child: IconButton(
                          icon: Icon(Icons.send, color: Colors.white),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _initializeChatRoom() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('No authenticated user found');
      }
      _customerId = user.uid;

      _chatRoomId = 'chat_${_customerId}_company';
      
      DocumentSnapshot customerDoc = await _firestore.collection('customer').doc(_customerId).get();
      if (customerDoc.exists) {
        _customerName = (customerDoc.data() as Map<String, dynamic>)['name'] ?? 'Unknown';
      }

      DocumentSnapshot chatRoom = await _firestore.collection('chats').doc(_chatRoomId).get();
      if (!chatRoom.exists) {
        await _firestore.collection('chats').doc(_chatRoomId).set({
          'participants': [_customerId, AppConstants.COMPANY_ID],
          'lastMessageTimestamp': FieldValue.serverTimestamp(),
          'customerName': _customerName,
        });
      } else {
        await _firestore.collection('chats').doc(_chatRoomId).update({
          'customerName': _customerName,
        });
      }

      _initializeMessagesStream();
    } catch (e) {
      print('Error initializing chat room: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _initializeMessagesStream() {
    _messagesStream = _firestore
        .collection('chats')
        .doc(_chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty && _chatRoomId != null && _customerId != null) {
      try {
        await _firestore.collection('chats').doc(_chatRoomId).collection('messages').add({
          'senderId': _customerId,
          'content': _messageController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
        await _firestore.collection('chats').doc(_chatRoomId).update({
          'lastMessageTimestamp': FieldValue.serverTimestamp(),
        });
        _messageController.clear();
      } catch (e) {
        print('Error sending message: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message. Please try again.')),
        );
      }
    }
  }

  String formatMessageTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  String formatMessageDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return "Today";
    } else if (messageDate == yesterday) {
      return "Yesterday";
    } else if (now.difference(messageDate).inDays < 7) {
      return DateFormat('EEEE').format(dateTime); // Full weekday name
    } else {
      return DateFormat('MM/dd/yyyy').format(dateTime);
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}