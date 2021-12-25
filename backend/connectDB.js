const mongoose = require("mongoose");

const credentials = "userAuthCertificate.pem";
const connect = (url) => {
  return mongoose.connect(url, {
    sslKey: credentials,
    sslcert: credentials,
  });
};

module.exports = connect;
