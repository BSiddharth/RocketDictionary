var express = require("express");
var router = express.Router();
const wiki = require("wikijs").default;
const Glossary = require("../models/glossary");

router.get("/glossary", async (req, res) => {
  const glossaries = await Glossary.find().sort({ name: 1 });
  res.json(glossaries);
});

router.get("/wiki", async (req, res) => {
  const summary = await (await wiki().page("Ariane_5")).summary();
  const content = await (await wiki().page("Ariane_5")).content();

  res.json({ summary, content });
});
module.exports = router;
