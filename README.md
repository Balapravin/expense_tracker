# Expense Tracker App

This Flutter application helps users track their expenses efficiently. It utilizes Firebase for user authentication and Firestore for storing expense data.

## Project Setup

### Clone the Repository

Clone the repository to your local machine:

git clone https://github.com/Balapravin/expense_tracker.git
cd <repository-directory>


### Install Dependencies

Install Flutter dependencies using `flutter pub get` COMMENT

After running flutter pub get, open the Android emulator and run the code using either VS Code or Android Studio.


## User Authentication

Users can sign up and log in using their email and password credentials. After logging in, they are directed to the Expense List Page.

## Expense List

The Expense List Page displays all expenses added by the user. Each expense entry includes the amount, description, category, and date. Users can view their expenses and manage them efficiently.

### Adding Expenses

Users can add expenses with details such as amount, description, category, and date. Expenses are stored securely in a Firestore database, ensuring data persistence and accessibility.

To navigate to the Add Expense page, click the floating action button on the Expense List Page.

