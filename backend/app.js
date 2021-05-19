require("dotenv").config();

const express = require("express");
const mongoose = require("mongoose");
const app = express();
const cors = require("cors"); // middleware

const authRoutes = require("./routes/auth");

// db connection
mongoose
  .connect(process.env.DATABASE, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
  })
  .then(() => {
    console.log("CONNECTED TO DB");
  })
  .catch(() => {
    console.log("NOT CONNECTED TO DB");
  });

// middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

// routes here
app.use("/arishti", authRoutes);

// port
const port = 8080;

// starting a server
app.listen(port, () => {
  console.log(`App is running at ${port}`);
});
