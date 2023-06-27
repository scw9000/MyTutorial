# Secure Apps workshop resource articles

Explore more resources from apple.com for learning more about SwiftUI and Xcode.

## Apple Support Articles and Videos

#### Recommended WWDC videos:

- [Keynote](https://developer.apple.com/videos/play/wwdc2022/101/)
- [What’s new in managing Apple devices](https://developer.apple.com/videos/play/wwdc2022/10045/)
- [Improve DNS security for apps and servers](https://developer.apple.com/videos/play/wwdc2022/10079/)
- [What’s new in Endpoint Security](https://developer.apple.com/videos/play/wwdc2022/110345/)
- [Meet Passkeys](https://developer.apple.com/videos/play/wwdc2022/10092/)

#### Recommended articles:

- [Apple Platform Security](https://support.apple.com/guide/security/welcome/web)
- [Personal Safety User Guide](https://support.apple.com/guide/personal-safety/welcome/web)
- [See who has access to your iPhone or iPad](https://support.apple.com/guide/personal-safety/ipsb8deced49/1.0/web/1.0)
- [Apple Privacy](https://www.apple.com/privacy/features/)
- [Transparency Report / Government Requests](https://www.apple.com/legal/transparency/)

## The Essential 8

Australian Signals Directorate (ASD) publishes a threat model based on analysis of thousands of cyber-attacks in Australia each year.

### Overview

The mitigations are based on analysis of the attacks, and what would have defeated the attack.

Security is achieved via a process, not a specific tool, there are no silver bullets.

Many vendors are supplying products that don’t protect their customers from common threats, but soak up 
most of their budget or worse, are products that protect against sub-1% issues that have no impact on the most common threats.

> Note: On iOS, implementing the [Essential 8](https://www.cyber.gov.au/acsc/view-all-content/essential-eight) is easy - mainly because Apple has landed on a threat model, closely aligned with what ASD has developed in its data driven analysis.

### The ASD Essential 8:
* Application whitelisting
* Patch applications >= 48 hrs
* Disable MS Office macros, Javascript
* Harden user applications
* Restrict user privileges (iOS: 'mobile user')
* Patch operating systems >= 48 hrs
* Use multifactor authentication
* Perform daily backups

[The ASD Essential Eight](https://www.cyber.gov.au/acsc/view-all-content/essential-eight)
