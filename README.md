# kanban_board Introduction

The Kanban Board project is a mobile application built using the Flutter framework. It allows users to create and manage tasks in a simple and intuitive way, using the Kanban methodology. The app is designed to be user-friendly and easy to navigate, making it a great tool for individuals, teams, and organizations.

# Features
Create and manage tasks using the Kanban methodology
Drag and drop tasks between columns
Add labels and description for tasks
Start a timer when task go to in Progress and finish when goes to don section
Easily view and update task details


# Getting Started:
you can download the source or fork it in android studio or any other Idea  
if you don't have Flutter you need to download that so Idea can run the surce code
if you don't have it you need to follow this :https://docs.flutter.dev/get-started/install
after that you need to create a Virtual device or connect a real device to the system and create a build or run the app on it 
in first step you need to create a user , we dont have any limit on it right now, we use user because we save all the information about the Kanban on the user
if you have the user you can use that and login.
in the first page you can see three column, To do , in progress and don 
for start you can create a task, and name it , this task will move to "to do section"
then you can click on it to update that, add description and more
then you can move that task to in progress so you can see the timer 
after that you can move that to don , in this case task are finish adn you can see the timer has stopped and time are recorded
you can swith between board just by sweeping on mobile , 
you can drag an item and move it to right side, this will let you move the task to next column, and rop it there 
this app support multi language, so you can change that on setting page
for that you can click on navigation menu on top left side
click on setting button
then click on language section and select you designer language
also in this page you can change the theme of application
you can change drake mode or light mode on setting and also in navigation menu in home page.
but if you dont do that, app going to on dark mode if your phone is on dark mode

# Technical details
in this section we talk mainly about Technical details of project
The application is built using the Flutter framework
we used the latest version of flutter 3.3.10 and dart version of 2.18.6


## Structure
Folders By Type/Domain
## State management 
provider
## server / cloud
using firebase for database and sync data with

## other features
### Setting page
you can edit the colors, primary,secondary, text on this page, also you can change the app language and theme on this page too
Multi language
Custom Theme color, primary, secondary, text color  
dark mode/ light mode
provider state management
shared_preferences for local data
web / mobile design
material 2 / material 3 switch in setting
drag Items
change page on drag items
change page animation
ability to have n columns (is static now because of multi language and no Back end)
sync data with firebase realtime database
