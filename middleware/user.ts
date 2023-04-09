/*

User middleware

if bearer token = valid

add to req object as req.user:{
  id: string,
  email: string,
  name: string,
  permissions: {},
  settings: {
    submissionProcessingApps: [],
    notifications: {}
  }
}


*/