const _ = require('lodash');
const Interest = require('../models/Interest');

const add_interest = async (req, res) => {
    const interest = req.body;
    try {
        
        const dbInstance = await Interest.create(interest);
        //const responseDbInstance = _.omit(dbInstance.dataValues, ['password', 'createdAt', 'updatedAt']);
        res.send(dbInstance);
    } catch (err) {
        if (err.original && err.original.errno === 1062) {
            res.status(400).send({ code: err.original.code });
        } else
            res.sendStatus(400);
    }
};

module.exports = add_interest;