# Commercialization Status and Policy

> **Status: private-delivery infrastructure is deployed, but commercial sales are not live.** The live $19.00 Stripe Payment Link is deactivated and unadvertised. Final seller disclosures, a truthful paid entitlement, transactional email, an original commercial release, and production acceptance tests remain required before purchase can be offered.

Clipwell includes MIT-covered material and preserves the upstream BetterCapture attribution in [`NOTICE.md`](../NOTICE.md). This document records the current distribution boundary; it is not a customer contract, final commercial license, tax advice, or legal advice.

## What the Historic MIT Release Means

The MIT License permits use, modification, distribution, sublicensing, and sale of covered software subject to preserving the copyright and permission notice in copies or substantial portions of that software. Publicly released MIT rights cannot be withdrawn by later making the repository private, removing a public release, or offering a paid download channel.

The v1.0.0 and v1.0.1 public releases are historical MIT-era releases. The application repository is now private for future development and release handling, but that privacy change does not make old copies exclusive or erase prior grants. Any Clipwell distribution containing substantial MIT-covered material must preserve `LICENSE` and `NOTICE.md` and must not imply upstream endorsement.

## Current Distribution Surfaces

| Surface | Status | Purpose |
|---|---|---|
| Private `lioneltchami/clipwell` repository | Active | Future source, internal CI, signing, and build traceability |
| Private GitHub releases | Active | Build-team artifacts only; not buyer delivery |
| Private R2 release bucket | Active | Future signed/notarized commercial DMGs |
| Fulfillment Worker | Active | Stripe signature verification, idempotent entitlement creation, buyer portal, one-time download grants, refund revocation, and an informational appcast |
| Public marketing site | Active, checkout disabled | Product information only until launch requirements are met |
| Stripe Payment Link | Deactivated | Held for future verified launch |

## Paid-Offer Boundary

A buyer may pay for genuine original value such as a proprietary add-on, a materially improved original commercial build, a managed and supported release channel, defined support services, or hosted capabilities. The paid offer must state that value plainly. It must not claim that the buyer is purchasing the right to use MIT-covered source or that the seller can restrict rights already granted by MIT.

The first proposed **Clipwell Launch Package** is a USD 19.00 one-time purchase of a signed and notarized commercial build that includes the original **Recording Presets** feature. Recording Presets lets a customer save and apply named portable capture setups for video, audio, camera, countdown, overlay, and content-filter settings. The package also includes secure buyer delivery, best-effort purchase and installation support for 30 days at `support@getclipwell.com`, and a 30-day refund window. It does not promise a future-update term.

| Potential paid value | Required truthfulness condition |
|---|---|
| Original add-ons or hosted features | Identify the original material and retain notices for incorporated MIT components. |
| Managed commercial release channel | Describe delivery, update access, support scope, and any time limit without claiming exclusivity over historic MIT code. |
| Commercial support | Define channel, response expectations, exclusions, and duration; do not imply support that is not staffed. |
| Team or deployment services | Treat the service agreement as separate from the MIT license for the application code. |

## Decisions Still Required Before Sales

| Decision | Current state |
|---|---|
| Seller identity, jurisdiction, and address | Stripe account identifies **Apoti Tech Inc.**, Calgary, Alberta, Canada. Final public terms must use the exact legal business address on the Stripe account and be reviewed before publication. |
| Final customer entitlement | Defined for launch: Recording Presets, secure delivery of the purchased commercial build, best-effort purchase and installation support for 30 days, and a 30-day refund window. No future-update term is promised. |
| Refund policy | 30-day refund window approved; operating workflow still requires final seller terms. |
| Buyer support contact | `support@getclipwell.com` supplied; mailbox and operating process must be ready. |
| Transactional delivery email | Provider credentials and authenticated sender not configured. |
| Privacy and tax posture | Not finalized. |
| Paid commercial DMG | Recording Presets is implemented, but a signed/notarized commercial DMG has not yet been produced or placed in the private release bucket. |
| Production acceptance | Not yet run end to end. |

## Public-Website Rule

The public site must not advertise a paid claim until the full commercial checklist passes (paid entitlement, seller disclosures, privacy and tax policy, delivery email, release artifact, and tests are complete). Static-site variables may contain only the public Stripe Payment Link and display labels; all secret material belongs in the fulfillment Worker’s secret store.

When the launch requirements are complete, obtain jurisdiction-appropriate legal review, update the public site and customer terms together, complete a controlled live purchase and refund test, then reactivate the Payment Link. Until then, the correct public position is that commercial delivery is in preparation, not that the historic MIT application has become exclusive paid software.
