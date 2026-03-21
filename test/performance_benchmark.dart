import 'dart:io';

void main() async {
  final url = Uri.parse('https://example.com/');
  const iterations = 50;

  print('Benchmarking HttpClient instantiation vs reuse...');

  // Baseline: create a new client each time
  final stopwatchNew = Stopwatch()..start();
  for (var i = 0; i < iterations; i++) {
    final client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 3);
    try {
      final req = await client.openUrl('GET', url);
      final res = await req.close();
      await res.drain<void>();
    } catch (_) {}
    client.close(force: true);
  }
  stopwatchNew.stop();
  print(
    'Baseline (new client each time): ${stopwatchNew.elapsedMilliseconds} ms',
  );

  // Optimized: reuse the client
  final sharedClient = HttpClient();
  sharedClient.connectionTimeout = const Duration(seconds: 3);
  final stopwatchReused = Stopwatch()..start();
  for (var i = 0; i < iterations; i++) {
    try {
      final req = await sharedClient.openUrl('GET', url);
      final res = await req.close();
      await res.drain<void>();
    } catch (_) {}
  }
  stopwatchReused.stop();
  sharedClient.close(force: true);

  print('Optimized (reused client): ${stopwatchReused.elapsedMilliseconds} ms');
}
