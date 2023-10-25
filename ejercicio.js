function eresMayorDeEdadPromise(edad, pais) {
    return new Promise((resolve, reject) => {
        const fn = () => {
            let payload = {
                mayorDeEdad: edad >= 18,
                pais
            };
            if (pais === 'USA') {
                payload.mayorDeEdad = edad >= 21;
            }
            resolve(payload);
        };
        setTimeout(fn, 3000);
    });
}

const handlerMayorEdad = payload => payload;
const extractCountry = payload => payload.pais;
const realNameCountry = countryCode => {
    let countryName = '';
    if (countryCode === 'MX') {
        countryName = 'Mexico';
    }
    if (countryCode === 'USA') {
        countryName = 'Estados Unidos';
    }
    return countryName;
};

eresMayorDeEdadPromise(18, 'MX')
    .then(handlerMayorEdad)
    .then(extractCountry)
    .then(realNameCountry)
    .then(data => {
        console.log(data);
    });

