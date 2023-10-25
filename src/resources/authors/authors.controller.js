const pool = require('../../core/db');
const axios = require('axios');
const shared = require('../shared/shared');

// Patron Controller
module.exports = {
    v1: {
        getAuthors,
        getAuthorWithBooks
    }
};

async function getAuthors(req, res) {
    try {
        const response = await axios.get('http://localhost:8080/authors/all'); 
        const data = response.data;
        res.json(data);
      } catch (error) {
        console.error(error);
        res.status(500).send('Error al consultar el servicio REST.');
      }
}

async function getAuthorWithBooks(req, res) {
    try {
        const {nombre, apellido} = req.query;
        const response = await axios.get('http://localhost:8080/authors/books?nombre=' + nombre + '&apellido=' + apellido); 
        const data = response.data;
        res.json(data);
      } catch (error) {
        console.error(error);
        res.status(500).send('Error al consultar el servicio REST.');
      }
}