var express = require("express");
var router = express.Router();
const wiki = require("wikijs").default;
const GlossaryModel = require("../models/glossary");
const RocketModel = require("../models/rocket");

router.get("/glossary", async (req, res) => {
  const glossaries = await GlossaryModel.find().sort({ name: 1 });

  res.json(glossaries);
});

router.get("/rockets", async (req, res) => {
  const rockets = await RocketModel.find().sort({ name: 1 });
  // console.log(rockets);

  res.json(rockets);
});
module.exports = router;
