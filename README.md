# kanban_board Introduction

The Kanban Board project is a mobile application built using the Flutter framework. It allows users to create and manage tasks in a simple and intuitive way, using the Kanban methodology. The app is designed to be user-friendly and easy to navigate, making it a great tool for individuals, teams, and organizations.

# Features
Create and manage tasks using the Kanban methodology<br />
Drag and drop tasks between columns<br />
Add labels and description for tasks<br />
Start a timer when task go to in Progress and finish when goes to don section<br />
Easily view and update task details<br />


# Getting Started:
you can download the source or fork it in android studio or any other Idea<br />  
if you don't have Flutter you need to download that so Idea can run the surce code<br />
if you don't have it you need to follow this :https://docs.flutter.dev/get-started/install<br />
after that you need to create a Virtual device or connect a real device to the system and create a build or run the app on it<br /> 
in first step you need to create a user , we dont have any limit on it right now, we use user because we save all the information about the Kanban on the user<br />
if you have the user you can use that and login.<br />
in the first page you can see three column, To do , in progress and don<br /> 
for start you can create a task, and name it , this task will move to "to do section"<br />
then you can click on it to update that, add description and more<br />
then you can move that task to in progress so you can see the timer<br /> 
after that you can move that to don , in this case task are finish adn you can see the timer has stopped and time are recorded<br />
you can swith between board just by sweeping on mobile ,<br /> 
you can drag an item and move it to right side, this will let you move the task to next column, and rop it there<br /> 
this app support multi language, so you can change that on setting page<br />
for that you can click on navigation menu on top left side<br />
click on setting button<br />
then click on language section and select you designer language<br />
also in this page you can change the theme of application<br />
you can change drake mode or light mode on setting and also in navigation menu in home page.<br />
but if you dont do that, app going to on dark mode if your phone is on dark mode<br />

# Technical details
in this section we talk mainly about Technical details of project<br />
The application is built using the Flutter framework<br />
we used the latest version of flutter 3.3.10 and dart version of 2.18.6<br />


## Structure
Folders By Type/Domain
## State management 
provider
## server / cloud
using firebase for database and sync data with

## other features
### Setting page
you can edit the colors, primary,secondary, text on this page, also you can change the app language and theme on this page too
### Multi language
you can change the app language on the setting page
### Custom Theme color, primary, secondary, text color  
you can change the app theme on setting page
### dark mode/ light mode
this will be change base on the mobile / web theme , but you can change the dark mode on setting page and navigation menu too
### provider state management
the main state management for the app
### shared_preferences for local data
we save some information related to setting on local, so we used SP for that
### web / mobile design
we try to design app , so we can use on both web (large) and mobile screens
### material 2 / material 3 switch in setting
there are a switch on setting page that you can back to material 2 if you like it more
### drag Items
we add some ability to items on list / columns, so you can drag them and move to another list/ column. we use default widget and we don't used third party library for that, we simply used draggable widgets
### change page on drag items
we used page view for switch between the columns and after that we add a area and left and right side, so if any item drag to that , swith to next page or last page, so we can go next page easy , and I think this what are soo much user friendly compare to other  approach
### change page animation
we add animation to drag Items and move them and changing the page so user have smooth experience
### ability to have n columns (is static now because of multi language and no Back end)
this ability are exist to have custom column, n number of them, but for that to be working we need some kind of clound function or server api, so we can handle the language, we can add that in future if we need that
### sync data with firebase realtime database
all data related to kanban are sync to firestore for each user, that why we have login section, and all of this data are secure and save for one user, and other users can not access that, we can create a team ability later so every one under a team can access the same data.
