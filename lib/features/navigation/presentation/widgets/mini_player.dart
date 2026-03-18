import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.grey[900],
      child: const Row(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Placeholder(),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Now Playing Placeholder',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Performer Name',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(onPressed: null, icon: Icon(Icons.play_arrow)),
          IconButton(onPressed: null, icon: Icon(Icons.close)),
        ],
      ),
    );
  }
}
