//Let your app log into another machine {lg}
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter_application1/commands/lg_commands.dart';

class SSHService {
  static SSHClient? _client;
  static String? host;
  static int? port;
  static String? username;
  static String? password;

  static Future<bool> connect({
    required String host,
    required int port,
    required String username,
    required String password,
  }) async {
    try {
    
      await disconnect();

      
      SSHService.host = host;
      SSHService.port = port;
      SSHService.username = username;
      SSHService.password = password;

      
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
  
  static Future<void> senlogo() async {
    final logoscreen = 3;
    final kmlcontent = LGCommands.showLogo();
    await execute(
      "echo '$kmlcontent' > /var/www/html/slave_${logoscreen}.kml"
    );
    await _forceRefresh();
  }



  static Future <void> _forceRefresh() async {
    await execute (
    "echo 'refresh=true' > /tmp/query.txt" ); }

 
  static Future<void> disconnect() async {
    if (_client != null) {
      _client!.close();
      _client = null;
    }
  }

  static Future<bool> isConnected() async {
    return _client != null;
  }

  //Execute a command on the LG system
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

}