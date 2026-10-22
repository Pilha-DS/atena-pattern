# App do projeto

`application/frontend` é o app do produto, fora do padrão. Tema, tokens, TOAT e
widgets vêm de `packages/atena_ui` por caminho.

```text
lib/src/
├── app.dart                    MaterialApp, tema e TOAT
├── core/
│   ├── config/                 nome do app e URL da API
│   └── network/                ApiClient, ApiEnvelope, ApiException
└── features/
    └── home/presentation/      tela inicial
```

Regras: feature não importa outra feature; todo texto visível vai para
`core/strings`; widget novo nasce em `packages/atena_ui`, não aqui.

## Rodar

Com Docker (raiz do repositório): `make up` — o app fica em
`http://localhost:8080` e o nginx do container encaminha `/api` para a API.

Local:

```bash
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:8000/api/v1
```

## Próximos passos

1. criar `core/strings/app_strings.dart`;
2. criar `core/preferences` para tema e sessão;
3. criar a feature de autenticação (`data`, `domain`, `presentation`);
4. criar a feature do domínio com lista paginada e `StatusView`;
5. trocar a paleta em `app.dart`.

Ver `docs/FRONTEND.md`.
