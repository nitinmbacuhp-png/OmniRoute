# GLOBAL STUDY OS — Implementation Contract

## Mission

Transform OmniRoute into a production-grade, multi-tenant B2B study-abroad application operating system while preserving OmniRoute's existing AI-router functionality.

This document is the implementation contract for coding agents working on `codex/global-study-os`.

## Non-negotiable engineering rules

1. Inspect existing architecture before modifying it.
2. Preserve existing OmniRoute routing, provider, MCP/A2A, auth, database, CLI and dashboard functionality unless a change is demonstrably required.
3. Build Global Study OS as a modular bounded context, not as a destructive rewrite.
4. Never fabricate university requirements, fees, deadlines, application APIs or submission capabilities.
5. Eligibility must remain deterministic and auditable; AI may rank/explain but must not override authoritative rules.
6. Uploaded documents are untrusted input. AI extraction may propose values but must never silently overwrite verified student data.
7. Every tenant-owned read/write must enforce server-side authorization.
8. Irreversible application submission requires the configured human-approval gate by default.
9. Never bypass CAPTCHA, MFA, authentication, anti-bot controls, access restrictions or institutional security controls.
10. Secrets remain server-side and must use the repository's existing secret/configuration patterns.
11. Real external integrations must be represented by adapters. Unsupported institutions must fall back to manual/human-action workflows or simulation in explicitly marked demo mode.
12. Do not claim that a test, build, migration, integration or deployment succeeded unless it was actually executed and verified.

## Product bounded contexts

- Partner organization and branch management
- Identity/RBAC/authorization
- Student Digital Twin
- Document Intelligence
- University/Campus/Program/Intake catalog
- Requirement and deterministic Eligibility Engine
- AI Match and Shortlist Engine
- Application CRM and state machine
- Application Preflight
- Authorized Submission Connectors
- Offer/Deposit/CAS/LOA/COE workflow
- Visa-readiness workflow (non-authoritative)
- Tasks, SLAs and deadlines
- Commission ledger and reconciliation
- Partner/University analytics
- AI Command Center and tool permissions
- Notifications
- Audit/event ledger
- Integrations and automation
- SaaS entitlements/billing
- System health/observability

## Required vertical slice

The first production-grade vertical slice must support:

`login → partner organization → counsellor → student → document upload → structured extraction/review → eligibility → course search → AI-assisted shortlist → compare → application draft → preflight → blocker resolution → human approval → simulation/manual submission connector → confirmation → application timeline → tasks/deadlines → analytics`

Real university submission must only be enabled when an authorized connector actually exists.

## Canonical application states

`LEAD → PROFILE_CREATED → DOCUMENTS_PENDING → PROFILE_VERIFIED → SHORTLISTED → APPLICATION_READY → SUBMISSION_PENDING → SUBMITTED → UNDER_REVIEW → CONDITIONAL_OFFER → UNCONDITIONAL_OFFER → DEPOSIT_PENDING → DEPOSIT_PAID → CAS_LOA_COE_PENDING → CAS_LOA_COE_RECEIVED → VISA_PREPARATION → VISA_SUBMITTED → VISA_DECISION → ENROLLED`

Terminal/alternate states: `WITHDRAWN`, `REJECTED`.

State transitions must be explicit, validated and audited.

## Eligibility result states

- `ELIGIBLE`
- `CONDITIONALLY_ELIGIBLE`
- `NOT_ELIGIBLE`
- `UNKNOWN_REQUIRES_REVIEW`

Each result must retain rule/evidence/source metadata and an engine version.

## Preflight result states

- `PASS`
- `WARNING`
- `BLOCKER`

A `BLOCKER` prevents automated submission.

## Recommendation model

Separate academic/admission recommendation from commercial value. Store explainable component scores such as academic fit, English fit, budget fit, career fit, intake fit, destination fit, application complexity, scholarship fit and risk. Commercial commission must never silently override eligibility.

## Data provenance

Important university/program facts must support source, source URL when available, verification timestamp, verification status, effective date and freshness/staleness state. Prefer official institutional or government sources.

## AI governance

Record model/provider, prompt version, timestamp, input snapshot/hash where safe, output, confidence where meaningful and human override/final decision. Keep agents least-privileged and tool-scoped.

## Agent execution loop

Agents should repeatedly follow:

`INSPECT → PLAN → IMPLEMENT → FOCUSED TEST → FIX → INTEGRATION TEST → SECURITY REVIEW → BUILD → RETEST`

Do not stop after documentation or UI scaffolding. Continue until the strongest verified vertical slice is functional.

## Completion report

At the end of each substantial implementation pass report:

- implemented modules
- files changed
- database/migration changes
- environment variables required
- tests actually run and results
- build result
- security/tenant-isolation checks
- real integrations versus adapters/manual workflows
- remaining blockers
