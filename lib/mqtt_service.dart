import 'dart:convert';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// Connection states for easy identification
enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}

enum MqttSubscriptionState { IDLE, SUBSCRIBED }

class MQTTClientWrapper {
  late MqttServerClient client;

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  // Using async tasks, so the connection won't hinder the code flow
  void prepareMqttClient() async {
    _setupMqttClient();
    await _connectClient();
    _subscribeToTopic('Dart/Mqtt_client/testtopic');

    final Map<String, dynamic> data = {
      "appId": "com.example.primo_pay",
      "action": "sale",
      "clientTransactionId": "1234567801234",
      "amount": "1200",
      "tipAmount": "200",
      "show_receipt": true,
      "show_transaction_result": true,
      "show_rating": true,
      "callback": "mycallbackscheme://result"
    };

    final String jsonMessage = jsonEncode(data);
    _publishMessage(jsonMessage);
  }

  // Waiting for the connection, if an error occurs, print it and disconnect
  Future<void> _connectClient() async {
    try {
      print('Client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect(
          'hivemq.webclient.1705155054173', 'J172FALPEh0ae.db,c;<');
    } on Exception catch (e) {
      print('Client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }

    // When connected, print a confirmation, else print an error
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('Client connected');
    } else {
      print(
          'ERROR: Client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  void _setupMqttClient() {
    client = MqttServerClient.withPort(
        '1da48b75b820410f9a30d0796bb9fb02.s2.eu.hivemq.cloud',
        'hivemq.webclient.1705155054173',
        8883);
    // The next 2 lines are necessary to connect with TLS, which is used by HiveMQ Cloud
    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }

  void _subscribeToTopic(String topicName) {
    print('Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);

    // Print the message when it is received
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      var message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print('YOU GOT A NEW MESSAGE:');
      print(message);
    });
  }

  void _publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    if (builder.payload != null) {
      print(
          'Publishing message "$message" to topic Dart/Mqtt_client/testtopic');
      client.publishMessage(
          'Dart/Mqtt_client/testtopic', MqttQos.exactlyOnce, builder.payload!);
    } else {
      print('Error: Message payload is null');
    }
  }

  // Callbacks for different events
  void _onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print('OnConnected client callback - Client connection was successful');
  }
}
