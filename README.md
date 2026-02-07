# local-proxy-for test

Proxy HTTP local (macOS) lancé via **Docker Compose**, écoutant sur **localhost:3128**, avec **authentification Basic obligatoire**.

- **Login :** `login1234`  
- **Mot de passe :** `passwd1234`

> Ce proxy est un **proxy HTTP forward** (Tinyproxy).  
> Pour les URL `https://...`, les clients utiliseront généralement la méthode `CONNECT` via le proxy (supportée par Tinyproxy).

## Pré‑requis

- macOS
- **Docker Desktop** installé et démarré

## Démarrage

Depuis la racine du dépôt :

```bash
docker compose up -d
```

Vérifier que le conteneur tourne :

```bash
docker ps
```

## Test rapide avec curl

### 1) Sans authentification (doit être refusé)

```bash
curl -I -x http://localhost:3128 http://example.com
```

Attendu : un refus (statut **407 Proxy Authentication Required** ou erreur équivalente).

### 2) Avec mauvais identifiants (doit être refusé)

```bash
curl -I -x http://bad:creds@localhost:3128 http://example.com
```

Attendu : un refus (**407**).

### 3) Avec les bons identifiants (doit fonctionner)

```bash
curl -I -x http://login1234:passwd1234@localhost:3128 http://example.com
```

Attendu : une réponse **200/301/302** (selon le site).

## Arrêt

```bash
docker compose down
```

## Fichiers

- `docker-compose.yml` : orchestre le conteneur
- `Dockerfile` : construit une image minimale basée sur Debian *bookworm-slim* + Tinyproxy
- `tinyproxy/tinyproxy.conf` : configuration du proxy (port 3128 + BasicAuth)
