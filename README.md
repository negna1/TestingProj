# TransactionFIlter

# Frameworks and SPM

Project is using mostly Combine framework for architecture (reactive programming), for Networking it is using CombineCore (which is remote SMP and Written by negna1), Using Snapkit for constraints because Project doesn't like to use storyboards, thats why main storyboard and view controller is removed from 
info.plist. And Also project is using Components SPM which is written by negna1.

# Architecture

Project is using Combine Framework with MVVM Architecture. Main idea is to have protocols - type, input, output and use binding between View Model 
and Controller.

# Database

Because project wants to be always updated and not load empty page it is using core data to save already loaded transactions in local and if there were any kind of error project will use this data. 

# Filters

Filtering happen with dates and it is required, because noone wants to see their transaction with mixed dates and there is place where user can filter transactions with chips. There are 3 categories and also one to remove filter. 

# Whole Transaction

User can see whole transaction amount, also when user filter transactions user can see whole transaction but with filter.

# Tests

There are Unit tests where you can find how MVVM bindings and updates are working with tests. There are tests for both details and Main page. 
