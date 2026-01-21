import 'package:dartssh2/dartssh2.dart';

class SSHService {
  static SSHClient? _client;
  static String? host;
  static int? port;
  static String? username;
  static String? password;

  /// Connect to LG system via SSH
  static Future<bool> connect({
    required String host,
    required int port,
    required String username,
    required String password,
  }) async {
    try {
      // Disconnect if already connected
      await disconnect();

      // Store credentials
      SSHService.host = host;
      SSHService.port = port;
      SSHService.username = username;
      SSHService.password = password;

      // Create SSH client
      final socket = await SSHSocket.connect(host, port);
      _client = SSHClient(
        socket,
        username: username,
        onPasswordRequest: () => password,
      );

      return true;
    } catch (e) {
      print('SSH Connection Error: $e');
      _client = null;
      return false;
    }
  }

  /// Disconnect from LG system
  static Future<void> disconnect() async {
    if (_client != null) {
      _client!.close();
      _client = null;
    }
  }

  /// Check if connected
  static Future<bool> isConnected() async {
    return _client != null;
  }

  /// Execute a command on the LG system
  static Future<String> execute(String command) async {
    if (_client == null) {
      throw Exception('Not connected to LG. Please connect first.');
    }

    try {
      final result = await _client!.run(command);
      return String.fromCharCodes(result);
    } catch (e) {
      throw Exception('Command execution failed: $e');
    }
  }

  /// Execute multiple commands
  static Future<void> executeMultiple(List<String> commands) async {
    for (final command in commands) {
      await execute(command);
    }
  }
}