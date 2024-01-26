#!/bin/bash

echo "Starting Yara Yara: A TS Node Express Quick Start Script."

sleep 2

echo "Creating TypeScript Node Server and all folder structure.."

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
  "name": "node-typescript-starter",
  "version": "1.0.0",
  "description": "A starter project for Node.js with TypeScript",
  "main": "app.js",
  "scripts": {
    "start:dev": "ts-node-dev --respawn --transpile-only ./src/app",
    "start": "node ./build/app.js"
  },
  "keywords": [
	"node",
	"typescript"
  ],
  "author": "HighB33Kay",
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

# Add details to README.md in src directory
echo "# Source Folder" > src/README.md
echo "This folder contains the source code for the project." >> src/README.md
echo "Please refer to individual subfolders for specific details." >> src/README.md

# add folder structure to README.md in root directory
cat <<EOF > README.md
# Node.js with TypeScript Starter

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

echo "TypeScript Node Server and all folder structure has been created successfully."

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

sleep 2

echo "Running the server.."

# run the server and check if it works
npm run start:dev