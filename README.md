# Saturday
NUS Orbital 2022 Project
Team Saturday

Done by: Tan Yan-Hao Joshua & Titus Lowe Yong Wei

Team Name:
Saturday

Proposed Level of Achievement:
Apollo

Motivation
Through our personal experience of having lived on campus for the past year, we have noticed the tedious nature of settling shared bills. Currently, the most common method of settling shared debts is individually calculating and spelling out the split of expenses through Telegram messages. This is not only inconvenient, but it also lacks a measure of accountability to verify that the requested sum is paid and computed correctly.

As a result, we feel that there is a need for a platform that allows users to easily track, account for, and compute splits.

Aim
Through a unique mobile application that organizes and tracks bill splits, we hope to provide a platform for students to better manage their personal finances.


User Stories
As the creditor that initially paid for the bill, I want to be able to split the bill accurately without having to do the computations myself.

As the creditor that initially paid for the bill, I want to be able to track who has and hasn’t paid me back.

As the debtor, I want to be able to view the breakdown of the sum requested from me.

As the debtor, I want my creditor to be notified with proof that I have paid.

As the debtor, I want the payment process through various financial services to be seamless. (link to DBS Paylah!, Google Pay, etc.)

Features
A robust user account system, accountability measures, and an automated splitting mechanism will be the 3 key features of the mobile application.

User Account System
Ability to add friends

Shows a breakdown of debit and credit by friends

Auto-balances debit and credit amounts across friends (Nett amounts are displayed where possible)

Tracks and displays a breakdown of expenses for the month

Able to view payment request history for user error failsafe measures

Automated Splitting Protocol (ASP)
Recognises items and their corresponding prices from an uploaded bill with computer vision (Implement IOS Live Text)

Drag & Drop functionality to allocate items accordingly

Accountability Measures
Notifies a debtor when a creditor has requested for money

Debtor can view and verify the request

Weekly notification updates to collect and/or payback monies

Notifies a creditor when a debtor has paid back money

Creditor can view and verify the payback

Timeline and Development Plan

Milestone
Tasks
Description
In-Charge
Date
1
Learn Swift
Familiarize with the Swift language
Joshua & Titus
16-22 May
Learn Firebase
Familiarize with Firebase for user accounts system
Joshua & Titus

Automated Splitting Protocol
Implement Drag & Drop functionality for items into debtor “baskets”
Joshua
23-29 May
Implement a smart calculator that uses numerical data from a referenced item
Titus
Evaluation Milestone 1:
Ideation
Proof-of-concept:
Drag & Drop implementation to allocate payable items to each debtor
Calculator implementation to calculate total amount debited for each debtor
30 May
2
User Interface Assets (Designing)
Sign Up/Login Interface
Titus
31 May - 26 June
Home Interface
Titus
ASP Interface
Joshua
User Account System
Creation of Sign Up/Login function + user account management system via Firebase
Titus
Computer Vision
Implement IOS live text feature to upload and extract data from receipt to UI
Joshua
Notification Function
Implement a notification system to notify debtor on pending debt
Titus
Settle Debt
Payment function with links to transaction services (i.e. GrabPay, Paylah!, PayNow)
Joshua
Testing and Debugging
Preparation for Milestone 2
Joshua & Titus
Evaluation Milestone 2: First Working Prototype
Sign Up/Login feature
IOS live text to upload and extract data from receipts
Drag & Drop function to allocate payable items to each debtor
Notifies debtors upon submission of ASP
Payment function 
27 June
3
Home Page / At-a-glance
Overview: Displays pending payments

Activity: Log of past payments
Joshua
28 June - 24 July


Notification System
Weekly notification updates (on Saturday) to debtors
Titus


Manual Reminder Function
Implement a reminder button to manually override notification for creditors to debtors
Titus


Finetune Payment Process
Make flow of actions for payments more streamlined and seamless
Joshua
Evaluation Milestone 3:
Home Page
Timely notification updates
Manual reminder button
Finetuning of payment process
25 July
4
Refinement
Testing and debugging




Evaluation Milestone 4: Fin!
24 August




Technical Proof of Concept
Link to Video: 
