var express = require("express");
var router = express.Router();
const wiki = require("wikijs").default;
const GlossaryModel = require("../models/glossary");

router.get("/glossary", async (req, res) => {
  const glossaries = await GlossaryModel.find().sort({ name: 1 });

  res.json(glossaries);
});

router.get("/rockets", async (req, res) => {
  const page = await wiki().page("Ariane 5");
  const summary = await page.summary();
  const content = await page.content();
  const mainImage = await page.mainImage();
  const title = page.title;
  res.json({ title, summary, content, mainImage });

  // const result = await (await wiki().page("Long_March_2C"))
  //   .chain()
  //   .summary()
  //   .content()
  //   .image()
  //   .request();
  // res.json(result);
});
module.exports = router;
