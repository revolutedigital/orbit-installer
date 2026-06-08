# Orbit Installer

> Instalador moderno em PT-BR pra **[Orbit Linux](https://github.com/revolutedigital/orbit-linux)**.
> Fork do excelente [readymade](https://github.com/FyraLabs/readymade) da Fyra Labs com
> identidade Orbit + tela de manifesto de privacidade + tom honesto.

## O que este fork tem de diferente do upstream

Customizações específicas pro Orbit Linux, mantidas na branch `orbit-main`:

### 1. PT-BR no tom Orbit

`po/pt-BR/readymade.ftl` reescrito do zero:
- **2ª pessoa direta** — "você" em vez de "Por favor, defina"
- **Linguagem do leigo** — "Apagar o Windows" em vez de "Disco Inteiro"
- **Honestidade nos pontos críticos** — "Atenção: vou apagar a partição EFI. Outro
  sistema vai deixar de bootar. Isso não tem volta."
- **Marca "Gravidade/órbita" com moderação** — só na boas-vindas e na conclusão
  ("Pronto. O Orbit já é seu. Reinicie pra entrar na sua nova órbita.")

### 2. Tela Privacy (manifesto)

`src/pages/privacy.rs` — nova página inserida entre "Como instalar" e "Confirmar"
no fluxo de wholedisk:

> **Seus dados ficam aqui.**
>
> O Orbit aprende como você trabalha. Tudo o que ele aprende fica neste computador —
> nada vai pra nuvem, ninguém além de você vê.
>
> Você pode auditar e apagar tudo o que o Orbit aprendeu sobre você, a qualquer
> momento. Ao instalar, você reconhece que é assim que ele funciona.
>
> **[Entendi]**

Não é configuração de privacidade (privacidade no Orbit é **inegociável**, não opt-in).
É **declaração de identidade**: o usuário pausa, lê o manifesto, e afirma que entendeu
o que o Orbit é. Inspirado em Pop!_OS e Tails.

### 3. Bento cards-manifesto durante install

Os 3 cards que aparecem enquanto a instalação roda (estilo slideshow Mint/Pop) foram
trocados de Welcome/Help/Contribute genéricos pra 3 mensagens-chave do Orbit:
- **Ele aprende. Você continua privado.** (privacidade on-device)
- **Ele não quebra sozinho.** (rollback atômico)
- **Ele organiza por você.** (agente Orbit)

Template em `crates/libreadymade/templates/orbit.toml`.

## Como é distribuído

Este fork **não publica RPM próprio**. É buildado in-tree pelo Containerfile do
orbit-linux como multi-stage Rust:

```dockerfile
FROM quay.io/fedora/fedora:42 AS installer-builder
# ... Terra repo (Fyra Labs) pra libhelium-devel ...
RUN git clone --depth 1 --branch orbit-main --recurse-submodules --shallow-submodules \
        https://github.com/revolutedigital/orbit-installer.git
RUN cargo build --release --locked
```

O binário e assets vão pra imagem final do Orbit Linux via `COPY --from=installer-builder`.

> ⚠ **Atenção ao submodule**: `crates/taidan_proc_macros` aponta pra
> `FyraLabs/rdms_proc_macros`. Sempre clonar com `--recurse-submodules`, senão o build
> falha.

## Manutenção: rebase do upstream

Quando o readymade upstream lançar versão nova (Fyra Labs publica releases mensais):

```bash
git remote add upstream https://github.com/FyraLabs/readymade.git
git fetch upstream
git checkout orbit-main
git rebase upstream/main
# Resolver conflitos em po/pt-BR/readymade.ftl, src/main.rs, src/pages/mod.rs
# Re-aplicar src/pages/privacy.rs se desfizer
git push --force-with-lease origin orbit-main
```

Depois, retag uma release do orbit-linux pra rebuildar a imagem.

## Pegadinhas conhecidas

- A macro `page!` gera automaticamente uma chamada `t!("page-<nome>")` pro título —
  ao adicionar página nova, criar a chave nas DUAS locales (`po/pt-BR/` e `po/en-US/`).
  O `i18n-embed-fl` valida em compile time contra en-US.
- O match em `src/main.rs:139` (renderiza o widget atual) precisa cobrir todas as
  variantes de `Page::*`. Adicionar uma sem essa entrada quebra com `non-exhaustive
  patterns`.
- `cargo build --locked` falha se o `Cargo.lock` divergir do upstream — depois de
  rebase, rodar `cargo update -p <crate-divergente>` ou `cargo generate-lockfile` se
  necessário.

## Hacking

Pra contribuir com o readymade em si (não com a customização Orbit), siga o
[HACKING.md](HACKING.md) e contribua **upstream em FyraLabs/readymade** — este fork
não aceita PRs que não sejam customizações específicas do Orbit.

Pra contribuir com o Orbit Linux (e suas customizações neste fork), abra issue em
https://github.com/revolutedigital/orbit-linux.

## Licença

Mantém a do upstream: **GPL-3.0-or-later** (Copyright © 2024~2025 Fyra Labs &
Ultramarine Linux Contributors).

Customizações Orbit (PT-BR, tela Privacy, bento cards) também GPL-3.0-or-later,
Copyright © 2026 Revolute Digital / Orbit Linux Contributors.

## Créditos

Este fork seria impossível sem o trabalho excepcional da [Fyra Labs](https://fyralabs.com/)
e da comunidade do [Ultramarine Linux](https://ultramarine-linux.org/). O readymade
upstream é o instalador mais maduro pra distros bootc em 2026 — fazer um fork foi a
escolha mais barata e mais respeitosa que conseguimos.
