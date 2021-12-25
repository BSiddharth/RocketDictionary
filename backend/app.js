const express = require("express");
const app = express();
const port = 3000;
require("dotenv").config();
const connectToDB = require("./connectDB");

app.get("/", (req, res) => {
  res.send("Hello World!");
});

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
