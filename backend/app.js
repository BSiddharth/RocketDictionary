const express = require("express");
const app = express();
const port = 8000;
require("dotenv").config();
const connectToDB = require("./connectDB");
const v1api = require("./api/v1.0.0");

app.use("/api/v1.0.0/", v1api);

const start = async () => {
  try {
    await connectToDB(process.env.connectionString);
    app.listen(port, () => {
      console.log(`Server listening at http://localhost:${port}`);
    });
  } catch (error) {
    console.log(error);
  }
};

start();
