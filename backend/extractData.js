const axios = require("axios");
const cheerio = require("cheerio");

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
    console.log(rocketTitleSet);
  } catch (error) {
    console.log(error);
  }
};

getRocketTitle();
