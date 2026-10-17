# Lucky Diamond: spec

## Legal position (settled)

Australian online pokies are a prohibited interactive gambling service under
the Interactive Gambling Act 2001, and no Australian jurisdiction can licence
them online. The owner cites ACMA v Jones [2026] FCA 860 ($24.24m, including
$9m personally against a director) as the governing example, including its
finding that "virtual currencies do not launder the product".

Therefore:

- The product stays **free play**. No deposits, no cash-out, no prizes.
- **Do not build:** USDC or any crypto rail, HD deposit addresses, chain
  watchers, withdrawals, KYC, AML, or licensing work.
- **Do build** the parts that would hold up if real money were ever added
  under a proper licence elsewhere: server-authoritative spins, a shared
  engine, provable fairness, and an append-only ledger.

## Technical decisions (settled)

- The client is no longer the source of truth. Spins run on the server and
  the client animates toward the stops it returns.
- The app and the server share **one** engine, the pure Dart package in
  `packages/engine`. The server depends on it; it is never ported.
- Results are provably fair by HMAC commit-reveal:
  `stops[reel] = HMAC_SHA256(serverSeed, "clientSeed:nonce:reel") mod stripLength`.
  `sha256(serverSeed)` is published before play; the seed is revealed when it
  is rotated.
- Play credits live in an append-only, double-entry ledger in **integer
  credits**. Every transaction nets to zero, and `post()` is the only code
  that changes a balance.
- Offline free play still works, using `Random.secure()` on the device.

## Scope

In:

1. Extract the engine into `packages/engine` (pure Dart, no Flutter).
2. `server/`: Dart `shelf` + `postgres`, depending on `packages/engine`.
3. Migration: players, accounts, transactions, ledger_entries, server_seeds,
   spins, the deferred balance trigger, and reconciliation views.
4. Ledger `post()` with tests: a two-entry transaction nets to zero, an
   unbalanced one is rejected, entries are immutable.
5. Provable fairness: seed lifecycle (commit, rotate, reveal) with
   known-vector tests.
6. Spin service and `/spin` route, idempotent on a client-supplied `spinId`.
7. Client API, and a mode switch in `pokie_screen.dart` between server and
   offline play.
8. Leaderboards, a daily bonus, and at least two more machines.
9. Deploy workflow for the server and Postgres.
10. `site/` copy: social casino framing, a fairness page and a leaderboard
    page.

Out: USDC, wallets, KYC, AML, licensing. The pay table maths does not change;
RTP stays about 93% unless the RTP simulation is re-run and the number shown.

## Non-negotiables

- All existing tests pass after every step.
- Offline free play keeps working.
- Integer credits everywhere; no doubles in the ledger path.
- `post()` is the only thing that mutates a balance.

## Progress

| Step | Status |
| --- | --- |
| 1. Engine package | Done |
| 2–10 | Not started |
