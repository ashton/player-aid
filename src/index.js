import { Elm } from "./Main.elm";

const { API_URL } = process.env;

Elm.Main.init({
  flags: { apiUrl: API_URL, auth: false }
});
