# Saturday
#### _NUS Computing Orbital 2022_

Saturday is a mobile only, computer vision enabled smart personal accountant.

## Motivation

Through our personal experience of having lived on campus for the past year, we have noticed the tedious nature of settling shared bills. 

> Currently, the most common method of
> settling shared debts is individually calculating
> and spelling out the split of expenses through
> Telegram messages. 

This is not only inconvenient, but it also lacks a measure of accountability to verify that the requested sum is computed and paid correctly.

 As a result, we feel that there is a need for a platform that allows users to easily track, account for, and compute splits.

## Aim 

Through a unique mobile application that organizes and tracks bill splits, we hope to provide a platform for students to better manage their personal finances.

## User Stories

- As the creditor that initially paid for the bill, I want to be able to split the bill accurately without having to do the computations myself.
- As the creditor that initially paid for the bill, I want to be able to track who has and hasn’t paid me back.
- As the debtor, I want to be able to view the breakdown of the sum requested from me.
- As the debtor, I want my creditor to be notified with proof that I have paid.
- As the debtor, I want the payment process through various financial services to be seamless. (link to DBS Paylah!, Google Pay, etc.)

## Features

A robust user account system, accountability measures, and an automated splitting mechanism will be the 3 key features of the mobile application.

##### User Account System
- Ability to add friends
- Shows a breakdown of debit and credit by friends
- Auto-balances debit and credit amounts across friends (Nett amounts are displayed where possible)
- Tracks and displays a breakdown of expenses for the month
- Able to view payment request history for user error failsafe measures

##### Automated Splitting Protocol (ASP)
- Recognises items and their corresponding prices from an uploaded bill with computer vision (Implement IOS Live Text)
- ~~Drag & Drop~~ Cart Split functionality to allocate items accordingly

##### Accountability Measures
- Notifies a debtor when a creditor has requested for money
- Debtor can view and verify the request
- Weekly notification updates to collect and/or payback monies
- Notifies a creditor when a debtor has paid back money
- Creditor can view and verify the payback

## Developers
`Tan Yan-Hao Joshua`
`Titus Lowe Yong Wei`

