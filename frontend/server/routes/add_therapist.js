const _ = require('lodash');
const Therapist = require('../models/Therapist');

const add_therapist = async (req, res) => {
    const therapist = req.body;
    try {
        
        const dbInstance = await Therapist.create(therapist);
        //const responseDbInstance = _.omit(dbInstance.dataValues, ['password', 'createdAt', 'updatedAt']);
        res.send(dbInstance);
    } catch (err) {
        if (err.original && err.original.errno === 1062) {
            res.status(400).send({ code: err.original.code });
        } else
            res.sendStatus(400);
    }
};

module.exports = add_therapist;