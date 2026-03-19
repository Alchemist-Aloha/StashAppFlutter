import 'package:flutter/material.dart';

class ErrorStateView extends StatelessWidget {
  const ErrorStateView({
    required this.message,
    this.onRetry,
    this.retryLabel = 'Retry',
    super.key,
  });

  final String message;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onRetry, child: Text(retryLabel)),
            ],
          ],
        ),
      ),
    );
  }
}
