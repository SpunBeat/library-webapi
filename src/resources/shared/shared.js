module.exports = {
    processQuery
};

function processQuery(error, results, res) {
    if (error) {
        return res.status(400).json({error});
    }
    const [data] = results;
    res.json({
        data
    })
}