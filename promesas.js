// 1.
function simulatedConsult(callback) {
    console.log('Consulta iniciada');
    let usuarios = 0;
    let libros = 0;

    setTimeout(() => {
        usuarios = 5;
        libros = 2;
        callback(libros, usuarios);
        console.log('Consulta terminada!');
    }, 3000);
}

const handlerConsult = (librosActuales, usuariosActuales) => {
    console.log({usuariosActuales});
};

// simulatedConsult(handlerConsult);

// 2.
function eresMayorDeEdad(edad, pais, callback) {

    const fn = () => {
        let payload = {
            mayorDeEdad: edad >= 18,
            pais
        };
        if (pais === 'USA') {
            payload.mayorDeEdad = edad >= 21;
        }
        if (typeof callback === 'function') {
            return callback(payload);
        }
    };

    setTimeout(fn, 3000);
}

const handlerMayorEdad = (payload) => {
    console.log(payload);
};

eresMayorDeEdad(18, 'MX', handlerMayorEdad);

const promiseConstructor = (resolve, reject) => {
    setTimeout(() => {
        reject('Terminado en Error');
    }, 3000);
};

const promise = new Promise(promiseConstructor);

const handlerSuccess = (valor) => {
    console.log({valor});
};

const handlerFailure = (error) => {
    console.log({error});
};

promise
    .then(handlerSuccess)
    .catch(handlerFailure);


