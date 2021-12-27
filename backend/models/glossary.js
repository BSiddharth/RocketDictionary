const mongoose = require("mongoose");
const glossarySchema = new mongoose.Schema(
  {
    name: String,
    definition: String,
  },
  {
    collection: "Glossary",
  }
);

const GlossaryModel = mongoose.model(
  "Glossary", // This name is pluralized (is this even a word?) by default but if collection is passed as an option to the schema that name is used as collection name
  glossarySchema
);

module.exports = GlossaryModel;
