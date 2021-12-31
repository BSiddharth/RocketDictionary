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

const flattenTheDict = (originalDict, currentList) => {
  currentList.push({
    title: originalDict["title"],
    content: originalDict["content"],
  });
  if (originalDict["items"] !== undefined) {
    originalDict["items"].forEach((ele) => {
      currentList = flattenTheDict(ele, currentList);
    });
  }
  return currentList;
};

const countryFlagsUrl = {
  Brazil: "https://img.icons8.com/color/2x/brazil-circular.png",
  China: "https://img.icons8.com/color/2x/china-circular.png",
  PRC: "https://img.icons8.com/color/2x/china-circular.png",
  Europe: "https://img.icons8.com/color/2x/flag-of-europe.png",
  "European Space Agency": "https://img.icons8.com/color/2x/flag-of-europe.png",
  France: "https://img.icons8.com/color/2x/france-circular.png",
  IRN: "https://img.icons8.com/color/2x/iran-circular.png",
  Iran: "https://img.icons8.com/color/2x/iran-circular.png",
  India: "https://img.icons8.com/color/2x/india-circular.png",
  Israel: "https://img.icons8.com/color/2x/israel-circular.png",
  Italy: "https://img.icons8.com/color/2x/italy-circular.png",
  Japan: "https://img.icons8.com/color/2x/japan-circular.png",
  "United States (design),Japan (production)":
    "https://img.icons8.com/color/2x/japan-circular.png",
  "New Zealand": "https://img.icons8.com/color/2x/new-zealand-circular.png",
  "North Korea": "https://img.icons8.com/color/2x/north-korea-circular.png",
  Russia: "https://img.icons8.com/color/2x/russian-federation-circular.png",
  "Soviet Union":
    "https://img.icons8.com/color/2x/russian-federation-circular.png",
  USSR: "https://img.icons8.com/color/2x/russian-federation-circular.png",
  "USSR , Russia":
    "https://img.icons8.com/color/2x/russian-federation-circular.png",
  "Union of Soviet Socialist Republics":
    "https://img.icons8.com/color/2x/russian-federation-circular.png",
  "South Korea": "https://img.icons8.com/color/2x/south-korea-circular.png",
  Spain: "https://img.icons8.com/color/2x/spain2-circular.png",
  UKR: "https://img.icons8.com/color/2x/ukraine-circular.png",
  Ukraine: "https://img.icons8.com/color/2x/ukraine-circular.png",
  "United Kingdom":
    "https://img.icons8.com/color/2x/great-britain-circular.png",
  "United States": "https://img.icons8.com/color/2x/usa-circular.png",
  Rest: "https://img.icons8.com/color/2x/globe.png",
};

const addCountryFlags = async () => {
  var count = 0;

  try {
    await connectToDB(process.env.connectionString);
    console.log("Connected to the database");
    for await (const rocket of RocketModel.find()) {
      const cor = rocket.countryOfOrigin;
      let corImageLink = "https://img.icons8.com/color/2x/globe.png";
      if (cor in countryFlagsUrl) {
        corImageLink = countryFlagsUrl[cor];
      }
      rocket.countryOfOrigin = corImageLink;
      await rocket.save();
      count++;
    }
  } catch (error) {
    console.log(error);
  } finally {
    mongoose.connection.close();
    console.log(`${count} rockets updated`);
    console.log("DB connection closed");
  }
};
const addRocketData = async () => {
  var count = 0;
  try {
    await connectToDB(process.env.connectionString);
    await RocketModel.deleteMany();
    console.log("Connected to the database");
    rocketTitleSet = await getRocketTitle();
    console.log("Rocket title set retreived");
    console.log("Adding data to the database");
    for (const rocketTitle of rocketTitleSet) {
      try {
        console.log(`Adding ${rocketTitle} to the database`);
        const page = await wiki().page(rocketTitle);
        const summary = await page.summary();
        const mainImage = await page.mainImage();
        const title = page.title;
        const allImages = await page.images();
        let images = allImages.filter((link) => link.indexOf("svg") === -1);
        const info = (await page.fullInfo())["general"];
        let content = await page.content();
        let contentList = content.map((ele) => {
          return flattenTheDict(ele, []);
        });
        const rocket = new RocketModel({
          name: title,
          summary: summary,
          content: contentList,
          images: images,
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
    await addCountryFlags();
  }
};

addRocketData();
