const pool = require('../../core/db');
const {processQuery} = require('../shared/shared');
module.exports = {
    getBooksCallback,
    getBooksPromise
};

function getBooksCallback(req, res) {
    const query = req.query;
    const authorFirstName = query.nombre;
    const authorLastName = query.apellido;

    // 1. storeProcedureName = string que se refiere al nombre del SP
    let storeProcedureName = 'CALL GetAllBooks()';

    // 2. params = al arreglo de parametros que puede recibir el SP
    let params = [];

    // 3. callbackEjemplo = callback, se ejecuta una vez que el query termine
    const callbackEjemplo = (error, results) => {
        processQuery(error, results, res);
    };

    if (authorFirstName && authorLastName) {
        params = [authorFirstName, authorLastName];
        storeProcedureName = 'CALL GetBooksByAuthor(?, ?)';
    }

    pool.query(
        storeProcedureName,
        params,
        callbackEjemplo
    );
}

function getBooksPromise(req, res) {
    const query = req.query;
    const authorFirstName = query.nombre;
    const authorLastName = query.apellido;

    // 1. storeProcedureName = string que se refiere al nombre del SP
    let storeProcedureName = 'CALL GetAllBooks()';

    // 2. params = al arreglo de parametros que puede recibir el SP
    let params = [];

    if (authorFirstName && authorLastName) {
        params = [authorFirstName, authorLastName];
        storeProcedureName = 'CALL GetBooksByAuthor(?, ?)';
    }

    return new Promise((resolve, reject) => {
        pool.query(
            storeProcedureName,
            params,
            (error, results) => {
                if (error) {
                    reject(error);
                }
                const [data] = results;
                resolve(data);
            }
        );
    });
}