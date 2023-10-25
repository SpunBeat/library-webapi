const booksService = require('./books.service');

module.exports = {
    v1: {
        getBooks
    }
};

async function getBooks(req, res) {
    try {
        const data = await booksService.getBooksPromise(req, res);
        res.json({data});
    } catch (error) {
        res.status(400).json({error});
    }
}