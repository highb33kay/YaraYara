#!/bin/bash

echo "Starting Yara Yara: A TS Node Express Quick Start Script."

sleep 2

# Prompt for project name
read -p "Enter project name (required): " projectName

# Validate project name input
if [ -z "$projectName" ]; then
    projectName="node-ts-starter" # Fixed the '-' before variable assignment
fi

# Convert project name to lowercase with hyphens
projectFolder=$(echo "$projectName" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

echo "Creating project folder '$projectFolder' and all folder structure.."

# Create project folder and its subfolders
mkdir -p "$projectFolder/src/controllers" "$projectFolder/src/database" "$projectFolder/src/interfaces" "$projectFolder/src/middlewares" "$projectFolder/src/routes" "$projectFolder/src/services" "$projectFolder/src/utils"

sleep 2

echo "Folder structure created successfully."

sleep 2

echo "Creating files in '$projectFolder'.."

# Create source files
touch "$projectFolder/src/controllers/greeting.controller.ts" "$projectFolder/src/database/greeting.model.ts" "$projectFolder/src/routes/greeting.route.ts" "$projectFolder/src/middlewares/index.ts" "$projectFolder/src/services/greeting.service.ts" "$projectFolder/src/utils/helpers.ts" "$projectFolder/src/swagger.ts" "$projectFolder/src/server.ts" "$projectFolder/src/app.ts"

# Create other files
touch "$projectFolder/.env" "$projectFolder/.gitignore" "$projectFolder/package.json"

echo "Files created successfully."

sleep 2

echo "Adding details to files.."

# Add details to .env file
echo "PORT=3000" > "$projectFolder/.env"

# Add details to README.md in src directory
echo "# Source Folder" > "$projectFolder/src/README.md"
echo "This folder contains the source code for the project." >> "$projectFolder/src/README.md"
echo "Please refer to individual subfolders for specific details." >> "$projectFolder/src/README.md"

# Add folder structure to README.md in root directory
echo "# Node.js with TypeScript Starter

This is a starter project for Node.js with TypeScript.

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

" > "$projectFolder/README.md"

# Create index.ts files in each subfolder to export modules
echo "export * from './greeting.controller';" > "$projectFolder/src/controllers/index.ts"
echo "export * from './greeting.route';" > "$projectFolder/src/interfaces/index.ts"
echo "export * from './index';" > "$projectFolder/src/middlewares/index.ts"
echo "export * from './greeting.service';" > "$projectFolder/src/services/index.ts"
echo "export * from './helpers';" > "$projectFolder/src/utils/index.ts"

echo "Adding details to files successfully.."

sleep 2

echo "Installing dependencies.."

# Initialize Node.js project
cd "$projectFolder" || exit

# Create package.json file
cat <<EOF > "./package.json"
{
  "name": "$projectName",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "start:dev": "ts-node-dev --respawn --transpile-only src/server.ts",
    "start": "node build/server.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
EOF

# Install TypeScript and type definitions for Node.js
npm install typescript @types/node --save-dev

# Install ts-node-dev and type definitions for it
npm install ts-node-dev --save-dev

# Initialize TypeScript project
npx tsc --init

# rm tsconfig.json
rm tsconfig.json

# Remove everything from tsconfig.json file and add the following
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
    // "typeRoots": ["node_modules/@types
  }
}
EOF

# Install express and type definitions for express
npm install express @types/express --save

# Install swagger, swagger ui, swagger jsdoc and type definitions for them
npm install swagger-ui-express swagger-jsdoc @types/swagger-ui-express @types/swagger-jsdoc --save

# Install morgan and type definitions for it
npm install morgan @types/morgan --save

# Create swagger.ts file
touch "./src/swagger.ts"

# Add the following to swagger.ts file
cat <<EOF > "./src/swagger.ts"
import swaggerJsdoc from "swagger-jsdoc";

const options = {
  definition: {
    openapi: "3.1.0",
    info: {
      title: "Type Script Node Starter API",
      version: "1.0.0",
      description: "API for TypeScript API End Point Documentation",
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

# Create controllers
echo "import { Request, Response } from 'express';

export function getGreetings(req: Request, res: Response) {
  res.json({ message: 'Hello World!🌍' });
}" > "./src/controllers/greeting.controller.ts"

# Create services
echo "export async function getAllGreetings() {
  return [];
}" > "./src/services/greeting.service.ts"

# Create routes
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

module.exports = router;" > "./src/routes/greeting.route.ts"

# Create app.ts file
echo "import express from 'express';
require('dotenv').config();
import { readdirSync } from 'fs';
import { join } from 'path';
import morgan from 'morgan';

const swaggerUi = require('swagger-ui-express');
const swaggerOptions = require('./swagger');

const app = express();
const port = process.env.PORT || 3000;

app.use(morgan('dev'));

// Swagger UI
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerOptions));

// Dynamically serve all routes
readdirSync('./src/routes').map((path) => {
    app.use('/api/v1/', require(\`./routes\${path}\`));
});

app.listen(port, () => {
  console.log(\`Server is running on port \${port}\`);
});" > "./src/app.ts"

echo "Setting up greetings API successfully."

sleep 2

echo "TypeScript Node Server and all folder structure have been created successfully in '$projectFolder'."

echo "Running the server.."

# If the server has git initialized, then push to git
if [ -d ".//.git" ]; then
    echo "Git is initialized."

    # Check if remote is set
    if [ -z "$(git -C "./" remote show origin)" ]; then
        echo "Remote is not set."
        echo "Please set the remote to sync."
    fi
else
    echo "Git is not initialized."
    echo "Initializing git in '$projectFolder'.."
    git -C "./" init
    echo "Git initialized successfully in '$projectFolder'."
fi

echo "Adding git ignore.."

# Pull node ts git ignore
curl https://raw.githubusercontent.com/github/gitignore/master/Node.gitignore --output "$./.gitignore"	

echo "Pushing to git.."

# Push to git
git -C "./" add .
git -C "./" commit -m "Initial commit"

if git -C "./" remote show origin > /dev/null 2>&1; then
    git -C "./" push
    echo "Pushed to git successfully."
else
    echo "Remote is not set."
    echo "Please set the remote to sync."
fi

sleep 2

echo "Running the server.."

# Run the server and check if it works
npm run start:dev
