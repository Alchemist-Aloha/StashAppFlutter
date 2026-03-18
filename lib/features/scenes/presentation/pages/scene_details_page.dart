import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SceneDetailsPage extends ConsumerWidget {
  final String sceneId;
  const SceneDetailsPage({required this.sceneId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scene Details')),
      body: Column(
        children: [
          const AspectRatio(aspectRatio: 16/9, child: Placeholder()), // Video Player Placeholder
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Scene Title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                const Text('Studio Name • 2024', style: TextStyle(color: Colors.grey)),
                const Divider(height: 32, color: Colors.grey),
                Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.person)),
                    const SizedBox(width: 12),
                    const Expanded(child: Text('Performer Name', style: TextStyle(color: Colors.white))),
                    OutlinedButton(onPressed: () {}, child: const Text('Follow')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
