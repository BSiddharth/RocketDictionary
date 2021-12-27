var express = require("express");
var router = express.Router();
const wiki = require("wikijs").default;
const GlossaryModel = require("../models/glossary");

router.get("/glossary", async (req, res) => {
  const glossaries = await GlossaryModel.find().sort({ name: 1 });

  res.json(glossaries);
});

router.get("/rockets", async (req, res) => {
  // const page = await wiki().page("Soyuz_(rocket_family)");
  // const page = await wiki().page("Falcon 9");
  const page = await wiki().page("Ariane 5");
  // const page = await wiki().page("GSLV_Mark_III");
  const summary = await page.summary();
  const content = await page.content();
  const mainImage = await page.mainImage();
  const info = await page.info();
  const title = page.title;
  const manufacturer = info["manufacturer"];
  const countryOfOrigin = info["countryOrigin"];
  const costPerLaunch = info["cpl"];
  const type = info["function"];
  const status = info["status"];
  console.log(
    typeof summary,
    typeof content,
    typeof mainImage,
    typeof info,
    typeof title,
    typeof manufacturer,
    typeof countryOfOrigin,
    typeof costPerLaunch,
    typeof type,
    typeof status
  );
  res.json({
    summary,
    content,
    mainImage,
    info,
    title,
    manufacturer,
    countryOfOrigin,
    costPerLaunch,
    type,
    status,
  });

  // const page = await wiki().page("Falcon 9");
  // const info = await page.info();
  // console.log(info["function"]);
  // // const content = await page.content();
  // // const mainImage = await page.mainImage();
  // // const title = page.title;
  // res.json({ info });
  // // res.json({ title, summary, content, mainImage });

  // // const result = await (await wiki().page("Long_March_2C"))
  // //   .chain()
  // //   .summary()
  // //   .content()
  // //   .image()
  // //   .request();
  // // res.json(result);
});
module.exports = router;
