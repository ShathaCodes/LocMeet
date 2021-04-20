const _ = require('lodash');
const Interest = require('../models/Interest');
const User = require('../models/User');
const Location = require('../models/Location');

const register = async (req, res) => {
    const user = req.body;
    const interests = req.body.interests;
    delete user.interests;
    try {
        
        const dbInstance = await User.create(user);
        for (const item of interests) { 
            if(Number.isInteger(parseInt(item))) {
            var id = item;
            const inter = await Interest.findOne({ where: { id } });
            await dbInstance.addInterest(inter);
            }
          }
          var loc = await  Location.create({
            lat:0.5,
            lng:0.7,
        });
        loc.setUser(dbInstance);
        const responseDbInstance = _.omit(dbInstance.dataValues, ['password', 'createdAt', 'updatedAt']);
        res.send(responseDbInstance);
    } catch (err) {
        if (err.original && err.original.errno === 1062) {
            if(err.original.code == "ER_DUP_ENTRY")
            res.status(403).send({ code: err.original.code });
            else
            res.status(400).send({ code: err.original.code });
        } else
            res.sendStatus(400);
    }
};

module.exports = register;
