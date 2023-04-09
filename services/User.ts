import bcrypt from 'bcryptjs';
const jwt = require("jsonwebtoken");


// validation
const validator = require("validator");
const pwRules = new RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/);
const validateSignup = (email, password) => {
  // Email
  if (!validator.isEmail(email)) return false;
  // Password
  else if (!pwRules.test(password)) return false;
  // Success
  else return true;
}


// query database
async function getAccount(email = null) {
  // 1. find by either: email or id
  const where = email ? { email } : { id: this.id };
  // 2. perform query
  const [user] = await this._list("*", where);
  // 3. nothing returned
  if (!user) return null;
  // 4. user found
  this.data = user;
  this.id = user.id;
  return user;
}


async function tryPassword(email = null, password = null) {
  // search by email if logging in or id for other reason
  const where = email ? { email } : { id: this.id };

  // perform query
  const [user] = await this._list("*", where);

  // todo: replace lines ABOVE with: const user = await this.getAccount(email);

  // nothing returned
  // todo: not supposed to handle http errors at service level, just throw message
  if (!user) throw "No account found under this email";

  // submitted password incorrect
  else if (email && !bcrypt.compareSync(password, user.password)) throw "Incorrect password.";

  this.data = user;
  this.id = user.id;

  return user;
}

async function register(newUser, accountType = "email") {

  let submission = newUser;

  if (accountType === "email") {

    // todo: move validation to route/json middleware
    if (validateSignup(newUser.email, newUser.password)) {
      submission.avatar_img = "http://s3.amazonaws.com/37assets/svn/765-default-avatar.png";
      // Hash the password: (password, saltRounds)
      submission.password = bcrypt.hashSync(newUser.password, 10);
    }
    else throw "Invalid submission";

  } else if (accountType === "google") {
    console.log("the account type is google")
  } else if (accountType === "apple") {
    console.log("the account type is apple")
  } else {
    throw "Error registering new user! No accountType submitted";
  }


  // 2. Insert the user into the DB
  const [createdUser] = await this._create(submission);
  return createdUser;

}