# YaraYara TS Node Express: A TypeScript Node Server Setup Script

## Overview
YaraYara TS Node Express simplifies the setup process for a TypeScript Node.js server, automating everything from folder structure creation to Swagger documentation and Git initialization.

This script automates the setup process for a TypeScript Node.js server along with its folder structure, dependencies, API routes, Swagger documentation, Git initialization, and server startup.

## Requirements

- Bash
- Git
- Node.js
- npm

## Usage

1. Copy the `yara` Script file to your local machine 
2. Make it executeable by running `chmod +x yara`
3. Execute the script by running `./yara`.
4. Watch the Magic as it Unravels ❤️🪄

## Features

- Sets up a TypeScript Node server with Express framework.
- Creates a folder structure for controllers, database, interfaces, middlewares, routes, services, and utils.
- Installs necessary dependencies including TypeScript, Express, ts-node-dev, Swagger, and Morgan.
- Configures Swagger for API documentation.
- Setup a Greetings Endpoint for test
- Initializes Git and creates a `.gitignore` file.
- Starts the development server using `npm run start:dev`.

## File Structure

- `src`: Contains source code for the project.
  - `controllers`: Controllers for handling API requests.
  - `database`: Database models and configurations.
  - `interfaces`: Interface definitions.
  - `middlewares`: Middleware functions.
  - `routes`: API routes.
  - `services`: Service layer for business logic.
  - `utils`: Utility functions.
  - `swagger.ts`: Swagger documentation setup.
  - `server.ts`: Server setup.
- `.env`: Environment variables configuration file.
- `app.ts`: Main application file.
- `.gitignore`: Git ignore file.
- `package.json`: Project metadata and dependencies.
- `README.md`: Project README.

## Dependencies Installed

- Node.js
- TypeScript
- Express
- ts-node-dev
- Swagger UI Express
- Swagger JSDoc
- Morgan

## After Setup

1. Edit the `.env` file to configure environment variables.
2. Run `npm run start:dev` to start the development server.
3. Visit `http://localhost:3000/api-docs` to view Swagger API documentation.

:star:️ Leave a star, share your suggestions for improvement! :rocket:

## Author and Contributors

- Ibukun Alesinloye ([highb33kay](https://github.com/highb33kay/))
- Oluwaseyi Ogunjuyigbe ([seyiogunjuyigbe](https://github.com/seyiogunjuyigbe))

## License

This script is licensed under the MIT License.
