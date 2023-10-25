const mysql = require('mysql2');

const configConnection = {
    host: 'localhost',
    user: 'myuser',
    password: 'mypassword',
    database: 'library_example'
};

const pool = mysql.createPool(configConnection);

module.exports = pool;