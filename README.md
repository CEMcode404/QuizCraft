
# QuizCraft

QuizCraft is an application that generates quizzes from text provided by the user. This monolithic repository contains all the necessary components for the app, including the backend and frontend, to streamline the development and deployment process.

## Features

- **Text-to-Quiz Generation**: Automatically create quizzes based on the text input.

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

For backend directory:

`GEMINI_API_KEY`


## Run Locally

Clone the project

```bash
  git clone https://github.com/CEMcode404/QuizCraft.git
```

Go to the project directory

```bash
  cd QuizCraft
```

To run mobile app:

Install dependencies

```bash
  flutter pub get
```

Make sure you have downloaded and run a simulator either via xcode simulator(ios) or android studio(android) before running the command below.

Start the app

```bash
  fluter run 
```

or alternatively you can press via debug mode button in vs code.

To run backend server:

```
  docker-compose up
```



