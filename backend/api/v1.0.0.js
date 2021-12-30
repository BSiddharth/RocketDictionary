var express = require("express");
var router = express.Router();
const wiki = require("wikijs").default;
const GlossaryModel = require("../models/glossary");
const RocketModel = require("../models/rocket");

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

router.get("/glossary", async (req, res) => {
  const glossaries = await GlossaryModel.find().sort({ name: 1 });

  res.json(glossaries);
});

router.get("/rockets", async (req, res) => {
  const rockets = await RocketModel.find().sort({ name: 1 });

  res.json(rockets);
});
router.get("/test", async (req, res) => {
  const content = await (await wiki().page("Angara (rocket family)")).content();
  let contentList = content.map((ele) => {
    return flattenTheDict(ele, []);
  });

  // res.json(content);
  res.json(contentList);
});
module.exports = router;
