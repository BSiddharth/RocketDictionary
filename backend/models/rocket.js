const mongoose = require("mongoose");
const rocketSchema = new mongoose.Schema(
  {
    name: String,
    summary: String,
    content: Object,
    images: Object,
    manufacturer: String,
    countryOfOrigin: String,
    costPerLaunch: String,
    type: String,
    status: String,
    mainImage: String,
    id: String,
  },
  {
    collection: "Rockets",
  }
);

const RocketModel = mongoose.model(
  "Rockets", // This name is pluralized (is this even a word?) by default but if collection is passed as an option to the schema that name is used as collection name
  rocketSchema
);

module.exports = RocketModel;
