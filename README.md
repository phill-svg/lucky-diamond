# Lucky Diamonds

A free-play 5-reel pokie built with Flutter. It runs on the web and on
iPhone. Players spin with play credits that have no cash value; there are
no real-money bets, purchases or payouts.

## How it plays

- 5 reels × 3 rows, 10 fixed paylines, wins pay left to right.
- 💎 Wild substitutes for everything except ⭐ Scatter, and pays on its own.
- ⭐ Scatter pays anywhere on the reels (3, 4 or 5) as a multiple of the total bet.
- Line bet 1–20 credits per line, auto spin, and a free top-up when credits run out.
- Return to player is about 93% (check with `dart run tool/rtp.dart`).

## Website

The site has two parts:

- `/`: the homepage (`site/index.html` and `site/styles.css`). Plain HTML and
  CSS with the hero, games list, how it works, and play-responsibly sections.
- `/play/`: `site/play/index.html` shows a slim bar with a **Lobby** link and
  loads the Flutter game from `/play/app/` underneath it.

On the web the game opens straight onto the reels. The iPhone app still opens
on its own start screen (`lib/pokie/home_screen.dart`).

## Code

| Path | What it is |
| --- | --- |
| `site/` | The website homepage and the `/play/` page around the game |
| `lib/main.dart` | App entry point; opens on the homepage |
| `lib/pokie/home_screen.dart` | Homepage with Play now and How to play |
| `packages/engine/` | The slot engine: reel strips, paylines, pay table and win evaluation (pure Dart package, shared by app and server) |
| `lib/pokie/pokie_screen.dart` | The machine UI: animated reels, meters, controls, pay table sheet |
| `tool/rtp.dart` | Simulates spins to estimate return to player after changing pays or reels |
| `test/` | App widget tests (engine tests live in `packages/engine/test/`) |

## Run it

```sh
flutter pub get
flutter run -d chrome      # play in the browser
flutter test
(cd packages/engine && dart test)
```

## Put it online

`.github/workflows/deploy-web.yml` builds the game, puts it under `/play/app/`
next to the `site/` pages, and publishes everything to GitHub Pages. One-time setup: in the repo's **Settings → Pages**, set
**Source** to **GitHub Actions**. Then run the workflow from the **Actions**
tab. The game will be at `https://phill-svg.github.io/lucky-diamond/`.

`.github/workflows/unsigned-ipa.yml` builds an unsigned iOS IPA for
sideloading.
