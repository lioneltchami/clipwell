# Stripe Checkout and Fulfillment

> **Status: infrastructure deployed; checkout intentionally inactive.** Clipwell has a live Stripe Product, one-time $19.00 Price, and Payment Link, but the Payment Link is deactivated until immediate buyer delivery, seller disclosures, and production acceptance tests are complete. No buyer should be charged before that point.

## Existing Stripe Objects

| Item | Identifier | Status |
|---|---|---|
| Product | `prod_V7MV4FUvszux4z` — Clipwell Launch License | Live, not advertised |
| One-time price | `price_1U77mVEVzFnhjdMp7In8STcw` — USD 19.00 | Live |
| Payment Link | `plink_1U77n7EVzFnhjdMpBy2ZR8HQ` | **Deactivated** |
| Fulfillment webhook | `we_1U78MZEVzFnhjdMp4KI5DsK6` | Enabled, points to the deployed fulfillment Worker |

The product title does not imply that purchase revokes, supersedes, or grants exclusive rights in MIT-covered source. The final marketed offering must identify the original paid value, managed delivery, support scope, and update access that the buyer receives.

For the first launch, the paid value is **Recording Presets**: customers can save and apply named portable capture setups for video, audio, camera, countdown, overlay, and content-filter settings. The USD 19.00 one-time Launch Package includes the signed/notarized commercial build containing that feature, secure buyer delivery, best-effort purchase and installation support for 30 days, and a 30-day refund window. It does not promise a future-update term.

## Fulfillment Architecture

Stripe Checkout remains hosted by Stripe. The public site never receives card data or Stripe secret keys. A verified `checkout.session.completed` webhook reaches the Clipwell fulfillment Worker, which validates the `Stripe-Signature` against a Worker secret, records the event idempotently in D1, creates one entitlement, and issues a short-lived portal token. The buyer is also redirected to a Worker-hosted completion page that waits for the verified webhook record and then grants immediate secure portal access.

The buyer portal streams a DMG only after an active entitlement and a valid one-time download grant are present. Commercial DMGs live in a private R2 bucket. The Worker handles re-download requests without revealing whether an entered email address owns a purchase. A succeeded Stripe refund marks the entitlement refunded and prevents future grants; it cannot recall a binary that was already downloaded.

## Customer Terms Already Chosen

| Topic | Current decision |
|---|---|
| Support contact | `support@getclipwell.com` |
| Refund window | 30 days |
| Price | USD 19.00 one-time purchase |
| Checkout provider | Stripe-hosted Payment Link |
| Source-rights boundary | Existing MIT rights and notices remain preserved |

## Mandatory Launch Inputs Still Missing

Do not reactivate checkout or publish a purchase button until these facts exist and are verified.

| Required item | Why it blocks launch |
|---|---|
| Seller legal name, jurisdiction, and business/postal address | Required for accurate terms, consumer disclosures, invoices, privacy notices, and refund handling. |
| Final paid entitlement | Defined as Recording Presets, secure delivery of the commercial build, best-effort purchase and installation support for 30 days, and a 30-day refund window. Final customer terms must state that no future-update term is promised. |
| Transactional email sender verification | Resend is selected, but `getclipwell.com` must complete DNS verification before `Clipwell <downloads@getclipwell.com>` can send fulfillment email. |
| Private commercial DMG and release record | Recording Presets is implemented, but the portal has no signed/notarized commercial artifact yet and must not deliver the historic public release as a paid-exclusive file. |
| Sandbox and live acceptance results | Payment, webhook, portal, download, refund, receipt, and support flows must be tested before live sale. |
| Tax and privacy decision | The seller must decide whether to use Stripe Tax and publish the applicable privacy and sales terms. |

## Activation Sequence

1. Finalize and publish counsel-reviewed seller information for Apoti Tech Inc., privacy policy, terms of sale, refund process, tax treatment, and the Recording Presets Launch Package entitlement.
2. Configure an authenticated transactional email sender and store only its API key in the Worker secret store.
3. Produce a commercial build with material original value, retain `LICENSE` and `NOTICE.md`, sign/notarize it, and place the DMG in private R2 storage.
4. Add and activate the release record in D1. Verify direct bucket access is not public.
5. Configure the Payment Link post-payment redirect to the deployed Worker’s `/purchase/complete?session_id={CHECKOUT_SESSION_ID}` route.
6. Run the documented Stripe sandbox tests. Then run a controlled live test and verify the event, entitlement, immediate portal access, email, receipt, re-download, and refund revocation.
7. Update the public marketing-site variables only after all prior steps pass, then reactivate the Payment Link.

## Public Site Safety Gate

The static site may contain only the non-secret values below. It must remain disabled until the activation sequence is complete.

| Variable | Required launch value |
|---|---|
| `PUBLIC_STRIPE_CHECKOUT_ENABLED` | `true` only after acceptance tests pass |
| `PUBLIC_STRIPE_PAYMENT_LINK` | The active Stripe Payment Link URL |
| `PUBLIC_STRIPE_PRODUCT_LABEL` | Buyer-facing final product label |

Never add Stripe secret keys, webhook signing secrets, customer data, Worker tokens, R2 credentials, or email-provider credentials to the static site, GitHub Actions public variables, or a client-side bundle.
