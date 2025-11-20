# YProgram

YProgram is a comprehensive full-stack web application designed for personal management and social interaction. It integrates features for scheduling, learning, and social networking into a modern, responsive interface.

## Features

- **User System**: Secure authentication (Login/Register) and detailed user profiles.
- **Calendar & Scheduling**: Manage your daily tasks and events with an interactive calendar.
- **Friends System**: Connect with other users, manage friend lists.
- **Library**: Resource management system for tracking books or learning materials.
- **Progress Tracking**: Visual analytics for your learning or task progress.
- **Question Bank**: A system for practicing and managing questions/quizzes.

## Tech Stack

### Frontend
- **Framework**: [Vue 3](https://vuejs.org/)
- **Build Tool**: [Vite](https://vitejs.dev/)
- **Styling**: [Tailwind CSS](https://tailwindcss.com/)
- **State Management**: [Pinia](https://pinia.vuejs.org/)
- **Routing**: [Vue Router](https://router.vuejs.org/)
- **Key Libraries**: `axios`, `lucide-vue-next` (Icons), `v-calendar`, `monaco-editor`

### Backend
- **Runtime**: [Node.js](https://nodejs.org/)
- **Framework**: [Express](https://expressjs.com/)
- **Database**: MySQL (via `mysql2`)
- **Authentication**: JWT (JSON Web Tokens) & bcrypt

## Prerequisites

Before running the project, ensure you have the following installed:
- [Node.js](https://nodejs.org/) (v16+ recommended)
- [MySQL](https://www.mysql.com/)

## Installation & Setup

### 1. Database Setup
1.  Ensure your MySQL server is running.
2.  Create a database for the project.
3.  Check the `Database` folder for SQL scripts to initialize your tables.
4.  Configure the database connection in `Backend/db.js` or `.env` file.

### 2. Backend Setup
Navigate to the backend directory and install dependencies:

```bash
cd Backend
npm install
```

Start the server:

```bash
# Development (with nodemon)
npm run dev

# Production
npm start
```
The server typically runs on port `3000` (check `server.js` to confirm).

### 3. Frontend Setup
Navigate to the frontend directory and install dependencies:

```bash
cd Frontend
npm install
```

Start the development server:

```bash
npm run dev
```
Access the application at `http://localhost:5173` (or the port shown in your terminal).

## Project Structure

- **Frontend/**: Contains the Vue.js client application.
    - `src/pages`: Application views/routes.
    - `src/components`: Reusable UI components.
    - `src/stores`: Pinia state stores.
- **Backend/**: Contains the Node.js/Express server API.
    - `server.js`: Main entry point.
    - `*.js`: Feature-specific route handlers (e.g., `user.js`, `friends.js`).
- **Database/**: SQL scripts and database related files.
