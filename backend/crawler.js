const axios = require("axios");
const cheerio = require("cheerio");
const RocketModel = require("./models/rocket");
const wiki = require("wikijs").default;
const connectToDB = require("./connectDB");
require("dotenv").config();
const mongoose = require("mongoose");

const getRocketTitle = async () => {
  try {
    const { data } = await axios.get(
      "https://en.wikipedia.org/wiki/Comparison_of_orbital_launch_systems"
    );
    const $ = cheerio.load(data);
    const rocketTitleSet = new Set();

    $("#mw-content-text > div.mw-parser-output > table > tbody > tr").each(
      (_idx, el) => {
        rocketTitle = $($($(el).find("td")[0]).find("a")[0]).attr("title");
        if (
          rocketTitle !== undefined &&
          rocketTitle.indexOf("(page does not exist)") === -1
        ) {
          rocketTitleSet.add(rocketTitle);
        }
      }
    );
    console.log(`length of rocketTitleSet is ${rocketTitleSet.size}`);
    return rocketTitleSet;
  } catch (error) {
    console.log("Rocket title set retreivement (is that even a word) failed");
    console.log(error);
  }
};
const addRocketData = async () => {
  var count = 0;
  try {
    await connectToDB(process.env.connectionString);
    console.log("Connected to the database");
    rocketTitleSet = await getRocketTitle();
    console.log("Rocket title set retreived");
    console.log("Adding data to the database");
    for (const rocketTitle of rocketTitleSet) {
      try {
        console.log(`Adding ${rocketTitle} to the database`);
        const page = await wiki().page(rocketTitle);
        const summary = await page.summary();
        const content = await page.content();
        const mainImage = await page.mainImage();
        const info = await page.info();
        const title = page.title;
        const rocket = new RocketModel({
          name: title,
          summary: summary,
          content: content,
          manufacturer:
            typeof info["manufacturer"] === "object"
              ? "Many"
              : info["manufacturer"],
          mainImage: mainImage,
          countryOfOrigin:
            typeof info["countryOrigin"] === "object"
              ? "Many"
              : info["countryOrigin"],
          costPerLaunch:
            typeof info["cpl"] === "object" ? "Varies" : info["cpl"],
          type:
            typeof info["function"] === "object"
              ? "Launch Vehicle"
              : info["function"],
          status:
            typeof info["status"] === "object" ? "Varies" : info["status"],
        });
        await rocket.save();
        console.log(`${rocketTitle} was added to the database`);
        count++;
      } catch (error) {
        console.log(`${rocketTitle} was not added to the database!!!`);
        console.log(error);
      }
    }
  } catch (error) {
    console.log(
      "Either connection to the DB failed or rocket title set retreivement (is that even a word) failed"
    );
    console.log(error);
  } finally {
    console.log(`${count} rockets added to the DB`);
    mongoose.connection.close();
    console.log("DB connection closed");
  }
};

addRocketData();
