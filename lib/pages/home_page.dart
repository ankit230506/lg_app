import 'package:flutter/material.dart';
import '../commands/lg_commands.dart';
import '../service/lg_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isConnected = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    final connected = await SSHService.isConnected();
    setState(() {
      _isConnected = connected;
    });
  }

  Future<void> _executeCommand(Future<void> Function() command, String commandName) async {
    if (!_isConnected) {
      _showSnackBar('Not connected to LG. Please configure settings.', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await command();
      _showSnackBar('$commandName executed successfully!');
    } catch (e) {
      _showSnackBar('Error executing $commandName: $e', isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LG Control'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await Navigator.pushNamed(context, '/settings');
              _checkConnection();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Connection Status
                Card(
                  color: _isConnected ? Colors.green.shade50 : Colors.red.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          _isConnected ? Icons.check_circle : Icons.error,
                          color: _isConnected ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _isConnected ? 'Connected to LG' : 'Not Connected',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _isConnected ? Colors.green.shade900 : Colors.red.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Display Commands
                const Text(
                  'Display',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  icon: Icons.image,
                  label: 'Show LG Logo',
                  onPressed: () => _executeCommand(LGCommands.showLogo, 'Show Logo'),
                  color: Colors.red,
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  icon: Icons.change_history,
                  label: 'Show 3D Pyramid',
                  onPressed: () => _executeCommand(LGCommands.show3DPyramid, 'Show 3D Pyramid'),
                  color: Colors.orange,
                ),
                const SizedBox(height: 24),

                // Navigation Commands
                const Text(
                  'Navigation',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  icon: Icons.flight,
                  label: 'Fly to Home City',
                  onPressed: () => _executeCommand(LGCommands.flyToHomeCity, 'Fly to Home'),
                  color: Colors.blue,
                ),
                const SizedBox(height: 24),

                // Clear Commands
                const Text(
                  'Clear',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.clear,
                        label: 'Clear Logo',
                        onPressed: () => _executeCommand(LGCommands.clearLogo, 'Clear Logo'),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.delete_outline,
                        label: 'Clear KML',
                        onPressed: () => _executeCommand(LGCommands.clearKml, 'Clear KML'),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}