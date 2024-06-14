import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:textz/Api/user_requests.dart';
import 'package:textz/main.dart';

class IosSocket {
  late IO.Socket socket;

  Future<void> initialize() async {
    final number = await phoneNumber.getNumber();

    socket = IO.io(backEndUri, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'extraHeaders': {'user_id': number},
    });
    socket.on('connect', (_) {
      print('Connected to the server');
    });

    socket.on('disconnect', (_) {
      print('Disconnected from the server');
    });

    socket.on('receive_message', (data) {
      print('Message received: $data');
    });

    socket.connect();
  }

  void sendMessage(String message, String recipientId, String messageType) {
    print(recipientId);
    print(message);
    socket.emit('send_message', {
      'message': message,
      'recipient_id': recipientId,
      'message_type': messageType,
    });
  }

  void dispose() {
    socket.disconnect();
  }
}
