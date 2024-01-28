#!/bin/bash

echo "Starting Yara Yara: A TS Node Express Quick Start Script."

sleep 2

# pick project folder location
read -p "Enter project directory location (required): " projectDir

# check if project directory exists
if [ ! -d "$projectDir" ]; then
	echo "Project directory does not exist."
	read -p "Enter project directory location (required): " projectDir
	else
	echo "Project directory exists."
fi

# prompt for creating a new folder or not
read -p "Do you want to create a new folder for the project or work in the current directory? (y/n): " createFolder

# prompt for project name
read -p "Enter project name (required): " projectName

# get project description
read -p "Enter project description (optional): " projectDescription

# Validate project name input
if [ -z "$projectName" ]; then
    projectName="node-ts-starter" # Fixed the '-' before variable assignment
fi

# if project description is empty, then set it to default
if [ -z "$projectDescription" ]; then
	projectDescription="A Node.js with TypeScript starter project."
fi

# if createFolder is n, then check if it is empty
if [ "$createFolder" = "n" ]; then
	# if the project folder is not empty, then prompt to empty it
	if [ "$(ls -A "$projectDir")" ]; then
		read -p "Project directory is not empty. Do you want to empty it? (y/n): " emptyDir

		if [ "$emptyDir" = "y" ]; then
			rm -rf "$projectDir"/*
		else
			echo ""
			# if the project folder is not empty and user does not want to empty it, then exit
			read -p "Project directory is not empty. Would you like to continue?(y/n): " exitDir
			if [ "$exitDir" = "n" ]; then
				exit 1
			fi
		fi
	fi

	# change directory to project folder
	cd "$projectDir" || exit
fi

# if createFolder is y, then create a new folder
if [ "$createFolder" = "y" ]; then

	# change directory to project folder
	cd "$projectDir" || exit

	# Convert project name to lowercase with hyphens
	projectFolder=$(echo "$projectName" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

	# if project folder already exists, then prompt to delete it
	if [ -d "$projectFolder" ]; then
		read -p "Project folder already exists. Do you want to delete it? (y/n): " deleteFolder

		if [ "$deleteFolder" = "y" ]; then
			rm -rf "$projectFolder"
		else
			echo "A folder already exist with the same name. Please delete the project folder and run the script again."
			exit 1
		fi
	fi

	# create project folder
	mkdir "$projectFolder"

	# change directory to project folder
	cd "$projectFolder" || exit
fi

# Convert project name to lowercase with hyphens
projectFolder=$(echo "$projectName" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# get the current user name
USER_NAME=$(whoami)

echo "Creating project folder for '$projectName' and all folder structure.."

# Create source folder and its subfolders
mkdir -p src/controllers src/database src/interfaces src/middlewares src/routes src/services src/utils

sleep 2

echo "Folder structure created successfully."

sleep 2

echo "Creating files.."

# Create source files
touch src/controllers/greeting.controller.ts
touch src/database/greeting.model.ts
touch src/routes/greeting.route.ts
touch src/middlewares/index.ts
touch src/services/greeting.service.ts
touch src/utils/helpers.ts
touch src/swagger.ts
touch src/server.ts
touch src/app.ts

# Create other files
touch .env
touch .gitignore
touch package.json

echo "Files created successfully."

sleep 2

echo "Adding details to files.."

# Add details to .env file
echo "PORT=3000" > .env

# add this to package.json
cat <<EOF > package.json
{
  "name": "$projectName",
  "version": "1.0.0",
  "description": "$projectDescription",
  "main": "app.js",
  "scripts": {
    "start:dev": "ts-node-dev --respawn --transpile-only ./src/app",
    "start": "node ./build/app.js"
  },
  "keywords": [
	"node",
	"typescript"
  ],
  "author": "$USER_NAME",
  "license": "MIT",
  "dependencies": {
  },
  "devDependencies": {
  },
  "engines": {
    "node": ">=14.0.0"
  }
} 
EOF

# add project information to README.md in root directory
cat <<EOF > README.md
# $projectName

$projectDescription

## Folder Structure

\`\`\`
|--- src
|    |--- controllers
|    |--- database
|    |--- interfaces
|    |--- middlewares
|    |--- routes
|    |--- services
|    |--- utils
|    |--- swagger.ts
|    |--- server.ts
|--- .env
|--- app.ts
|--- .gitignore
|--- package.json
|--- tsconfig.json
\`\`\`

## Dependencies

- Node.js
- TypeScript
- Express
- ts-node-dev

## Getting Started

- Edit the .env file to suit your needs
- Run \`npm run start:dev\` to start the development server
- Run \`npm run start\` to start the production server
- Visit \`http://localhost:3000/api/v1/greetings\` to see the result

EOF

# Create index.ts files in each subfolder to export modules
echo "export * from './greeting.controller';" > src/controllers/index.ts
echo "export * from './greeting.route';" > src/interfaces/index.ts
echo "export * from './index';" > src/middlewares/index.ts
echo "export * from './greeting.service';" > src/services/index.ts
echo "export * from './helpers';" > src/utils/index.ts

echo "Adding details to files successfully.."

sleep 2

echo "Installing dependencies.."

# Create package.json file
# Initialize Node.js project
npm init -y

# Install TypeScript and type definitions for Node.js
npm install typescript @types/node --save-dev

# install ts-node-dev and type definitions for it
npm install ts-node-dev --save-dev

# initialize TypeScript project
npx tsc --init

# rm tsconfig.json
rm tsconfig.json

# remove everything from tsconfig.json file and add the following
cat <<EOF > tsconfig.json
{
  "compilerOptions": {
    "lib": ["es5", "es6"],
    "target": "es5",
    "strict": false,
    "module": "commonjs",
    "moduleResolution": "node",
    "outDir": "./build",
    "esModuleInterop": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "sourceMap": true
    // "typeRoots": ["node_modules/@types"],
    // "types": ["node", "express", "body-parser"]
  }
}
EOF

# install express and type definitions for express
npm install express @types/express --save

# install swagger, swagger ui, swagger jsdoc and type definitions for them
npm install swagger-ui-express swagger-jsdoc @types/swagger-ui-express @types/swagger-jsdoc --save

# install morgan and type definitions for it
npm install morgan @types/morgan --save

# create swagger.ts file
touch src/swagger.ts

# add the following to swagger.ts file
cat <<EOF > src/swagger.ts
import swaggerJsdoc from "swagger-jsdoc";

const options = {
  definition: {
    openapi: "3.1.0",
    info: {
      title: "$projectName API Documentation",
      version: "1.0.0",
      description: "API for $projectName API End Point Documentation",
    },
    servers: [
      {
        url: "http://localhost:3000/",
        description: "Local server",
      },
      {
        url: "https://#/",
        description: "Live server",
      },
    ],
    license: {
      name: "Apache 2.0",
      url: "https://www.apache.org/licenses/LICENSE-2.0.html",
    },
    // components: {
    //   securitySchemes: {
    //     bearerAuth: {
    //       type: "http",
    //       scheme: "bearer",
    //       bearerFormat: "JWT",
    //     },
    //   },
    // },
    // security: [
    //   {
    //     bearerAuth: [],
    //   },
    // ],
  },
  apis: ["./src/routes/*.route.ts"],
};

const specs = swaggerJsdoc(options);

module.exports = specs;
EOF

echo "Dependencies installed successfully."

sleep 2

echo "Setting up greetings API.."

# create controllers
echo "import { Request, Response } from 'express';

export function getGreetings(req: Request, res: Response) {
  res.json({ message: 'Hello World!🌍' });
}" > src/controllers/greeting.controller.ts

# create services
echo "export async function getAllGreetings() {
  return [];
}" > src/services/greeting.service.ts

# create routes
echo "import { Router } from 'express';

/**
 * @swagger
 * tags:
 *   name: Greetings
 *   description: Greetings API
 */

/**
 * @swagger
 * /greetings:
 *   get:
 *     summary: Returns the list of all the greetings
 *     tags: [Greetings]
 *     responses:
 *       200:
 *         description: The list of the greetings
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: string
 */
import { getGreetings } from '../controllers/greeting.controller';

const router = Router();

router.get('/greetings', getGreetings);

module.exports = router;" > src/routes/greeting.route.ts

# create app.ts file
echo "import express from 'express';
import { readdirSync } from 'fs';
import { join } from 'path';
import morgan from 'morgan';

const swaggerUi = require('swagger-ui-express');
const swaggerOptions = require('./swagger');

const app = express();
const port = 3000;

app.use(morgan('dev'));

//  Swagger UI
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerOptions));

// Dynamically serve all routes
readdirSync('./src/routes').map((path) => {
    app.use('/api/v1/', require(\`./routes/\${path}\`));
});

app.listen(port, () => {
  console.log(\`Server is running on port \${port}\`);
});" > src/app.ts

echo "Setting up greetings API successfully."

sleep 2

echo "Running the server.."

# if the server has git initialized, then push to git
if [ -d ".git" ]; then
	echo "Git is initialized."

	# check if remote is set
	if [ -z "$(git remote show origin)" ]; then
		echo "Remote is not set."
		echo "Please set the remote to sync."
	fi
else
	echo "Git is not initialized."
	echo "Initializing git.."
	git init
	echo "Git initialized successfully."
fi

echo "Adding git ignore.."

# pull node ts git ignore
curl https://raw.githubusercontent.com/github/gitignore/master/Node.gitignore --output .gitignore	

echo "Pushing to git.."

# push to git
git add .
git commit -m "Initial commit"

if git remote show origin > /dev/null 2>&1; then
    git push
	echo "Pushed to git successfully."
else
    echo "Remote is not set."
    echo "Please set the remote to sync."
fi

echo "All done 😊. Happy coding"

sleep 2

echo "Running the server.."

# run the server and check if it works
npm run start:dev