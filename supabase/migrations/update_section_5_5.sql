-- ============================================================================
-- UPDATE SECTION 5.5: Privacy, Security & Compliance Basics
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Privacy and Security Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Privacy and Security Quiz'), 5,
'How does data flow design from Section 5.1 relate to privacy compliance?',
'["Data flow and privacy are unrelated", "Data flow mapping identifies where personal data enters, moves, and is stored, which is essential for privacy impact assessments and compliance documentation", "Privacy only applies to storage", "Data flow design is purely technical"]',
1,
'Privacy compliance requires knowing what data you have and where it goes. Data flow mapping from Section 5.1 provides the foundation for privacy documentation and impact assessments.'),

((SELECT id FROM quizzes WHERE title = 'Privacy and Security Quiz'), 6,
'When using AI in the execution layer, what privacy considerations apply?',
'["AI processing has no privacy implications", "Personal data sent to AI services may be retained or used for training, requiring consent disclosure and vendor assessment", "Only use Fast/Cheap tier for privacy", "AI vendors are always compliant"]',
1,
'AI processing of personal data creates privacy obligations. You must understand vendor data practices, include them in privacy notices, ensure appropriate data processing agreements, and potentially obtain specific consent.'),

((SELECT id FROM quizzes WHERE title = 'Privacy and Security Quiz'), 7,
'What is the relationship between schema design and privacy by design principles?',
'["Schema design is purely technical", "Schema should implement privacy by design through data minimization, purpose limitation fields, retention metadata, and consent tracking", "Privacy is handled after schema design", "Only compliance teams consider privacy"]',
1,
'Privacy by design means building privacy into systems from the start. Schema should include only necessary fields (minimization), track purposes for data use, include retention dates, and store consent records.'),

((SELECT id FROM quizzes WHERE title = 'Privacy and Security Quiz'), 8,
'How should the output layer from Module 2 handle personal data in notifications and reports?',
'["Personal data can be freely included", "Outputs should minimize personal data exposure, use pseudonyms where possible, and ensure recipients have legitimate need for the data", "Only encrypt outputs", "Output layer is not relevant to privacy"]',
1,
'The output layer distributes data widely. Privacy requires minimizing personal data in notifications, considering who sees reports, and ensuring outputs do not expose data beyond intended recipients.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Privacy, Security & Compliance Basics

This section does not make you a lawyer. It makes you a competent operator who knows when to escalate.

As an operator handling data, you bear responsibility for protecting it. Privacy and security are not someone else''s problem. Violations result in fines, lawsuits, and destroyed trust. This section provides the foundation for handling data responsibly and recognizing when you need professional help.

## Definitions

**PII (Personally Identifiable Information)**: Data that can identify a specific individual. Includes obvious identifiers (name, email, phone, address) and less obvious ones (IP address, device ID, location data).

**Sensitive Personal Data**: Categories of PII requiring extra protection. Includes health information, financial data, racial/ethnic origin, political opinions, religious beliefs, sexual orientation, biometric data.

**Data Subject**: The individual whose personal data is being processed. In privacy regulations, data subjects have rights over their data.

**Data Controller**: The entity that determines why and how personal data is processed. If you decide to collect customer emails for marketing, you are the controller.

**Data Processor**: An entity that processes data on behalf of a controller. Your email marketing vendor is a processor handling data you control.

**Consent**: Permission from the data subject to process their data. Must be freely given, specific, informed, and unambiguous.

**Legitimate Interest**: A legal basis for processing data without consent when you have a genuine business need and it does not override the individual''s rights.

**Data Minimization**: Collecting only the data you actually need. Do not collect "just in case."

**Purpose Limitation**: Using data only for the purposes you stated when collecting it.

**Data Retention**: How long you keep data. Should not be longer than necessary for the stated purpose.

**Data Breach**: Unauthorized access, disclosure, or destruction of personal data.

**Privacy by Design**: Building privacy considerations into systems from the beginning, not as an afterthought.

**DPA (Data Processing Agreement)**: A contract between controller and processor specifying data protection obligations.

## Why Privacy and Security Matter

This is not theoretical. Real consequences follow from mishandling data.

**Regulatory fines can be severe.** GDPR allows fines up to the greater of 20 million euros or 4 percent of global annual revenue. CCPA enables statutory damages and enforcement actions. Many jurisdictions have similar powers.

**Legal liability extends beyond fines.** Class action lawsuits, individual claims, and regulatory investigations create legal exposure. Directors and officers can face personal liability.

**Reputation damage is lasting.** Data breaches make headlines. Customers leave. Trust takes years to rebuild.

**Business relationships require compliance.** Enterprise clients mandate vendor security assessments. Failing assessment means losing the contract.

**Personal responsibility applies.** You can be personally liable for decisions you make about data handling.

## Compliance Maturity Ladder

Understanding where you are helps you prioritize what to do next.

**Level 1: Awareness.** You know what personal data you collect and where it is stored. This is the minimum starting point.

**Level 2: Basic Controls.** You have access controls, encryption, and consent mechanisms in place. You can respond to basic data requests.

**Level 3: Documented Compliance.** You have written policies, defined retention periods, conduct audits, and can demonstrate compliance if asked.

**Level 4: Enterprise-Ready.** You have formal certifications (SOC 2, ISO 27001), conduct Data Protection Impact Assessments, and can satisfy enterprise vendor requirements.

Most solo operators and small teams should aim for Level 2-3. Level 4 becomes relevant when selling to enterprise clients or handling high-risk data.

## Privacy vs Security: Different Failures

These terms are related but distinct. Understanding the difference helps you address problems correctly.

**Privacy failure:** Unlawful or inappropriate collection, use, or disclosure of personal data.
- Prevention: Consent, minimization, purpose limitation
- Detection: Audit logs, access reviews, complaint monitoring
- Response: Correct the practice, notify if required, document

**Security failure:** Unauthorized access to, theft of, or destruction of data.
- Prevention: Encryption, access control, patching, monitoring
- Detection: Intrusion detection, anomaly alerts, log analysis
- Response: Contain, assess, notify, remediate

A system can be secure but not privacy-compliant (encrypted data collected without consent). A system can be privacy-compliant but insecure (properly consented data stored without encryption). You need both.

## Core Privacy Concepts

### PII: What Counts as Personal Data

Personal data is broader than you might think.

**Direct identifiers clearly identify:**
Name, email address, phone number, physical address, social security number, passport number, driver''s license number, photo of face, fingerprint.

**Indirect identifiers can identify when combined:**
Date of birth, gender, job title, employer, city, zip code, IP address, device identifier, browser fingerprint, purchase history, location data.

**The combination test:** If combining pieces of data could identify someone, the combination is personal data. City + employer + job title might identify only one person.

### Sensitive Data Categories

Some personal data requires extra care.

**Health information** includes medical conditions, treatments, prescriptions, disabilities, mental health status. Subject to HIPAA in US healthcare contexts.

**Financial information** includes bank accounts, credit cards, income, debts, credit scores, financial transactions.

**Government identifiers** including social security numbers, passport numbers, driver''s license numbers, tax IDs.

**Biometric data** includes fingerprints, face scans, voice prints, retina scans.

**Political, religious, and philosophical beliefs** are protected categories in many jurisdictions.

**Racial or ethnic origin** is protected information.

**Sexual orientation and gender identity** are protected information.

**Criminal history** requires careful handling in employment contexts.

When in doubt about whether data is sensitive, treat it as sensitive.

## Key Regulations

### GDPR (European Union)

The General Data Protection Regulation applies to processing personal data of EU residents, regardless of where your business is located.

**Key rights for individuals:**

Right to access: Individuals can request copies of their data.

Right to rectification: Individuals can request correction of inaccurate data.

Right to erasure (right to be forgotten): Individuals can request deletion of their data.

Right to data portability: Individuals can request their data in machine-readable format.

Right to object: Individuals can object to certain processing.

Right to restrict processing: Individuals can request limits on how their data is used.

**Key obligations for organizations:**

Lawful basis: You must have a legal basis to process data (consent, contract, legal obligation, vital interests, public task, or legitimate interests).

Transparency: You must inform individuals about your data practices.

Purpose limitation: Use data only for stated purposes.

Data minimization: Collect only what you need.

Accuracy: Keep data accurate and up to date.

Storage limitation: Do not keep data longer than necessary.

Integrity and confidentiality: Protect data against unauthorized access and accidental loss.

Accountability: Be able to demonstrate compliance.

**Penalties:** Up to 20 million euros or 4 percent of annual global revenue, whichever is higher.

### CCPA/CPRA (California)

The California Consumer Privacy Act and its amendment, the California Privacy Rights Act, apply to businesses meeting certain thresholds that handle California residents'' data.

**Key rights for consumers:**

Right to know: What data is collected and how it is used.

Right to delete: Request deletion of personal information.

Right to opt out of sale: Prevent sale of personal information.

Right to non-discrimination: Cannot be penalized for exercising rights.

Right to correct: Request correction of inaccurate data.

Right to limit: Restrict use of sensitive personal information.

**Key obligations for businesses:**

Provide privacy notices explaining data practices.

Respond to consumer requests within specified timeframes.

Implement reasonable security measures.

Obtain consent for certain uses of sensitive data.

### HIPAA (US Healthcare)

The Health Insurance Portability and Accountability Act applies to covered entities and their business associates handling protected health information.

If you handle health data, you likely need HIPAA compliance. This requires specific technical, administrative, and physical safeguards.

### Industry-Specific Regulations

**Financial services:** GLBA, SOX, PCI-DSS for payment cards.

**Children''s data:** COPPA requires parental consent for data from children under 13.

**Telecommunications:** TCPA regulates calls and texts.

**State-level laws:** Many US states have privacy laws beyond California.

When in doubt about applicable regulations, consult legal counsel.

## Data Handling Best Practices

### Practice 1: Collect Only What You Need

Before adding a field, ask: Do we actually need this?

**Questions to consider:**

What will we use this data for?
Can we achieve the purpose with less data?
What is the risk if this data is breached?
How long will we need to keep it?

**Example:** You want to personalize emails with first name. You need first name. You do not need birth date, social security number, or mother''s maiden name.

Data minimization reduces breach impact and compliance burden.

### Practice 2: Get Proper Consent

When consent is your legal basis, do it right.

**Consent must be:**

Freely given: Not coerced or bundled with unrelated requirements.

Specific: For defined purposes, not blanket permission.

Informed: After clear explanation of what you will do.

Unambiguous: Requires affirmative action (not pre-ticked boxes).

**Consent must be revocable.** Make it as easy to withdraw consent as to give it.

**Document consent.** Record when consent was given, for what, and how.

### Practice 3: Be Transparent

People should know what happens to their data.

**Privacy policy should explain:**

What data you collect.
Why you collect it (purposes).
How you use it.
Who you share it with.
How long you keep it.
What rights individuals have.
How to exercise those rights.
How to contact you.

**Make the policy accessible.** Link from forms, settings, and footer.

**Write for humans.** Clear language, not legal jargon.

### Practice 4: Secure Data at Rest and in Transit

**Encryption at rest:** Stored data should be encrypted. If storage is compromised, encrypted data is protected.

**Encryption in transit:** Data moving across networks should use TLS/HTTPS. Prevents interception.

**Key management:** Encryption keys should be stored separately from encrypted data and rotated periodically.

### Practice 5: Control Access

**Principle of least privilege:** People get only the access they need for their role.

**Role-based access control:** Define roles with specific permissions. Assign people to roles.

**Review access regularly:** People change roles. Contractors leave. Former employees should not retain access.

**Audit access:** Log who accessed what and when.

### Practice 6: Implement Retention Policies

**Do not keep data forever.**

**Define retention periods for each data category:**

Transaction records: Keep for period required by tax law plus buffer.
Marketing consent: Keep until withdrawn or purpose expires.
Application data: Delete after hiring decision (unless consent to retain).
Support tickets: Keep for reasonable period, then archive or delete.

**Automate deletion.** Manual processes are forgotten.

**Document your policy.** Be able to explain retention decisions.

### Practice 7: Manage Vendors

Your vendors process data on your behalf. Their practices are your problem.

**Before engaging a vendor:**

Assess their security practices.
Review their privacy policy.
Understand where they store data.
Verify compliance certifications.

**Sign a DPA (Data Processing Agreement)** that specifies:

What data they receive.
What they can do with it.
Security requirements.
Breach notification obligations.
Deletion upon termination.

**Monitor vendor compliance.** Periodically review their practices.

### Practice 8: Plan for Breaches

Breaches happen. Having a plan reduces damage.

**Breach response plan should include:**

Detection: How will you know a breach occurred?
Containment: How do you stop ongoing breach?
Assessment: What data was affected? How many people? What harm?
Notification: Who must be notified and when? (Regulators often require 72-hour notification.)
Communication: What do you tell affected individuals?
Remediation: How do you prevent recurrence?
Documentation: Record everything for regulatory and legal purposes.

**Practice your plan.** Run tabletop exercises. Test procedures before you need them.

## Security Fundamentals for Operators

### Personal Security Practices

Your own security affects data you handle.

**Strong passwords plus password manager.** Unique complex password for every service. Password manager remembers them.

**Two-factor authentication everywhere.** Especially for email, cloud storage, and work systems.

**Secure your devices.** Full disk encryption. Screen lock. Remote wipe capability.

**Be careful with email.** Phishing is the most common attack vector. Verify unexpected requests through other channels.

**Use VPN on public WiFi.** Public networks are not secure.

**Log out when done.** Especially on shared devices.

### System Security Practices

**HTTPS everywhere.** All data transmission should be encrypted.

**Encrypt sensitive data at rest.** Passwords should be hashed. Personal data should be encrypted.

**Validate all inputs.** User input is not trustworthy. Validate format, length, and content.

**Implement rate limiting.** Prevent automated attacks.

**Keep software updated.** Patches fix security vulnerabilities.

**Regular backups.** Test that you can restore from backups.

**Monitor for anomalies.** Unusual patterns may indicate breach.

## Privacy in the 4-Layer Model

Privacy considerations apply throughout Module 2''s 4-layer model.

**Trigger layer:** What triggers capture personal data? How is that data protected?

**Logic layer:** Do conditional checks involve personal data? Is access to decision data logged?

**Execution layer:** What personal data does each action access? Are processors vetted? Is data minimized in API calls?

**Output layer:** Do notifications contain personal data? Who sees reports? Is sensitive data masked in dashboards?

## Privacy in Data Flow

Privacy considerations map to Section 5.1''s data flow stages.

**Entry stage:** Consent at collection. Clear privacy notice. Data minimization.

**Validation stage:** No privacy-specific concerns, but validation logs should not expose personal data.

**Transformation stage:** Processing should match consented purposes. AI vendors are processors requiring DPAs.

**Critical AI warning:** If you send personal data to an AI service without understanding its retention and training policies, you may already be non-compliant. Many AI services retain inputs, use them for training, or share them with third parties. Before sending personal data to any AI API, verify: Does the vendor retain data? For how long? Is it used for training? Can you get a DPA? Have you disclosed this processing to users?

**Storage stage:** Encryption at rest. Access controls. Retention policies.

**Output stage:** Minimize personal data in outputs. Consider recipients. Log distributions.

## When to Get Legal Help

Some situations require professional legal counsel.

**You are subject to HIPAA.** Health data compliance is complex.

**You handle payment card data.** PCI-DSS requirements are specific.

**You collect data from children.** COPPA compliance requires care.

**You transfer data internationally.** Cross-border data transfer rules are evolving.

**You experience a breach.** Legal obligations for notification and response.

**You receive a regulatory inquiry.** Responses must be careful.

**Enterprise client requires compliance certifications.** SOC 2, ISO 27001 require professional guidance.

**You are uncertain.** When in doubt, ask.

## Key Takeaways

**Collect minimally.** Only what you need for defined purposes.

**Be transparent.** Tell people what you do with their data.

**Secure properly.** Encryption, access control, monitoring.

**Enable control.** Let people access, correct, and delete their data.

**Plan for breaches.** Have a response plan before you need it.

**Manage vendors.** Their practices are your responsibility.

**Document everything.** Be able to demonstrate compliance.

**Stay updated.** Privacy law evolves constantly.

**When in doubt, ask.** Legal counsel for complex situations.',

exercise_markdown = '## Exercise: Privacy and Security Audit

**Objective:** Conduct a comprehensive privacy and security assessment of a real or hypothetical system, identify gaps, and design improvements.

This exercise develops practical skills for evaluating and improving privacy and security practices.

### Part 1: System Selection and Documentation

**Choose a system to audit:**

Option A: A real system you use or manage (with appropriate permissions)
Option B: A hypothetical system based on a scenario you design

**Document the system:**

System name and purpose: _______

What the system does: _______

Who uses it: _______

What data it collects:
- List all data fields collected
- For each field, identify if it is PII or sensitive data
- Note the source of each data type (user-submitted, derived, third-party)

Data storage:
- Where is data stored?
- Who has access?
- How long is data retained?

Data flows:
- Where does data enter?
- Where does data go (internal and external)?
- What third parties receive data?

### Part 2: Legal Basis Assessment

**For each category of data collection, assess legal basis:**

**Data Category: Customer contact information**
- Purpose for collection: _______
- Legal basis (consent, contract, legitimate interest, etc.): _______
- If consent: How is it obtained? Is it documented?
- If legitimate interest: What is the interest? Does it override individual rights?
- Assessment: Adequate / Needs improvement

**Data Category: Usage analytics**
- Purpose for collection: _______
- Legal basis: _______
- Assessment: _______

**Data Category: Marketing preferences**
- Purpose for collection: _______
- Legal basis: _______
- If consent: How is it obtained?
- How can users opt out?
- Assessment: _______

**Continue for all data categories in your system.**

### Part 3: Consent Audit

**Evaluate consent mechanisms:**

**Consent collection method:**
- How is consent requested: _______
- Is it freely given (not bundled with service): _______
- Is it specific (for defined purposes): _______
- Is it informed (after clear explanation): _______
- Is it unambiguous (requires affirmative action): _______

**Consent documentation:**
- Is consent recorded with timestamp: _______
- Is the version of terms recorded: _______
- Can you demonstrate consent if challenged: _______

**Consent withdrawal:**
- How can users withdraw consent: _______
- Is withdrawal as easy as giving consent: _______
- What happens to data when consent is withdrawn: _______

**Current consent rating (1-10):** _______

**Improvements needed:** _______

### Part 4: Privacy Policy Audit

**Evaluate the privacy policy (or design one if none exists):**

**Content checklist:**
- Explains what data is collected: Yes/No/Partial
- Explains why data is collected (purposes): Yes/No/Partial
- Explains how data is used: Yes/No/Partial
- Identifies who data is shared with: Yes/No/Partial
- Specifies retention periods: Yes/No/Partial
- Explains individual rights: Yes/No/Partial
- Provides contact information: Yes/No/Partial
- Explains how to exercise rights: Yes/No/Partial

**Accessibility:**
- Is policy linked from data collection points: Yes/No
- Is policy written in clear language: Yes/No
- Is policy available in relevant languages: Yes/No

**Current policy rating (1-10):** _______

**Improvements needed:** _______

### Part 5: Security Audit

**Evaluate security controls:**

**Access Control:**
- Is role-based access control implemented: _______
- Are access permissions documented: _______
- Is access reviewed periodically: _______
- Are former employees/contractors promptly removed: _______
- Rating (1-10): _______

**Data Protection:**
- Is data encrypted at rest: _______
- Is data encrypted in transit (HTTPS): _______
- Are backups encrypted: _______
- Are encryption keys managed securely: _______
- Rating (1-10): _______

**Account Security:**
- Are strong passwords required: _______
- Is two-factor authentication available/required: _______
- Are session timeouts implemented: _______
- Rating (1-10): _______

**Application Security:**
- Is input validation implemented: _______
- Is rate limiting implemented: _______
- Are dependencies updated regularly: _______
- Rating (1-10): _______

**Monitoring:**
- Are access logs maintained: _______
- Are security events monitored: _______
- Are alerts configured for anomalies: _______
- Rating (1-10): _______

**Overall security rating:** _______

### Part 6: Vendor Audit

**List all third-party services with access to personal data:**

**Vendor 1:**
- Name: _______
- Purpose: _______
- Data they receive: _______
- Data they can access: _______
- Where they store data (geography): _______
- Their security certifications: _______
- DPA in place: Yes/No
- Last reviewed: _______
- Risk assessment: Low/Medium/High

**Vendor 2:**
- (Same fields)

**Continue for all vendors.**

**Vendor management improvements needed:** _______

### Part 7: Data Subject Rights Audit

**Assess ability to fulfill data subject rights:**

**Right to Access:**
- Can you provide a copy of an individual''s data: _______
- How long would it take: _______
- Is there a documented process: _______
- Rating (1-10): _______

**Right to Rectification:**
- Can individuals request corrections: _______
- How are corrections made: _______
- How long does it take: _______
- Rating (1-10): _______

**Right to Erasure:**
- Can you delete an individual''s data: _______
- From all systems and backups: _______
- How long does it take: _______
- Rating (1-10): _______

**Right to Portability:**
- Can you export data in machine-readable format: _______
- What format: _______
- How long does it take: _______
- Rating (1-10): _______

**Overall rights fulfillment rating:** _______

**Improvements needed:** _______

### Part 8: Retention Policy Audit

**Assess data retention practices:**

**Current state:**
- Is there a documented retention policy: _______
- Are retention periods defined for each data category: _______
- Is deletion automated or manual: _______
- Are backups included in retention policy: _______

**Design retention schedule:**

| Data Category | Retention Period | Justification | Deletion Method |
|---------------|------------------|---------------|-----------------|
| Customer contacts | ______ | ______ | ______ |
| Transaction records | ______ | ______ | ______ |
| Marketing preferences | ______ | ______ | ______ |
| Support tickets | ______ | ______ | ______ |
| Usage analytics | ______ | ______ | ______ |

**Implementation plan:**
- How will you implement automated deletion: _______
- How will you handle existing data beyond retention: _______

### Part 9: Breach Response Planning

**Design or evaluate breach response plan:**

**Detection:**
- How would you know if a breach occurred: _______
- What monitoring is in place: _______
- Who is alerted: _______

**Containment:**
- Immediate steps to stop ongoing breach: _______
- Who has authority to take emergency action: _______
- Communication chain: _______

**Assessment:**
- How do you determine what data was affected: _______
- How do you identify affected individuals: _______
- How do you assess harm: _______

**Notification:**
- Who must be notified (regulators): _______
- Within what timeframe: _______
- What must notification include: _______
- Template prepared: Yes/No

**Individual communication:**
- How will affected individuals be notified: _______
- What will you tell them: _______
- What remediation will you offer: _______

**Remediation:**
- Steps to prevent recurrence: _______
- Who is responsible: _______

**Documentation:**
- What must be documented: _______
- Where is documentation stored: _______

### Part 10: Create Action Plan

**Compile all findings into prioritized action plan:**

**Critical (address immediately):**
1. Issue: _______  Action: _______  Owner: _______
2. Issue: _______  Action: _______  Owner: _______
3. Issue: _______  Action: _______  Owner: _______

**High Priority (address within 30 days):**
1. Issue: _______  Action: _______  Owner: _______
2. Issue: _______  Action: _______  Owner: _______
3. Issue: _______  Action: _______  Owner: _______

**Medium Priority (address within 90 days):**
1. Issue: _______  Action: _______  Owner: _______
2. Issue: _______  Action: _______  Owner: _______

**Improvements (ongoing):**
1. Area: _______  Improvement: _______

### Part 11: Create Standards Document

**Write a privacy and security standards document:**

**Section 1: Purpose and Scope**
What this document covers and why it matters.

**Section 2: Data Classification**
Categories of data and sensitivity levels.

**Section 3: Collection Standards**
Rules for data collection, consent, and minimization.

**Section 4: Access Control Standards**
Who can access what and how access is managed.

**Section 5: Security Standards**
Encryption, authentication, and monitoring requirements.

**Section 6: Vendor Standards**
Requirements for third-party services.

**Section 7: Retention Standards**
Retention periods and deletion procedures.

**Section 8: Rights Fulfillment Procedures**
How to handle data subject requests.

**Section 9: Incident Response Procedures**
What to do if a breach occurs.

**Section 10: Compliance Monitoring**
How compliance is verified and maintained.

### Scope Note

This exercise is comprehensive. For core mastery, prioritize Parts 1-6 (system documentation, legal basis, consent, privacy policy, security, and vendor audits). Parts 7-11 (rights, retention, breach response, action plan, standards) represent enterprise-level maturity and can be completed in a second pass or when your needs require it.

### Deliverable

Submit a complete privacy and security audit package including:

1. System documentation
2. Legal basis assessment
3. Consent audit with ratings
4. Privacy policy audit with ratings
5. Security audit with ratings per category
6. Vendor audit with risk assessments
7. Data subject rights audit
8. Retention policy with schedule
9. Breach response plan
10. Prioritized action plan
11. Standards document

### Success Criteria

You have completed this exercise successfully when:
- System is thoroughly documented including all data flows
- Legal basis is assessed for all data processing
- Consent mechanisms are evaluated with specific improvements
- Security controls are assessed across all categories
- Vendors are inventoried with risk assessment
- Data subject rights processes are evaluated
- Retention policy is complete with justifications
- Breach response plan addresses all stages
- Action plan is prioritized and actionable
- Standards document could be used by your organization',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: System Documentation",
      "description": "Document the system you will audit.",
      "fields": [
        {
          "id": "system_choice",
          "type": "radio",
          "label": "Which type of system are you auditing?",
          "options": ["Real system I use/manage", "Hypothetical system I designed"],
          "required": true
        },
        {
          "id": "system_overview",
          "type": "textarea",
          "label": "Document the system:",
          "placeholder": "System name and purpose: ...\n\nWhat it does: ...\n\nWho uses it: ...\n\nData collected:\n- [field]: PII? [Yes/No], Source: [user/derived/third-party]\n- [field]: ...\n\nData storage:\n- Where stored: ...\n- Who has access: ...\n- Retention period: ...\n\nData flows:\n- Entry points: ...\n- Internal destinations: ...\n- Third parties: ...",
          "required": true,
          "rows": 20
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Legal Basis Assessment",
      "description": "Assess legal basis for each data category.",
      "fields": [
        {
          "id": "legal_basis",
          "type": "textarea",
          "label": "Assess legal basis for data processing:",
          "placeholder": "Customer contact info:\n- Purpose: ...\n- Legal basis: [consent/contract/legitimate interest]\n- If consent: how obtained? documented?\n- Assessment: [Adequate/Needs improvement]\n\nUsage analytics:\n- Purpose: ...\n- Legal basis: ...\n- Assessment: ...\n\nMarketing preferences:\n- Purpose: ...\n- Legal basis: ...\n- Opt-out method: ...\n- Assessment: ...\n\n[Continue for all data categories]",
          "required": true,
          "rows": 18
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Consent Audit",
      "description": "Evaluate consent mechanisms.",
      "fields": [
        {
          "id": "consent_audit",
          "type": "textarea",
          "label": "Evaluate consent collection and management:",
          "placeholder": "Collection method: ...\n\nConsent quality:\n- Freely given (not bundled): [Yes/No]\n- Specific (defined purposes): [Yes/No]\n- Informed (clear explanation): [Yes/No]\n- Unambiguous (affirmative action): [Yes/No]\n\nDocumentation:\n- Timestamp recorded: [Yes/No]\n- Terms version recorded: [Yes/No]\n- Can demonstrate if challenged: [Yes/No]\n\nWithdrawal:\n- How to withdraw: ...\n- As easy as giving consent: [Yes/No]\n- Data handling on withdrawal: ...\n\nCurrent rating (1-10): ...\nImprovements needed: ...",
          "required": true,
          "rows": 18
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Privacy Policy Audit",
      "description": "Evaluate the privacy policy.",
      "fields": [
        {
          "id": "policy_audit",
          "type": "textarea",
          "label": "Evaluate privacy policy content and accessibility:",
          "placeholder": "Content checklist:\n- What data collected: [Yes/No/Partial]\n- Why collected: [Yes/No/Partial]\n- How used: [Yes/No/Partial]\n- Who shared with: [Yes/No/Partial]\n- Retention periods: [Yes/No/Partial]\n- Individual rights: [Yes/No/Partial]\n- Contact info: [Yes/No/Partial]\n- How to exercise rights: [Yes/No/Partial]\n\nAccessibility:\n- Linked from collection points: [Yes/No]\n- Clear language: [Yes/No]\n- Available in relevant languages: [Yes/No]\n\nCurrent rating (1-10): ...\nImprovements needed: ...",
          "required": true,
          "rows": 16
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Security Audit",
      "description": "Evaluate security controls.",
      "fields": [
        {
          "id": "security_audit",
          "type": "textarea",
          "label": "Audit security across categories:",
          "placeholder": "Access Control (1-10): ...\n- RBAC implemented: ...\n- Permissions documented: ...\n- Periodic review: ...\n- Offboarding process: ...\n\nData Protection (1-10): ...\n- Encrypted at rest: ...\n- Encrypted in transit: ...\n- Backup encryption: ...\n- Key management: ...\n\nAccount Security (1-10): ...\n- Strong passwords: ...\n- 2FA available/required: ...\n- Session timeouts: ...\n\nApplication Security (1-10): ...\n- Input validation: ...\n- Rate limiting: ...\n- Dependency updates: ...\n\nMonitoring (1-10): ...\n- Access logs: ...\n- Security event monitoring: ...\n- Anomaly alerts: ...\n\nOverall security rating: ...",
          "required": true,
          "rows": 26
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Vendor Audit",
      "description": "Audit third-party services with data access.",
      "fields": [
        {
          "id": "vendor_audit",
          "type": "textarea",
          "label": "List and assess all vendors with personal data access:",
          "placeholder": "Vendor 1:\n- Name: ...\n- Purpose: ...\n- Data received: ...\n- Data accessible: ...\n- Storage location: ...\n- Security certs: ...\n- DPA in place: [Yes/No]\n- Last reviewed: ...\n- Risk: [Low/Medium/High]\n\nVendor 2:\n[same format]\n\nVendor 3:\n[same format]\n\nManagement improvements needed: ...",
          "required": true,
          "rows": 20
        }
      ]
    },
    {
      "id": "part7",
      "title": "Part 7: Data Subject Rights (Advanced)",
      "description": "Assess ability to fulfill data subject rights.",
      "fields": [
        {
          "id": "rights_audit",
          "type": "textarea",
          "label": "Assess each right:",
          "placeholder": "Right to Access (1-10): ...\n- Can provide copy: [Yes/No]\n- Time required: ...\n- Documented process: [Yes/No]\n\nRight to Rectification (1-10): ...\n- Can correct: [Yes/No]\n- Time required: ...\n\nRight to Erasure (1-10): ...\n- Can delete: [Yes/No]\n- From all systems/backups: [Yes/No]\n- Time required: ...\n\nRight to Portability (1-10): ...\n- Can export: [Yes/No]\n- Format: ...\n\nOverall rating: ...\nImprovements needed: ...",
          "required": false,
          "rows": 18
        }
      ]
    },
    {
      "id": "part8",
      "title": "Part 8: Retention Policy (Advanced)",
      "description": "Design or assess retention policy.",
      "fields": [
        {
          "id": "retention_policy",
          "type": "textarea",
          "label": "Design retention schedule:",
          "placeholder": "Current state:\n- Documented policy: [Yes/No]\n- Periods defined: [Yes/No]\n- Deletion automated: [Yes/No]\n\nRetention schedule:\n| Data Category | Period | Justification | Deletion Method |\n| Customer contacts | ... | ... | ... |\n| Transactions | ... | ... | ... |\n| Marketing | ... | ... | ... |\n| Support tickets | ... | ... | ... |\n| Analytics | ... | ... | ... |\n\nImplementation plan: ...",
          "required": false,
          "rows": 16
        }
      ]
    },
    {
      "id": "part9",
      "title": "Part 9: Breach Response (Advanced)",
      "description": "Design breach response plan.",
      "fields": [
        {
          "id": "breach_plan",
          "type": "textarea",
          "label": "Design breach response procedures:",
          "placeholder": "Detection:\n- How would you know: ...\n- Monitoring in place: ...\n- Who is alerted: ...\n\nContainment:\n- Immediate steps: ...\n- Authority to act: ...\n- Communication chain: ...\n\nAssessment:\n- Determine affected data: ...\n- Identify affected individuals: ...\n- Assess harm: ...\n\nNotification:\n- Regulators to notify: ...\n- Timeframe: ...\n- Template prepared: [Yes/No]\n\nIndividual communication:\n- Method: ...\n- Content: ...\n- Remediation offered: ...\n\nRemediation:\n- Prevention steps: ...\n- Responsible party: ...",
          "required": false,
          "rows": 24
        }
      ]
    },
    {
      "id": "part10",
      "title": "Part 10: Action Plan",
      "description": "Create prioritized action plan.",
      "fields": [
        {
          "id": "action_plan",
          "type": "textarea",
          "label": "Prioritize all findings:",
          "placeholder": "Critical (immediately):\n1. Issue: ... | Action: ... | Owner: ...\n2. Issue: ... | Action: ... | Owner: ...\n\nHigh (30 days):\n1. Issue: ... | Action: ... | Owner: ...\n2. Issue: ... | Action: ... | Owner: ...\n\nMedium (90 days):\n1. Issue: ... | Action: ... | Owner: ...\n\nOngoing improvements:\n1. Area: ... | Improvement: ...",
          "required": true,
          "rows": 14
        }
      ]
    }
  ],
  "deliverables": [
    "System documentation with data flows",
    "Legal basis assessment",
    "Consent audit with ratings",
    "Privacy policy audit",
    "Security audit across categories",
    "Vendor audit with risk assessment",
    "Prioritized action plan"
  ],
  "success_criteria": [
    "System thoroughly documented",
    "Legal basis assessed for all processing",
    "Consent mechanisms evaluated with improvements",
    "Security controls assessed across categories",
    "Vendors inventoried with risk assessment",
    "Action plan is prioritized and actionable"
  ]
}'

WHERE slug = 'privacy-security-compliance';
