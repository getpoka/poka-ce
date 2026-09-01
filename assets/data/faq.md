## What is Poka CE?
**Poka CE (Community Edition)** is a 100% free, open-source, and offline-first personal finance manager. It is designed for maximum privacy, meaning your data never leaves your device and no account is required.

## What is included in Poka CE?
Poka CE is a self-contained local finance manager. It includes multi-account management, income/expense tracking, budgeting, goal tracking, debt/loan management, and split transactions. It strictly does not include cloud sync or remote backups.

## Is my data stored online?
No. Poka CE stores everything locally on your device using an internal SQLite database. Absolutely nothing is transmitted, uploaded, or synced to any external server.

## Do I need an account to use Poka CE?
No. Because Poka CE works fully offline, there is no registration, login, or email verification required. You can start using it immediately.

## Does Poka CE collect analytics or track my usage?
No. Poka CE does not contain any third-party trackers, crash reporting tools, or analytics SDKs. Your usage remains 100% private.

## How do I backup and restore my data?
Since your data lives entirely on your device, **you are entirely responsible for backing up your own data manually**. 

To do this:
1. Go to **Settings** > **Backup & Restore**.
2. Tap **Backup Database**.
3. Enter and confirm a backup passphrase.
4. Use the system share sheet to store the encrypted `.sqlite` file in a location you control.

When you change phones or reinstall the app, open **Backup & Restore**, choose **Restore From Backup**, enter the same passphrase, and select the `.sqlite` file.

## Can I sync Poka CE across multiple devices?
No. Poka CE is strictly an offline-first app, meaning your data stays only on the device you use. There is no cloud synchronization. To move data between devices, create an encrypted database backup and restore it manually on the other device.

## How do I protect the app from unauthorized access?
You can enable App Lock in the Settings screen to protect your data locally. You can secure the app using a six-digit PIN and optionally your device's native biometrics.

## What happens if I forget my PIN?
Since your data is entirely local, there is no "Forgot Password" or reset process. If you forget your PIN, you will need to clear the app's data from your phone's system settings. **Warning:** doing this will permanently erase your local records unless you have a manual backup.

## What are "minor units" in Poka CE?
To guarantee absolute precision and avoid floating-point rounding errors (which are common in programming), all monetary values in Poka CE are stored as the smallest currency unit (e.g., cents for USD or whole numbers for IDR) using integers in the local database.

## Can I contribute to Poka CE?
Yes! Poka CE is open-source. You can report bugs, suggest features, or submit pull requests directly to our GitHub repository. We welcome contributions from the community.

## Is Poka CE completely free?
Yes! Poka CE is completely free, open-source (under the Apache 2.0 license), and contains no hidden fees, paywalls, or advertisements.
