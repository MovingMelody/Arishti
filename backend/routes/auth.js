var express = require("express");
const { signup, signin, deleteUserdata } = require("../controllers/auth");
var router = express.Router();

router.post("/signup", signup);
router.post("/signin", signin);
// router.post("/deleteUser", deleteUserdata);

module.exports = router;
