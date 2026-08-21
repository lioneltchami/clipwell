# Stripe Checkout Readiness

> **Status: no Stripe product, price, payment link, Checkout Session, or payment collection flow has been created for Clipwell.** The website uses a disabled commercial-checkout placeholder until the decisions below are complete.

A Stripe payment link should be created only after the commercial offer is real, its terms are published, and the seller is ready to accept payment. Creating a live payment link before those facts are set can expose customers to an unclear purchase, missing refund disclosures, or an unsupported service commitment.

## Required Inputs

| Input | Decision required before creation |
|---|---|
| Seller | Legal seller name, business address, Stripe account, and customer support contact. |
| Product | Exact commercial offering, such as support package, managed service, original add-on, or paid update term. |
| Price | Amount, currency, one-time versus recurring billing, renewal schedule, and any quantity limits. |
| Tax | Whether tax collection applies, registration status, and the jurisdictions to collect in. |
| Refunds | Published refund, cancellation, and renewal policy. |
| Fulfilment | What the buyer receives, when delivery begins, and how entitlement or support is verified. |
| Privacy | Payment-data handling, processor disclosure, and any account or service data collected after purchase. |
| URLs | Production success URL, cancellation URL, support URL, and final commercial terms URL. |

## Proposed Non-Live Product Shape

The current draft is intentionally non-priced. If Clipwell launches commercially, the first Stripe product should describe the value that is actually commercial rather than trying to relabel the MIT-covered public release. A conservative first option is **Clipwell Commercial Support**, with a one-time or annual support term whose scope, response target, exclusions, and renewal rules are published before checkout.

## Activation Checklist

1. Finalize the commercial terms in [`COMMERCIAL_LICENSE.md`](../COMMERCIAL_LICENSE.md) and the policy in [`COMMERCIALIZATION.md`](COMMERCIALIZATION.md).
2. Supply every required input above and obtain legal, tax, and consumer-disclosure review appropriate to the seller’s jurisdiction.
3. Create the Stripe Product and Price, then create a payment link or Checkout Session with production success and cancellation URLs.
4. Test the purchase in Stripe test mode, including receipt, tax behavior, failed payment, refund, and customer-support handoff.
5. Replace the disabled website placeholder only after the live link, refund policy, privacy policy, and fulfilment process are verified.

## Current Website Behavior

The public site deliberately labels commercial support as **planned** and the checkout as **coming soon**. It does not collect payment information, create a Stripe session, or claim a price, subscription, or commercial entitlement.
