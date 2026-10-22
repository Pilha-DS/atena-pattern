# Template de app

Base de um app Flutter com o padrão: tema parametrizável, TOAT, cliente do
envelope e estrutura feature-first.

## Copiar

```bash
cp -r atena-pattern/templates/frontend meu-app
cd meu-app
flutter create . --project-name meu_app --platforms=android,ios,web
```

O `flutter create .` completa as pastas de plataforma sem sobrescrever `lib/`.
Depois:

1. ajuste `name` em `pubspec.yaml`;
2. troque a dependência `atena_ui` para git com tag em produção;
3. troque `AppConfig.apiBaseUrl` pelo endereço da API;
4. troque a paleta em `app.dart` (`AppTheme.light(palette: ...)`);
5. rode:

```bash
flutter pub get
flutter run
```

## Estrutura

```text
lib/src/
├── app.dart                    MaterialApp, tema e TOAT
├── core/
│   ├── config/                 URL da API e nome do app
│   └── network/                ApiClient, ApiEnvelope, ApiException
└── features/
    └── home/presentation/      tela de exemplo
```

Regras: feature não importa outra feature; todo texto visível vai para
`core/strings`; todo widget novo nasce no `atena_ui`, não aqui.

## Próximos passos

1. criar `core/strings/app_strings.dart`;
2. criar `core/preferences` para tema e sessão;
3. criar a feature de autenticação (`data`, `domain`, `presentation`);
4. criar a feature do domínio com lista paginada e `StatusView`;
5. configurar `AppConfig.apiBaseUrl` por `--dart-define`.

Ver `docs/FRONTEND.md` e `docs/BACKEND.md`.
