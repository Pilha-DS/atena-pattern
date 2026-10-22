/// Configuração de execução. Troque por `--dart-define` em cada ambiente.
class AppConfig {
  const AppConfig._();

  static const String appName = 'Atena App';
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000/api/v1',
  );
}
