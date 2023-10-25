const booksController = require('./books.controller');

module.exports = function(app) {

    app.get('/libros', booksController.v1.getBooks);

    

}