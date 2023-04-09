const jwt = require("jsonwebtoken");
import express, { Request, Response, Next } from 'express';
// const server = express();

const auth = (req: Request, res: Response, next: Next) => {

}


export default auth;

// todo: run a database check using Session.js service to make sure that session is still valid and user exists.

// If true, returns authData; if false, returns false
const isTokenValid = (token) => {
  return jwt.verify(token, process.env.JWT_SECRET, (err, authData) => {
    if (err) return false;
    else return authData;
  });
};

const checkAuth = (req, res, next) => {
  try {
    const authHeaders = req.headers["authorization"];
    if (!authHeaders) throw "No header for 'authorization'.";

    const bearer = authHeaders.split(" ");
    const bearerToken = bearer[1];

    console.log("Header Bearer Token", bearerToken);

    const { userId = false, isVendor = undefined} = isTokenValid(bearerToken);

    // if userId or isVendor are undefined it's a bad token
    if (!userId || isVendor === undefined) throw "Token missing parameters"

    req.userId = userId;
    req.isVendor = isVendor;
    req.token = bearerToken;
    console.log("User ID", req.userId, "isVendor", isVendor);

    next();
    
  } catch (error) {
    res.status(401).json({message: error});
  }
};

module.exports = checkAuth;