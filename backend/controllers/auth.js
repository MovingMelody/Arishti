const User = require("../models/user");

exports.signup = (req, res) => {
  // creating a new user using the model User
  const user = new User(req.body); // saving the user to db
  user.save((err, user) => {
    // if err occurs while saving the user to db we throw an error
    if (err) {
      return res.status(400).json({
        err: "Not able to save user in db",
      });
    }
    // if there are no errors we are just returning the some user data as a response
    // res.json(user);
    res.json({
      name: user.name,
      email: user.email,
      id: user._id,
    });
  });
};

exports.signin = (req, res) => {
  const { email, password } = req.body;
  User.findOne({ email, password }, (err, user) => {
    if (err || !user) {
      return res.status(400).json({
        error: "check your email and password",
      });
    } else {
      res.json(user);
    }
  });
};

// to delete the data
exports.deleteUserdata = (req, res) => {
  const userTobeRemoved = req.profile;
  userTobeRemoved.remove((err, deletedUser) => {
    if (err) {
      return res.status(400).json({
        error: "Unable to delete the user",
      });
    }
    return res.json({
      message: `successfully deleted the ${deletedUser.email} user`,
    });
  });
};
