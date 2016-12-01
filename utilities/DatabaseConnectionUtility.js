var mysql = require('mysql');

var connection;

var dbConfig = process.env.CLEARDB_DATABASE_URL || { 
  host: process.env.DEV_DB_URL,
  user: process.env.DEV_DB_USERNAME,
  password: process.env.DEV_DB_PASSWORD,
  database: process.env.DATABASE_NAME
};

function connectToDatabase(){
  connection = mysql.createConnection(dbConfig);
  
  connection.connect(function(err){
    if(!err){
      console.log('Successfully connected to database');
    }
  });

  connection.on('error', function(err){
    console.log('Error occurred in database connection!');
    if(err.code === 'PROTOCOL_CONNECTION_LOST') {
      handleDBDisconect();
    }else {
      throw err;
    }
  });
  return connection;
}

function handleDBDisconect(){
  console.log('handleDBDisconect called');
  connectToDatabase();
}

function getConnection(){
  return connection;
}

module.exports = {
  getConnection: getConnection,
  createConnection: connectToDatabase
}