To-Do List App

This is an iOS application built with UIKit and Core Data that allows users to manage their tasks. Users can add new tasks, mark them as done or undo, delete them, and view them in a table view. The app saves all tasks locally using Core Data for persistence.

Features

Add tasks with title and details.

View tasks in a UITableView.

Swipe actions to:

Delete tasks.

Mark as Done/Undo (with strikethrough text for completed tasks).


Persistent storage using Core Data.

Automatic refresh of the table when new tasks are added.

Project Structure

ViewController.swift

Displays all saved tasks in a table view.

Handles deletion and marking tasks as done/undo using swipe actions.

Listens for notifications when new tasks are added and reloads the table view.

AddTaskViewController.swift

Handles task creation with title and details input.

Validates input, saves tasks to Core Data via StorageManager, and notifies the main screen to refresh.

TaskModel.swift

Simple Codable struct representing a task with title, details, and isDone.

StorageManager.swift

Handles CRUD (Create, Read, Update, Delete) operations with Core Data.

Saves and fetches tasks to/from the local database.

Requirements
iOS 13.0+

Xcode 14.2

Swift 5.0

Core Data enabled

Installation
Clone this repository.

Open the project in Xcode.

Build and run the app on a simulator or device.

How It Works

On launch, the app loads all saved tasks from Core Data and displays them in a UITableView.

Users can tap the Add Task button to create a new task with a title and details.

New tasks are saved via StorageManager and automatically update the table view.

Users can swipe left on a task to:

Delete it permanently from Core Data.

Mark it as Done or Undo, toggling its completion status with strikethrough text.

