# Interview Buddy

## Overview

Interview Buddy is a mobile App that helps developers to prepare for technical interviews by answering quizzes and getting feedback. The App is built with Swift and Firebase.

https://user-images.githubusercontent.com/61996882/212560054-362585c7-9e9f-4df0-95a6-160bad9f0b4c.mov

## Features

- [x] Register and Login Page
- [x] Forgot Password
- [x] Select quiz depending on programming language, topic, and difficulty
- [x] Get feedback on the quiz
- [x] Get badges for completing group of quizzes

## Technologies

- [x] Swift
- [x] Firebase
- [x] Storyboard
- [x] UITableView
- [x] UICollectionView

## Prerequisites

- Computer with Mac OS
- XCode

## Instructions to Run Interview Buddy Locally

### Apple M1 Pro

### Ventura

Intall Cocopods:

Open terminal and run

```sh
softwareupdate --install-rosetta
```

In finder go to applications folder then to utilities and right click in Terminal.app choosse open with Rosetta.

In the root folder of this App open terminal and check if it is Rosetta with the command: arch  
The output should be: i386

and run the following steps:

```sh
sudo gem uninstall cocoapods
sudo gem uninstall ffi
arch -arm64 brew install cocoapods
pod install
```

Open the interview-buddy.xcworkspace file in XCode and run the App.
