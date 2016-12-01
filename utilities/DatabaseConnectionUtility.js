var mysql = require('mysql');
 
console.log('dev properties: \n', 
  process.env.DEV_DATABASE_URL, '\n', 
  process.env.DEV_DATABASE_USERNAME, '\n', 
  process.env.DEV_DATABASE_PASSWORD, '\n',
  process.env.DATABASE_NAME
);

console.log('prod properties: \n', 
  process.env.CLEARDB_DATABASE_URL, '\n', 
  process.env.PROD_DB_USERNAME, '\n', 
  process.env.PROD_DB_PASSWORD, '\n',
  process.env.PROD_DB_NAME
);

var connection = mysql.createConnection({
  host: process.env.DEV_DATABASE_URL,
  user: process.env.DEV_DATABASE_USERNAME,
  password: process.env.DEV_DATABASE_PASSWORD,
  database: process.env.DATABASE_NAME
})

connection.connect(function(err){
  if(err){
    console.log('Error in database connection');
    throw err;
  }else{
    console.log('Successfully connected to database');
  }
});

function getConnection(){
  return connection;
}
module.exports = {
  getConnection: getConnection
}