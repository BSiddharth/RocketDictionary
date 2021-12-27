const mongoose = require("mongoose");
const rocketSchema = new mongoose.Schema(
  {
    name: String,
  },
  {
    collection: "Rocket",
  }
);

const RocketModel = mongoose.model(
  "Rocket", // This name is pluralized (is this even a word?) by default but if collection is passed as an option to the schema that name is used as collection name
  rocketSchema
);

module.exports = RocketModel;
