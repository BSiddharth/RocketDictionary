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

const Glossary = mongoose.model("Glossary", glossarySchema);

module.exports = Glossary;
