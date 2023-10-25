const authorsController = require('./authors.controller');


// Patron routes
module.exports = function(app) {

    app.get('/authors', authorsController.v1.getAuthors);
    app.get('/authors/books', authorsController.v1.getAuthorWithBooks);

}