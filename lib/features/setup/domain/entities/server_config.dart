import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_config.freezed.dart';

@freezed
class ServerConfig with _$ServerConfig {
  const factory ServerConfig({
    required String baseUrl,
    required String apiKey,
  }) = _ServerConfig;
}
