const express = require('express')
const cors = require('cors');
const app = express()

const authorsRoutes = require('./src/resources/authors/authors.routes');
const booksRoutes = require('./src/resources/books/books.routes');


app.use(express.json());

app.use(cors());

// Middleware pars CORS
app.use(function(req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', ['http://localhost:4200']);
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
    res.setHeader('Access-Control-Allow-Credentials', true);
    next();
});


// Patron Middleware
authorsRoutes(app);
booksRoutes(app);


app.get('/', function (req, res) {
    res.json({
        api: '1.0.0'
    })
})
  
app.listen(3000, () => {
    console.log('Servidor funcionando');
});