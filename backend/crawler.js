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
    return rocketTitleSet;
  } catch (error) {
    console.log(error);
  }
};
const addRocketData = async () => {
  try {
    console.log("Adding data to the database");
    await connectToDB(process.env.connectionString);
    rocketTitleSet = await getRocketTitle();
    await Promise.all(
      [...rocketTitleSet].map(async (rocketTitle) => {
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
        } catch (error) {
          console.log(error);
        }
      })
    );
  } catch (error) {
    console.log(error);
  } finally {
    mongoose.connection.close();
    console.log("Data added into the database");
  }
};

addRocketData();
