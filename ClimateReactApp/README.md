# ClimateReactApp

This project is a React application that displays climate data in a table format. It connects to the `http://localhost:1111/api/climates` REST API to fetch the data.

## Project Structure

```
ClimateReactApp
├── public
│   └── index.html
├── src
│   ├── components
│   │   └── ClimateTable.js
│   ├── services
│   │   └── ClimateService.js
│   ├── App.js
│   ├── App.css
│   └── index.js
├── .env
├── package.json
└── README.md
```

## Files

- `public/index.html`: Entry point of the React application.
- `src/components/ClimateTable.js`: React component to display climate data in a table format.
- `src/services/ClimateService.js`: Service class to connect to the `http://localhost:1111/api/climates` REST API.
- `src/App.js`: Main component of the React application.
- `src/App.css`: CSS styles for the `App` component and its child components.
- `src/index.js`: Entry point of the React application.
- `.env`: Environment variables for the project.
- `package.json`: Configuration file for npm.
- `README.md`: Documentation for the project.

## Setup

1. Clone the repository.
2. Install the dependencies using `npm install`.
3. Set the API endpoint URL in the `.env` file.
4. Start the development server using `npm start`.

## Usage

- Open the application in your browser.
- The climate data will be fetched from the API and displayed in a table format.

Feel free to modify and customize the project according to your needs.