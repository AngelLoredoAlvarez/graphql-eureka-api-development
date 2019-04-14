const express = require("express");
const { postgraphile } = require("postgraphile");
require("dotenv").config();

const PG_CONFIG = `postgres://${process.env.DB_USER}:${
  process.env.DB_USER_PASSWORD
}@${process.env.DB_HOST}:${process.env.DB_HOST_PORT}/${
  process.env.DB_DATABASE
}`;
const SCHEMA_NAME = "eureka_public";
const OPTIONS = {
  watchPg: process.env.NODE_ENV === "development",
  dynamicJson: true,
  setofFunctionsContainNulls: true,
  classicIds: false,
  disableDefaultMutations: true,
  ignoreRBAC: false,
  includeExtensionResources: false,
  showErrorStack: false,
  extendedErrors: ["detail", "hint", "errcode"],
  handleErrors: false,
  graphqlRoute: "/api/eureka",
  graphiqlRoute: "/graphiql",
  graphiql: process.env.NODE_ENV === "development",
  enhanceGraphiql: process.env.NODE_ENV === "development",
  enableCors: true,
  jwtSecret: process.env.JWT_SECRET,
  jwtPgTypeIdentifier: "eureka_private.jwt_token",
  disableQueryLog: process.env.NODE_ENV === "production"
};

const API_SERVER = express();

API_SERVER.use(postgraphile(PG_CONFIG, SCHEMA_NAME, OPTIONS));
API_SERVER.listen(8080);
